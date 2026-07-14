#!/usr/bin/env bash

dir="$HOME/.config/alacritty"
cfg="$dir/alacritty.toml"

rm "$dir" 2>/dev/null
mkdir -p "$dir"

if [ "$(uname)" == "Darwin" ]; then
  cat << EOF > "$cfg"
[window]
option_as_alt = 'Both'

[terminal.shell]
program = '/opt/homebrew/bin/bash'

[font]
size = 15

[font.normal]
family = 'AdwaitaMono Nerd Font'
EOF
else
  cat << EOF > "$cfg"
[terminal.shell]
program = '/bin/bash'

[font]
size = 13

[font.normal]
family = 'AdwaitaMono'
EOF
fi

cat << EOF >> "$cfg"

[window.dimensions]
columns = 80
lines = 24

[env]
TERM = 'xterm-256color'

[mouse]
hide_when_typing = true

[[hints.enabled]]
mouse.enabled = false
hyperlinks = false
post_processing = false
persist = false
command = ''
regex = ''

[cursor]
blink_interval = 750
blink_timeout = 0
thickness = 0.1

[cursor.style]
blinking = 'Always'
shape = 'Block'

[font.bold]
style = 'Regular'

[font.italic]
style = 'Regular'

[font.bold_italic]
style = 'Regular'

[colors]
draw_bold_text_with_bright_colors = true

[colors.footer_bar]
foreground = '0xcc7700'
background = '0x000000'

[colors.search.matches]
foreground = '0x000000'
background = '0xffff77'

[colors.search.focused_match]
foreground = '0xffffff'
background = '0xcc7700'

[colors.primary]
foreground = '0xffffff'
background = '0x000000'

[colors.normal]
black   = '0x000000'
red     = '0xcc0000'
green   = '0x00cc00'
yellow  = '0xcc7700'
blue    = '0x0000ff'
magenta = '0xcc00cc'
cyan    = '0x00cccc'
white   = '0xcccccc'

[colors.bright]
black   = '0x777777'
red     = '0xff7777'
green   = '0x77ff77'
yellow  = '0xffff77'
blue    = '0x7777ff'
magenta = '0xff77ff'
cyan    = '0x77ffff'
white   = '0xffffff'
EOF
