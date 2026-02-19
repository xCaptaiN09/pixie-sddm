# ✨ Pixie SDDM (Legacy Qt5 Branch)

> [!WARNING]
> This is the **Legacy Qt5 Branch**. If you are on a modern system (Fedora 40+, Arch, NixOS, etc.), please use the [**main branch (Qt6)**](https://github.com/xCaptaiN09/pixie-sddm) for the best quality and compatibility.

A clean, modern, and minimal SDDM theme inspired by Google Pixel UI and Material Design 3. 

---

## 🌟 Features (Qt5)

- **Pixel Aesthetic:** Clean typography and a unique two-tone stacked clock.
- **Material You Dynamic Colors:** Intelligent color extraction that samples your wallpaper for UI accents.
- **Universal Circle Avatar:** A bulletproof, anti-aliased circular profile mask.
- **Material Design 3:** Dark card UI with smooth interactions and responsive dropdowns.
- **Keyboard Navigation:** Full support for navigating menus with arrows and `Enter`.

---

## 🛠 1. Prerequisites (Qt5)

Before installing, ensure you have the required Qt5 modules installed to avoid a black screen:

```bash
# Ubuntu / Debian / Mint:
sudo apt update && sudo apt install qml-module-qtgraphicaleffects qml-module-qtquick-controls2

# Arch Linux:
sudo pacman -S qt5-graphicaleffects qt5-quickcontrols2
```

---

## 📦 2. Installation

> [!TIP]
> The **Automatic Script** will intelligently detect your system and switch to this branch if needed.

### Method A: Automatic Script (Recommended)
```bash
git clone https://github.com/xCaptaiN09/pixie-sddm.git
cd pixie-sddm
sudo ./install.sh
```

### Method B: Manual
1. Copy the folder to SDDM themes directory:
   `sudo cp -r pixie-sddm /usr/share/sddm/themes/pixie`
2. Set the theme in `/etc/sddm.conf`:
   ```ini
   [Theme]
   Current=pixie
   ```

---

## 🛠 Configuration & Testing

### Preview Without Logging Out
Run this command to preview the theme safely:
```bash
sddm-greeter --test-mode --theme /usr/share/sddm/themes/pixie
```

### Customization
Edit `theme.conf` or replace assets in `assets/`:
- **Wallpaper:** Replace `assets/background.jpg`.
- **Avatar:** Replace `assets/avatar.jpg`.

## 🤝 Credits

- **Author:** [xCaptaiN09](https://github.com/xCaptaiN09)
- **Design:** Inspired by Google Pixel and MD3.
- **Font:** Google Sans Flex (included).

---
*Made with ❤️ for the Linux community.*
