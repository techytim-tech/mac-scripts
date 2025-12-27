#!/bin/bash

# iTerm2 Configuration Script for macOS
# This script configures various iTerm2 settings and preferences

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# iTerm2 preferences plist path
ITERM2_PLIST="$HOME/Library/Preferences/com.googlecode.iterm2.plist"

echo -e "${GREEN}Starting iTerm2 configuration...${NC}"

# Check if iTerm2 is installed
if [ ! -d "/Applications/iTerm.app" ] && [ ! -d "$HOME/Applications/iTerm.app" ]; then
    echo -e "${YELLOW}Warning: iTerm2 not found in standard locations. Continuing anyway...${NC}"
fi

# Function to set a preference
set_preference() {
    local key="$1"
    local value="$2"
    local type="${3:-string}"
    
    echo -e "Setting ${GREEN}$key${NC} = ${GREEN}$value${NC}"
    defaults write com.googlecode.iterm2 "$key" -$type "$value" 2>/dev/null || true
}

# Function to set a nested preference (using PlistBuddy)
set_nested_preference() {
    local key_path="$1"
    local value="$2"
    local type="${3:-string}"
    
    echo -e "Setting nested preference ${GREEN}$key_path${NC} = ${GREEN}$value${NC}"
    
    # Create the plist if it doesn't exist
    if [ ! -f "$ITERM2_PLIST" ]; then
        touch "$ITERM2_PLIST"
        defaults write com.googlecode.iterm2 "fake" -string "init"
        defaults delete com.googlecode.iterm2 "fake" 2>/dev/null || true
    fi
    
    # Use PlistBuddy to set nested values
    /usr/libexec/PlistBuddy -c "Set :$key_path $value" "$ITERM2_PLIST" 2>/dev/null || \
    /usr/libexec/PlistBuddy -c "Add :$key_path $type $value" "$ITERM2_PLIST" 2>/dev/null || true
}

echo -e "\n${GREEN}=== General Preferences ===${NC}"

# General appearance
set_preference "AppleAntiAliasingThreshold" "4" "int"
set_preference "AppleScrollAnimationEnabled" "0" "bool"
set_preference "CheckTestRelease" "0" "bool"
set_preference "HideTab" "0" "bool"
set_preference "HideMenuBarInFullscreen" "1" "bool"
set_preference "QuitWhenAllWindowsClosed" "0" "bool"
set_preference "SUEnableAutomaticChecks" "1" "bool"
set_preference "SUHasLaunchedBefore" "1" "bool"
set_preference "SUSendProfileInfo" "0" "bool"
set_preference "WindowNumber" "1" "int"

echo -e "\n${GREEN}=== Window Appearance ===${NC}"

# Window settings
set_preference "WindowStyle" "0" "int"  # 0 = Normal, 1 = Full-width bottom, 2 = Top, 3 = Bottom, 4 = Left, 5 = Right
set_preference "UseBorder" "1" "bool"
set_preference "HideScrollbar" "0" "bool"
set_preference "ShowWindowBorder" "1" "bool"
set_preference "WindowNumber" "1" "int"
set_preference "TabViewType" "0" "int"  # 0 = Bottom, 1 = Top, 2 = Left, 3 = Right

echo -e "\n${GREEN}=== Tab Settings ===${NC}"

# Tab appearance
set_preference "TabStyleWithAutomaticOption" "0" "int"  # 0 = Automatic, 1 = Dark, 2 = Light
set_preference "UseCompactLabel" "0" "bool"
set_preference "HideTabNumber" "0" "bool"
set_preference "HideActivityIndicator" "0" "bool"
set_preference "TabBarHeight" "25" "float"

echo -e "\n${GREEN}=== Terminal Settings ===${NC}"

