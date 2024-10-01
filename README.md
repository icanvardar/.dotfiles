# Can's dotfiles

My sweet, delicious dotfiles for my gorgeus, and faster than ever development environment!

## Components
```txt
- Editor: Neovim
- Terminal: alacritty
- Terminal Multiplexer: tmux
- Theme: Github Dark Default
- Window Manager: i3
```

## Prerequisites
- <a href="https://github.com/alacritty/alacritty/blob/master/INSTALL.md" target="_blank">alacritty</a>
- <a href="https://github.com/betterlockscreen/betterlockscreen?tab=readme-ov-file#installation" target="_blank">betterlockscreen</a>
- <a href="https://github.com/derf/feh" target="_blank">feh</a>
- <a href="https://github.com/junegunn/fzf?tab=readme-ov-file#installation" target="_blank">fzf</a>
- <a href="https://www.gnu.org/software/stow/" target="_blank">GNU Stow</a>
- <a href="https://i3wm.org/downloads/" target="_blank">i3</a>
- <a href="https://github.com/Raymo111/i3lock-color?tab=readme-ov-file#debian" target="_blank">i3-lock-color</a>
- <a href="https://github.com/icanvardar/i3-screen-util?tab=readme-ov-file#installation" target="_blank">i3-screen-util</a>
- <a href="http://www.lazyvim.org/installation" target="_blank">LazyVim</a>
- <a href="https://github.com/libevent/libevent/releases/" target="_blank">libevent</a>
- <a href="https://github.com/neovim/neovim/releases/tag/v0.10.1" target="_blank">Neovim</a>
- <a href="https://github.com/yshui/picom?tab=readme-ov-file#to-install" target="_blank">Picom</a>
- <a href="https://www.rust-lang.org/tools/install" target="_blank">Rust</a>
- <a href="https://github.com/tmux/tmux" target="_blank">tmux</a>

## Must Do's

##### i3
Run before installation:
  ```bash
  sudo apt install meson dh-autoreconf libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb1-dev \
  libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev \
  libxcb-xinerama0-dev libxkbcommon-x11-dev libstartup-notification0-dev libxcb-randr0-dev \
  libxcb-xrm0 libxcb-xrm-dev libxcb-shape0 libxcb-shape0-dev
  ```
---
##### maim
Install `maim` to activate screenshot feature of i3:  
  
`sudo apt install maim`

---
##### playerctl
Install `playerctl` to activate media control feature of i3:

`sudo apt install playerctl`

---
##### alacritty
Run before installation:
  ```bash
  sudo apt install cmake libfontconfig1-dev
  ```
---
##### **ripgrep** (For Neovim's Telescope search)
Run it if you like to use grep search for LazyVim plugin:

`sudo apt install ripgrep`
  
---
##### i3lock-color
Run before installation to purge i3lock:  

`sudo apt purge i3lock`

---
##### tmux
Run before installation:
  ```bash
  sudo apt-get install bison byacc libncurses5-dev libncursesw5-dev
  sudo apt-get install libssl-dev
  ```

---
##### libevent (Required for TMUX)
Don't forget to update library path after `libevent` installation:
<br>
<br>
LD_LIBRARY_PATH Update:
  ```bash
  export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
  ```
Cache Update:
  ```bash
  sudo ldconfig
  ```

## Installation
```bash
cd ~/.dotfiles
sudo sh ./install.sh
```
