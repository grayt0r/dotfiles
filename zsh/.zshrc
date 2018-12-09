##########
# COLORS #
##########

autoload colors; colors
export CLICOLOR=1

##########
# SETOPT #
##########

setopt PROMPT_SUBST

###########
# EXPORTS #
###########

# Move /usr/local/bin before /usr/bin for homebrew
export PATH=$HOME/.dotfiles/bin:/usr/local/bin:$HOME/.jenv/bin:$PATH:$HOME/.yarn/bin

# Enable color in grep
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;37'

export CLICOLOR=1
export EDITOR='code'
export DISABLE_AUTO_TITLE='true'

# Ruby setup :(
eval "$(rbenv init -)"

# jenv setup
eval "$(jenv init -)"

# nodenv setup
eval "$(nodenv init -)"

export SBT_OPTS="-Xmx2G -XX:+UseConcMarkSweepGC -XX:+CMSClassUnloadingEnabled -Xss2M -Duser.timezone=GMT"

##########
# PROMPT #
##########

autoload -U promptinit; promptinit
prompt pure

##############
# COMPLETION #
##############

# Enable git completion?
autoload -U compinit && compinit

###########
# ALIASES #
###########

# Colorize output, add file type indicator, and put sizes in human readable format
alias ls='ls -GFha'

# Same as above, but in long listing format
alias ll='ls -GFhla'

alias dev='cd ~/dev/code'

# Capsule specific
alias capsule='cd ~/dev/code/capsule'
alias ae='ant explode'
alias au='ant unexplode clean explode'
alias ar='cd ember && yarn install --frozen-lockfile && cd .. && yarn install --frozen-lockfile && ant refresh'
alias j='jboss-eap'
alias t='yarn run ember exam --split=8 --parallel -r=tap'
alias ets='yarn run ember server --environment=test --port=4201'

#############
# FUNCTIONS #
#############

function g {
  if [[ $# > 0 ]]; then
    git $@
  else
    git status --short --branch
  fi
}

function gsd {
  if [ -n "$1" ]; then
    git stash show -p stash@{"$1"}
  else
    git stash show -p stash@{0}
  fi
}

function open-files {
  lsof | awk '{ print "pid=" $2 ", name=" $1; }' | sort -rn | uniq -c | sort -rn | head -20
}

# Start an HTTP server from a directory, optionally specifying the port
function server() {
  local port="${1:-8000}"
  open "http://localhost:${port}/" && python -m SimpleHTTPServer "$port"
}

function port() {
  lsof -n -i:"$1" | grep LISTEN
}

###########
# HISTORY #
###########

HISTSIZE=3000
SAVEHIST=3000
HISTFILE=~/.zsh_history

#########
# HOOKS #
#########

function precmd {
  # vcs_info
  # Put the string "hostname::/full/directory/path" in the title bar:
  echo -ne "\e]2;$PWD\a"

  # Put the parentdir/currentdir in the tab
  echo -ne "\e]1;$PWD:h:t/$PWD:t\a"
}

function set_running_app {
  printf "\e]1; $PWD:t:$(history $HISTCMD | cut -b7- ) \a"
}

function preexec {
  set_running_app
}

function postexec {
  set_running_app
}