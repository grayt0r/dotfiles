# Move /usr/local/bin before /usr/bin for homebrew
export PATH=/usr/local/bin:$PATH

# Setup terminal
#export TERM=xterm-256color

# Enable color in grep
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;37'

export EDITOR='mate'

# Ruby setup :(
if ls /usr/local/ruby &> /dev/null; then
  export GEM_HOME=~/.gem
  export GEM_PATH=~/.gem
  export PATH="/usr/local/ruby/bin:$PATH:$HOME/.gem/bin"
fi
