#!/bin/bash

# Homebrewのインストール確認と実行
if ! command -v brew &> /dev/null; then
    echo "Homebrew is not installed. Installing now..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # OSの確認と現在のセッションでのHomebrew有効化
    OS_TYPE="$(uname)"
    if [[ "$OS_TYPE" == "Darwin" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ "$OS_TYPE" == "Linux" ]]; then
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    fi
else
    echo "Homebrew is already installed. Skipping installation."
fi
