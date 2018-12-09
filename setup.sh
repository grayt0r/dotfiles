echo "Setting up dotfiles in $(pwd)"

# Suppress "Last login" message
touch ~/.hushlogin

# Add symlinks
ln -sf $(pwd)/zsh/.zshrc ~/.zshrc
ln -sf $(pwd)/git/.gitignore_global ~/.gitignore_global

# Setup global gitignore
git config --global core.excludesfile ~/.gitignore_global