## Initial Setup

```
mkdir -p ~/.local/bin
mkdir -p ~/.local/share
git clone git@github.com:kevinkjt2000/dotfiles.git ~/.local/share/chezmoi
(cd ~/.local && curl -sfL https://git.io/chezmoi | sh)
chezmoi apply
```
