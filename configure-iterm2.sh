#!/bin/bash

# iTerm2 Configuration Script for macOS
# This script configures various iTerm2 settings and preferences

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# iTerm2 preferences plist path
ITERM2_PLIST="$HOME/Library/Preferences/com.googlecode.iterm2.plist"

# Variables to store user selections
SELECTED_FONT=""
SELECTED_FONT_SIZE=""
SELECTED_THEME=""

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

# Function to display font selection menu
select_font() {
    echo -e "\n${CYAN}=== Font Selection ===${NC}"
    echo -e "${YELLOW}Please select a font:${NC}"
    echo "  1) Monaco (Classic macOS)"
    echo "  2) Menlo (Modern macOS)"
    echo "  3) Meslo LG (Powerline-friendly)"
    echo "  4) Fira Code (Ligatures)"
    echo "  5) Source Code Pro (Adobe)"
    echo "  6) JetBrains Mono (Modern)"
    echo "  7) Courier New (Classic)"
    echo "  8) Consolas (Windows-style)"
    echo "  9) Inconsolata (Clean)"
    echo " 10) Custom (enter font name)"
    
    read -p "Enter your choice [1-10]: " font_choice
    
    case $font_choice in
        1) SELECTED_FONT="Monaco" ;;
        2) SELECTED_FONT="Menlo" ;;
        3) SELECTED_FONT="MesloLG" ;;
        4) SELECTED_FONT="FiraCode" ;;
        5) SELECTED_FONT="SourceCodePro" ;;
        6) SELECTED_FONT="JetBrainsMono" ;;
        7) SELECTED_FONT="Courier New" ;;
        8) SELECTED_FONT="Consolas" ;;
        9) SELECTED_FONT="Inconsolata" ;;
        10) 
            read -p "Enter custom font name: " SELECTED_FONT
            ;;
        *)
            echo -e "${RED}Invalid choice. Using default: Monaco${NC}"
            SELECTED_FONT="Monaco"
            ;;
    esac
    
    echo -e "${GREEN}Selected font: ${SELECTED_FONT}${NC}"
}

# Function to display text size selection menu
select_text_size() {
    echo -e "\n${CYAN}=== Text Size Selection ===${NC}"
    echo -e "${YELLOW}Please select text size:${NC}"
    echo "  1) 10pt (Small)"
    echo "  2) 11pt"
    echo "  3) 12pt (Default)"
    echo "  4) 13pt"
    echo "  5) 14pt (Medium)"
    echo "  6) 16pt (Large)"
    echo "  7) 18pt (Extra Large)"
    echo "  8) Custom (enter size)"
    
    read -p "Enter your choice [1-8]: " size_choice
    
    case $size_choice in
        1) SELECTED_FONT_SIZE="10" ;;
        2) SELECTED_FONT_SIZE="11" ;;
        3) SELECTED_FONT_SIZE="12" ;;
        4) SELECTED_FONT_SIZE="13" ;;
        5) SELECTED_FONT_SIZE="14" ;;
        6) SELECTED_FONT_SIZE="16" ;;
        7) SELECTED_FONT_SIZE="18" ;;
        8) 
            read -p "Enter custom font size (e.g., 15): " SELECTED_FONT_SIZE
            if ! [[ "$SELECTED_FONT_SIZE" =~ ^[0-9]+$ ]]; then
                echo -e "${RED}Invalid size. Using default: 12${NC}"
                SELECTED_FONT_SIZE="12"
            fi
            ;;
        *)
            echo -e "${RED}Invalid choice. Using default: 12${NC}"
            SELECTED_FONT_SIZE="12"
            ;;
    esac
    
    echo -e "${GREEN}Selected text size: ${SELECTED_FONT_SIZE}pt${NC}"
}

