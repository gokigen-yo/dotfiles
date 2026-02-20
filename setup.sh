#!/bin/bash

set -e

echo "Starting setup script..."

# OSの確認
OS_TYPE="$(uname)"
if [[ "$OS_TYPE" != "Darwin" && "$OS_TYPE" != "Linux" ]]; then
    echo "ERROR: This script is intended for macOS or Linux only."
    exit 1
fi

# Homebrewのインストール確認と実行
if ! command -v brew &> /dev/null; then
    echo "Homebrew is not installed. Installing now..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # 現在のセッションでHomebrewを有効にする
    if [[ "$OS_TYPE" == "Darwin" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ "$OS_TYPE" == "Linux" ]]; then
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    fi
else
    echo "Homebrew is already installed. Skipping installation."
fi

# chezmoiのインストール
if ! command -v chezmoi &> /dev/null; then
    echo "chezmoi is not installed. Installing via Homebrew..."
    brew install chezmoi
else
    echo "chezmoi is already installed. Skipping installation."
fi

# dotfilesの適用
DOTFILES_REPO="gokigen-yo/dotfiles"
echo "Initializing chezmoi with repo: $DOTFILES_REPO"
chezmoi init --apply "$DOTFILES_REPO"

# TODO: sourceコマンドでzshの設定を読み込む

echo "=============================================================================="
echo "Setup complete! Please restart your terminal or source your profile."
echo "=============================================================================="
