#!/usr/bin/env zsh

set -e

echo "🚀 Starting dotfiles installation..."

# Check if we're on macOS
if [[ "$(uname)" != "Darwin" ]]; then
    echo "❌ This script is designed for macOS"
    exit 1
fi

# Install Homebrew if not already installed
if ! command -v brew &> /dev/null; then
    echo "📦 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ -f "/opt/homebrew/bin/brew" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    echo "✅ Homebrew already installed"
fi


# Install essential packages
echo "📦 Installing required packages..."

packages=(
    "tmux"          # Terminal multiplexer
    "stow"          # Symlink manager
    "neovim"        # Text editor
    "lazygit"       # Git TUI
    "bat"           # Cat replacement with syntax highlighting
    "git-delta"     # Git diff viewer
    "fzf"           # Fuzzy finder (commonly used with tmux/nvim)
    "ripgrep"       # Fast grep (commonly used with nvim)
    "fd"            # Fast find (commonly used with nvim)
    "tree-sitter-cli"
)

for package in "${packages[@]}"; do
    if brew list "$package" &> /dev/null; then
        echo "✅ $package already installed"
    else
        echo "📦 Installing $package..."
        brew install "$package"
    fi
done

# Install TPM (Tmux Plugin Manager) if not already installed
if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
    echo "📦 Installing TPM (Tmux Plugin Manager)..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
else
    echo "✅ TPM already installed"
fi


# Use stow to symlink dotfiles
echo "🔗 Symlinking dotfiles with stow..."
stow .

echo ""
echo "✅ Installation complete!"
echo ""