# Terminal behavior
set_preference "ScrollbackLines" "10000" "int"
set_preference "UnlimitedScrollback" "0" "bool"
set_preference "CharacterEncoding" "4" "int"  # UTF-8
set_preference "MouseReporting" "1" "bool"
set_preference "DisableWindowResizing" "0" "bool"
set_preference "SyncTitle" "0" "bool"
set_preference "CloseSessionsOnEnd" "1" "bool"
set_preference "PromptOnQuit" "1" "bool"

echo -e "\n${GREEN}=== Font Settings ===${NC}"

# Font configuration (using nested preferences)
# Note: Font settings are typically in profile configurations
# This sets a default font family and size
set_nested_preference "New Bookmarks:0:Normal Font" "Monaco 12" "string" || true
set_nested_preference "New Bookmarks:0:Non Ascii Font" "Monaco 12" "string" || true
set_nested_preference "New Bookmarks:0:UseNonAsciiFont" "0" "bool" || true

echo -e "\n${GREEN}=== Keyboard Settings ===${NC}"

# Keyboard shortcuts (these are complex nested structures)
# Note: Keyboard shortcuts are stored in a complex format
# For advanced keyboard customization, consider using iTerm2's GUI or Python API

echo -e "\n${GREEN}=== Color Scheme ===${NC}"

# Color scheme settings (stored in profiles)
# Default color presets are available, but custom schemes require profile editing
echo -e "${YELLOW}Note: Color schemes are typically configured per-profile.${NC}"
echo -e "${YELLOW}Consider using iTerm2's built-in color presets or custom profile settings.${NC}"

echo -e "\n${GREEN}=== Advanced Settings ===${NC}"

# Advanced preferences
set_preference "OpenBookmark" "0" "int"
set_preference "OpenNoWindows" "0" "bool"
set_preference "OpenFile" "" "string"
set_preference "OpenArrangementAtStartup" "0" "bool"
set_preference "LionStyleFullscreen" "1" "bool"
set_preference "UseLionStyleFullscreen" "1" "bool"
set_preference "OpenToolbelt" "0" "bool"
set_preference "OpenPasteHistory" "0" "bool"
set_preference "OpenProfiles" "0" "bool"

# Performance settings
set_preference "DisablePotentiallyInsecureEscapeSequences" "0" "bool"
set_preference "EnableAPIServer" "0" "bool"  # Set to 1 if you want to use Python API

echo -e "\n${GREEN}=== Profile Defaults ===${NC}"

# Set default profile settings (if New Bookmarks array exists)
# These settings apply to new profiles
set_nested_preference "New Bookmarks:0:Columns" "80" "int" || true
set_nested_preference "New Bookmarks:0:Rows" "24" "int" || true
set_nested_preference "New Bookmarks:0:UseBrightBold" "1" "bool" || true
set_nested_preference "New Bookmarks:0:BlinkAllowed" "1" "bool" || true
set_nested_preference "New Bookmarks:0:UseItalicFont" "1" "bool" || true
set_nested_preference "New Bookmarks:0:AmbiguousDoubleWidth" "0" "bool" || true
set_nested_preference "New Bookmarks:0:UnicodeVersion" "9" "int" || true

echo -e "\n${GREEN}=== Notification Settings ===${NC}"

# Notification preferences
set_preference "EnableBonjour" "0" "bool"
set_preference "EnableGrowl" "0" "bool"

echo -e "\n${GREEN}Configuration complete!${NC}"
echo -e "${YELLOW}Note: You may need to restart iTerm2 for all changes to take effect.${NC}"
echo -e "${YELLOW}Some advanced settings (like color schemes and keyboard shortcuts) may require manual configuration through iTerm2's preferences panel.${NC}"

# Optional: Kill iTerm2 to force reload of preferences
read -p "Do you want to restart iTerm2 now? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${GREEN}Restarting iTerm2...${NC}"
    killall iTerm2 2>/dev/null || killall iTerm 2>/dev/null || true
    sleep 1
    open -a iTerm 2>/dev/null || open -a iTerm2 2>/dev/null || true
fi

echo -e "\n${GREEN}Done!${NC}"

