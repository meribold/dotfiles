-- See <https://github.com/brndnmtthws/conky/wiki/Lua-API>.

-- Conky's `format_time` function can't pad with leading zeros.  This one does.  I use it
-- to format the elapsed time and total duration of MPD's current song.
function conky_format_duration(object)
   s = tonumber(conky_parse("${" .. object .. "}"))
   return string.format("%d:%.2d", s / 60 % 60, s % 60)
end

-- vim: tw=90 sts=-1 sw=3 et
