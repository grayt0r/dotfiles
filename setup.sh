# Suppress "Last login" message
touch ~/.hushlogin

# Add symlinks
ln -sf $(pwd)/.zshrc ~/.zshrc
ln -sf $(pwd)/.zsh ~/.zsh
ln -sf $(pwd)/.gitignore_global ~/.gitignore_global

# Setup global gitignore
git config --global core.excludesfile ~/.gitignore_global