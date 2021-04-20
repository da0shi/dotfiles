EXCLUSIONS := .DS_Store .git .gitmodules .gitignore
CANDIDATES := $(wildcard _*) darwin
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))
DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
UNAME      := $(shell uname -s | tr A-Z a-z)

all: install

help:
	@echo "make list          #=> Show dot files in this repo"
	@echo "make deploy        #=> Create symlink to home directory"
	@echo "make update        #=> Fetch changes for this repo"
	@echo "make install       #=> Run make update, deploy, init"

list:
	@$(foreach val, $(DOTFILES), ls -dF $(val);)

# Getting lowercase of system name
deploy-bash:
	@ln -sfnv $(abspath $(UNAME)/_bash_profile) $(HOME)/.bash_profile
	@ln -sfnv $(abspath $(UNAME)/_bash_alias) $(HOME)/.bash_alias
	@ln -sfnv $(abspath $(UNAME)/_bashrc) $(HOME)/.bashrc

deploy-zsh:
	@ln -sfnv $(abspath zsh/_zshfunc) $(HOME)/.zshfunc
	@ln -sfnv $(abspath zsh/_zsh_alias) $(HOME)/.zsh_alias
	@ln -sfnv $(abspath zsh/_zshrc) $(HOME)/.zshrc

deploy-git:
	@ln -sfnv $(abspath _gitconfig) $(HOME)/.gitconfig
	@ln -sfnv $(abspath _globalignore) $(HOME)/.globalignore

deploy-vim:
	@ln -sfnv $(abspath _vim) $(HOME)/.vim

deploy-emacs:
	@ln -sfnv $(abspath _emacs.d) $(HOME)/.emacs.d

deploy-tmux:
	@ln -sfnv $(abspath _tmux.conf) $(HOME)/.tmux.conf

deploy-misc:
	@mkdir -p $(HOME)/.local/bin

deploy: deploy-bash deploy-zsh deploy-git deploy-vim deploy-tmux

update:
	git pull --rebase origin master

install: update deploy
