# Colorize output, add file type indicator, and put sizes in human readable format
alias ls='ls -GFha'

# Same as above, but in long listing format
alias ll='ls -GFhla'

alias mysql='mysql -u root'
alias mysqladmin='mysqladmin -u root'

# Enable aliases to be sudo’ed
#alias sudo='sudo '

alias show="defaults write com.apple.Finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.Finder AppleShowAllFiles -bool false && killall Finder"

alias ar='ant refresh'
alias ae='ant explode'
alias au='ant unexplode clean explode'
alias j='jboss'
