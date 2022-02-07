function fish_prompt
   set -l stuff_in_brackets

   if test "$USER" != meribold -o "$hostname" != smial
      set -a stuff_in_brackets "$USER@$hostname"
   end

   if test "$PWD" != "$HOME"
      if test (string sub -l (string length "$HOME") "$PWD") = "$HOME"
         set -a stuff_in_brackets (string replace "$HOME" \~ "$PWD")
      else
         set -a stuff_in_brackets "$PWD"
      end
   end

   if test -n "$stuff_in_brackets"
      set_color brblack
      echo -n [
      set_color normal
      echo -n "$stuff_in_brackets"
      set_color brblack
      echo -n '] '
      set_color normal
   end

   set_color --bold
   if fish_is_root_user; echo -n '# '; else; echo -n '$ '; end
   set_color normal
end
