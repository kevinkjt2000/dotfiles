## Initial Setup

```
mkdir -p ~/.local/bin
(cd ~/.local && curl -sfL https://git.io/chezmoi | sh)
~/.local/bin/chezmoi init git@github.com:kevinkjt2000/dotfiles.git
~/.local/bin/chezmoi apply
bash -l
asdf plugin-add python
asdf install python
asdf plugin-add golang
asdf install golang
chezmoi apply
```
