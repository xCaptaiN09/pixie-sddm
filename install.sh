#!/bin/bash

# Pixie SDDM - Universal Smart Installer
# Author: xCaptaiN09

set -e

THEME_NAME="pixie"
THEME_DIR="/usr/share/sddm/themes/${THEME_NAME}"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}==>${NC} Starting Pixie SDDM Installation..."

# 1. SYSTEM DETECTION
if command -v sddm-greeter-qt6 >/dev/null 2>&1; then
    SYSTEM_QT="6"
    GREETER_CMD="sddm-greeter-qt6"
    TARGET_BRANCH="main"
    echo -e "${BLUE}==>${NC} System detected: ${GREEN}Qt6 (Modern)${NC}"
else
    SYSTEM_QT="5"
    GREETER_CMD="sddm-greeter"
    TARGET_BRANCH="qt5"
    echo -e "${BLUE}==>${NC} System detected: ${YELLOW}Qt5 (Legacy)${NC}"
fi

# 2. AUTO-VERSION SWITCH (Git Only)
if [ -d .git ]; then
    CURRENT_BRANCH=$(git branch --show-current)
    if [ "$CURRENT_BRANCH" != "$TARGET_BRANCH" ]; then
        echo -e "${YELLOW}==>${NC} System requires ${GREEN}${TARGET_BRANCH}${NC} version. Switching branch..."
        git checkout "$TARGET_BRANCH"
        # Re-run the script from the new branch to ensure we use the right files
        exec ./install.sh
    fi
fi

# 3. NIXOS CHECK
if [ -f /etc/NIXOS ]; then
    echo -e "${RED}Warning:${NC} NixOS detected. Please use the declarative method in your config."
    exit 1
fi

# 4. ROOT CHECK
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}Error:${NC} Please run as root (use sudo)."
    exit 1
fi

# 5. INSTALLATION
if [ -d "${THEME_DIR}" ]; then
    echo -e "${BLUE}==>${NC} Cleaning old version..."
    rm -rf "${THEME_DIR}"
fi

echo -e "${BLUE}==>${NC} Installing Pixie (Qt${SYSTEM_QT}) to ${THEME_DIR}..."
mkdir -p "${THEME_DIR}"
cp -r assets components Main.qml metadata.desktop theme.conf LICENSE "${THEME_DIR}/"
chmod -R 755 "${THEME_DIR}"

echo -e "${GREEN}Done!${NC} Pixie SDDM is now installed."

# 6. CONFIGURATION
echo -e ""
read -p "Apply Pixie as your active theme now? (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    mkdir -p /etc/sddm.conf.d
    echo -e "[Theme]\nCurrent=${THEME_NAME}" | tee /etc/sddm.conf.d/theme.conf > /dev/null
    echo -e "${GREEN}Theme applied successfully!${NC}"
else
    echo -e "To apply manually, set ${GREEN}Current=${THEME_NAME}${NC} in your SDDM config."
fi

echo -e ""
echo -e "Test with: ${BLUE}${GREETER_CMD} --test-mode --theme ${THEME_DIR}${NC}"
