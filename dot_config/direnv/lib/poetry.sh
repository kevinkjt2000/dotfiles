#!/usr/bin/env bash

layout_poetry() {
  if [[ ! -f pyproject.toml ]]; then
    log_error "No pyproject.toml found. Use \`poetry new\` or \`poetry init\` to create one first."
    exit 2
  fi

  local VENV
  VENV=$(poetry env list --full-path | cut -d' ' -f1)
  if [[ -z $VENV || ! -d $VENV/bin ]]; then
    log_error "No poetry virtual environment found. Use \`poetry install\` to create one first."
    exit 2
  fi

  PATH_add "$VENV/bin"
}
