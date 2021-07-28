Awesome WM configuration. Originally created by ChrisTitusTech. I modified it to my liking.

## Installation

### 1) Get all the dependencies
```
yay -S awesome rofi picom i3lock-fancy xclip ttf-roboto polkit-gnome materia-theme lxappearance flameshot pnmixer network-manager-applet xfce4-power-manager qt5-styleplugins papirus-icon-theme -y
```
### 2) Clone the configuration
```
git clone https://github.com/LukasAlstrup/awesome ~/.config/awesome
```

### 3) Set the themes
```
mkdir -p ~/.config/rofi
cp $HOME/.config/awesome/theme/config.rasi ~/.config/rofi/config.rasi
sed -i '/@import/c\@import "'$HOME'/.config/awesome/configuration/rofithemes/colorful/style_1.rasi"' ~/.config/rofi/config.rasi
```
