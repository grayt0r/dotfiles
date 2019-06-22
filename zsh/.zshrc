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
if type "rbenv" > /dev/null; then
  eval "$(rbenv init -)"
fi

# jenv setup
if type "jenv" > /dev/null; then
  eval "$(jenv init -)"
fi

# nodenv setup
eval "$(nodenv init -)"

export SBT_OPTS="-Xmx2G -XX:+UseConcMarkSweepGC -XX:+CMSClassUnloadingEnabled -Xss2M -Duser.timezone=GMT"

# Google App Engine (brew install app-engine-java)
export APPENGINE_SDK_HOME=/usr/local/opt/app-engine-java/libexec

##########
# PROMPT #
##########

autoload -U promptinit; promptinit
prompt pure

# Disable pure prompt's default title behaviour
prompt_pure_set_title() {}

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
alias kill-jboss='pkill -9 -f jboss'

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

function precmd() {
  # Set the window title to full/directory/path
  echo -ne "\e]2;$PWD\a"

  # Set the tab title to parentdir/currentdir
  echo -ne "\e]1;$PWD:h:t/$PWD:t\a"
}

#############
# ZSH SETUP #
#############

# Highlighting
source `brew --prefix`/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# As per `brew info zsh-completions`
fpath=(`brew --prefix`/share/zsh-completions $fpath)

# As per `brew info zsh-history-substring-search`
source `brew --prefix`/share/zsh-history-substring-search/zsh-history-substring-search.zsh

# Configure zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=green,fg=black,bold'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=red,fg=black,bold'
HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS='i'
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=true