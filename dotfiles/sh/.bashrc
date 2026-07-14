# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

if [[ "$OSTYPE" =~ "darwin" ]]; then
  if ! [[ "$PATH" =~ "/opt/homebrew/bin:" ]]; then
    export PATH="/opt/homebrew/bin:$PATH"
  fi
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
  export PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
  for rc in ~/.bashrc.d/*; do
    if [ -f "$rc" ]; then
      . "$rc"
    fi
  done
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
export SYSTEMD_PAGER=

unset rc

# ------------------------------------------------------------------------------

if [ -f "$HOME/.fzf.conf" ]; then
  . "$HOME/.fzf.conf"
fi

# ------------------------------------------------------------------------------

unalias -a 

export PS1='\[\033[0m\][\u@\h \W]\$ '

export LANG="en_US.UTF-8" 
export LC_CTYPE="en_US.UTF-8"

if [[ "$OSTYPE" =~ "darwin" ]]; then
  export BASH_SILENCE_DEPRECATION_WARNING=1
  export EDITOR=vi
  export VISUAL=vi
else
  export EDITOR=vimx
  export VISUAL=vimx
  alias vi=vimx
fi

alias ls='ls -p'
alias ip='ip -color=never'

alias cc='cc -masm=intel'
alias gcc='gcc -masm=intel'
alias objdump='objdump -M intel'

export NO_COLOR=1
export LS_COLORS=''
export TREE_COLORS=''

export MUSIC_DIR="$HOME/Music"
export NOTES_DIR="$HOME/.notes"
export BACKUP_DIR="$HOME/.backup"
export TRASH_DIR="$HOME/.local/share/Trash/files"

# ------------------------------------------------------------------------------

export GOPATH="$HOME/.go"
export PATH="$PATH:$GOPATH/bin"

# ------------------------------------------------------------------------------

export PAGER=less

export MANWIDTH=80
export MANLESS="\ Manual\ page\ \$MAN_PN\ ?ltline\ %lt?L/%L.:byte\ %bB?s/%s..?\ (END):?pB\ %pB\\%.."
export GROFF_NO_SGR=1

export LESS_TERMCAP_md=$'\E[0m' # No bold
export LESS_TERMCAP_us=$'\E[0m' # No underline

export LESS='--ignore-case --jump-target=.5 --tilde'

# ------------------------------------------------------------------------------

shopt -s histappend

export HISTCONTROL="ignoreboth:erasedups"

__history_uniqalize() {
  tmp="$(mktemp)"
  cat "$HISTFILE" | nowhitespace | noduplicatelines > "$tmp"
  mv "$tmp" "$HISTFILE"
}

trap '__history_uniqalize' EXIT

__history_select_and_insert() {
  if [ -z "$(history)" ]; then
    echo "History is empty" >&2
    return 1
  fi
  sel="$(history | sed 's/^\s\+[0-9]\+\s\+//' | tac | fzf)"
  if [ -z "$sel" ]; then
    return 1
  fi
  READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}${sel}${READLINE_LINE:$READLINE_POINT}"
  READLINE_POINT=$((READLINE_POINT + ${#sel}))
}

bind -m vi-command -x '"\C-r":__history_select_and_insert'
bind -m vi-insert -x '"\C-r":__history_select_and_insert'

historyclear() {
  if confirm "Clear history?"; then
    cat /dev/null > ~/.bash_history
    history -c
    history -r
  fi
}

historyedit() {
  __history_uniqalize
  ${EDITOR:-vi} ~/.bash_history
  history -c
  history -r
}

# ------------------------------------------------------------------------------

killjobs() {
  jobs -p | xargs kill 2>/dev/null
  disown -a 2>/dev/null
}

j() { 
  dir="$(__jump_dir "$@")"
  if [ -n "$dir" ]; then
    cd -- "$dir"
    pwd
  fi
}