# Function to display theme selection menu
select_theme() {
    echo -e "\n${CYAN}=== Theme/Color Scheme Selection ===${NC}"
    echo -e "${YELLOW}Please select a color theme:${NC}"
    echo "  1) Default (Light)"
    echo "  2) Dark Background"
    echo "  3) Solarized Dark"
    echo "  4) Solarized Light"
    echo "  5) Tomorrow Night"
    echo "  6) Tomorrow Night Eighties"
    echo "  7) Tomorrow Night Blue"
    echo "  8) Dracula"
    echo "  9) One Dark"
    echo " 10) Gruvbox Dark"
    echo " 11) Nord"
    echo " 12) Material Design"
    echo " 13) Monokai"
    echo " 14) Pastel (Dark Background)"
    echo " 15) Tango Dark"
    echo " 16) Custom (enter theme name)"
    
    read -p "Enter your choice [1-16]: " theme_choice
    
    case $theme_choice in
        1) SELECTED_THEME="Default" ;;
        2) SELECTED_THEME="Dark Background" ;;
        3) SELECTED_THEME="Solarized Dark" ;;
        4) SELECTED_THEME="Solarized Light" ;;
        5) SELECTED_THEME="Tomorrow Night" ;;
        6) SELECTED_THEME="Tomorrow Night Eighties" ;;
        7) SELECTED_THEME="Tomorrow Night Blue" ;;
        8) SELECTED_THEME="Dracula" ;;
        9) SELECTED_THEME="One Dark" ;;
        10) SELECTED_THEME="Gruvbox Dark" ;;
        11) SELECTED_THEME="Nord" ;;
        12) SELECTED_THEME="Material Design" ;;
        13) SELECTED_THEME="Monokai" ;;
        14) SELECTED_THEME="Pastel (Dark Background)" ;;
        15) SELECTED_THEME="Tango Dark" ;;
        16) 
            read -p "Enter custom theme name: " SELECTED_THEME
            ;;
        *)
            echo -e "${RED}Invalid choice. Using default: Dark Background${NC}"
            SELECTED_THEME="Dark Background"
            ;;
    esac
    
    echo -e "${GREEN}Selected theme: ${SELECTED_THEME}${NC}"
}

# Function to apply font settings to default profile
apply_font_settings() {
    if [ -z "$SELECTED_FONT" ] || [ -z "$SELECTED_FONT_SIZE" ]; then
        echo -e "${YELLOW}Skipping font settings (not selected)${NC}"
        return
    fi
    
    echo -e "\n${GREEN}=== Applying Font Settings ===${NC}"
    
    local font_string="${SELECTED_FONT} ${SELECTED_FONT_SIZE}"
    
    # Get the default profile GUID
    local default_profile_guid=$(/usr/libexec/PlistBuddy -c "Print :\"New Bookmarks\":0:\"Guid\"" "$ITERM2_PLIST" 2>/dev/null || echo "")
    
    if [ -z "$default_profile_guid" ]; then
        # Try to get the first profile GUID
        default_profile_guid=$(/usr/libexec/PlistBuddy -c "Print :\"New Bookmarks\":0:\"Guid\"" "$ITERM2_PLIST" 2>/dev/null || echo "")
    fi
    
    if [ -n "$default_profile_guid" ]; then
        # Apply to specific profile
        set_nested_preference "New Bookmarks:0:Normal Font" "$font_string" "string" || true
        set_nested_preference "New Bookmarks:0:Non Ascii Font" "$font_string" "string" || true
    else
        # Apply to default profile (index 0)
        set_nested_preference "New Bookmarks:0:Normal Font" "$font_string" "string" || true
        set_nested_preference "New Bookmarks:0:Non Ascii Font" "$font_string" "string" || true
    fi
    
    echo -e "${GREEN}Font set to: ${font_string}${NC}"
}

# Function to apply theme/color scheme
apply_theme() {
    if [ -z "$SELECTED_THEME" ]; then
        echo -e "${YELLOW}Skipping theme settings (not selected)${NC}"
        return
    fi
    
    echo -e "\n${GREEN}=== Applying Theme ===${NC}"
    
    # iTerm2 stores color schemes in a complex structure
    # We'll set the color preset name in the profile
    # Note: The theme must exist in iTerm2's color presets
    
    # Try to find the profile and set the color preset
    local color_preset_name="$SELECTED_THEME"
    
    # Apply to default profile
    set_nested_preference "New Bookmarks:0:\"Color Preset Name\"" "$color_preset_name" "string" || true
    
    echo -e "${GREEN}Theme set to: ${SELECTED_THEME}${NC}"
    echo -e "${YELLOW}Note: If the theme doesn't appear, you may need to import it first through iTerm2's preferences.${NC}"
    echo -e "${YELLOW}You can download themes from: https://iterm2colorschemes.com/${NC}"
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

echo -e "\n${BLUE}═══════════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}  Interactive Configuration${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}"

# Interactive selections
select_font
select_text_size
select_theme

echo -e "\n${GREEN}=== Keyboard Settings ===${NC}"

# Keyboard shortcuts (these are complex nested structures)
# Note: Keyboard shortcuts are stored in a complex format
# For advanced keyboard customization, consider using iTerm2's GUI or Python API

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

# Apply user-selected font and theme
apply_font_settings
apply_theme

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

