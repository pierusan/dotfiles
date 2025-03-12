#!/bin/bash

set -euo pipefail

# Make sure Python is installed so we can install Poetry
if ! [ -x $(command -v python) ]; then
    echo "Python needs to be installed first to install poetry"
    exit 1
fi


# Install poetry and setup autocompletion
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | python -
# TODO: Replace with uv instead and replace pyenv
# Setup autocompletion with zsh plugin
POETRY_PLUGIN_DIR=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/poetry
mkdir -p $POETRY_PLUGIN_DIR
poetry completions zsh > $POETRY_PLUGIN_DIR/_poetry
chmod 755 $POETRY_PLUGIN_DIR