#!/bin/bash

which brew >/dev/null || { echo "brew not found: $?" ; exit 1; }

brew cask install java
brew install \
  awscli \
  bash-completion \
  bash-git-prompt \
  direnv \
  ffmpeg \
  fzf \
  git \
  go \
  jq \
  node \
  openssl \
  pgcli \
  sbt \
  scala \
  terraform \
  tig \
  tmux \
  unar \
  vim \
  vim \
  yarn \
