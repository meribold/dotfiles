-- charge monitor
--
-- Tiny script for the notion statusbar for displaying battery charge.
--
-- Place this in ~/.notion/ or /etc/notion/.

local defaults = {
    update_interval = 10000, -- ms
    path = "/sys/class/power_supply/BAT1/",
    filenames = {
        charge_now = "energy_now",
        status = "status",
    },
    charge_low = 256,
}

local settings=table.join(statusd.get_config("charge"), defaults)

local charge_timer=statusd.create_timer()

local function inform_charge(charge_now, status)
    if charge_now then
        statusd.inform("charge", charge_now .. " mWh")
    else
        statusd.inform("charge", "sorry...")
    end

    if status and status:find("Discharging") then
        if charge_now <= settings.charge_low then
            statusd.inform("charge_hint", "critical")
        else
            statusd.inform("charge_hint", "important")
        end
    else
        statusd.inform("charge_hint", "normal")
    end
end

local files = {charge_now, status,}

local function update_charge()
    files.charge_now = nil
    files.status = nil

    files.charge_now = io.open(settings.path .. settings.filenames.charge_now, "r")
    files.status = io.open(settings.path .. settings.filenames.status, "r")

    if files.charge_now then
        charge_now = tonumber(files.charge_now:read("*all")) / 1000
        if files.status then
            status = files.status:read("*all")
            files.status:close()
        end
        files.charge_now:close()
    end

    inform_charge(charge_now, status)
    charge_timer:set(settings.update_interval, update_charge)
end

update_charge()

-- vim: tw=90 sts=-1 sw=4 et
