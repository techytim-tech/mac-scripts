# macOS iTerm2 Configuration Script

This script automates the configuration of iTerm2 terminal application settings on macOS.

## Features

The script provides **interactive configuration** for iTerm2 settings including:

### Interactive Options
- **Font Selection**: Choose from 10 popular monospace fonts (Monaco, Menlo, Fira Code, JetBrains Mono, etc.) or enter a custom font
- **Text Size Selection**: Choose from 8 preset sizes (10pt-18pt) or enter a custom size
- **Theme/Color Scheme Selection**: Choose from 16 popular color themes (Solarized, Dracula, Nord, Monokai, etc.) or enter a custom theme name

### Automatic Configuration
- **General Preferences**: Appearance, update settings, window behavior
- **Window Appearance**: Window style, borders, scrollbars
- **Tab Settings**: Tab appearance and behavior
- **Terminal Settings**: Scrollback, encoding, mouse reporting
- **Keyboard Settings**: Basic keyboard preferences
- **Advanced Settings**: Performance and API options
- **Profile Defaults**: Default terminal dimensions and Unicode settings

## Usage

1. Make sure the script is executable:
   ```bash
   chmod +x configure-iterm2.sh
   ```

2. Run the script:
   ```bash
   ./configure-iterm2.sh
   ```

3. The script will:
   - **Prompt you to select a font** from a menu of popular options
   - **Prompt you to select a text size** (10pt to 18pt or custom)
   - **Prompt you to select a color theme** from popular iTerm2 themes
   - Configure all iTerm2 preferences using macOS `defaults` command
   - Apply your selected font, size, and theme to the default profile
   - Optionally restart iTerm2 to apply changes

### Example Interactive Session

```
=== Font Selection ===
Please select a font:
  1) Monaco (Classic macOS)
  2) Menlo (Modern macOS)
  3) Meslo LG (Powerline-friendly)
  ...
Enter your choice [1-10]: 6

=== Text Size Selection ===
Please select text size:
  1) 10pt (Small)
  2) 11pt
  3) 12pt (Default)
  ...
Enter your choice [1-8]: 5

=== Theme/Color Scheme Selection ===
Please select a color theme:
  1) Default (Light)
  2) Dark Background
  3) Solarized Dark
  ...
Enter your choice [1-16]: 8
```

## Available Fonts

The script includes these font options:
- Monaco (Classic macOS)
- Menlo (Modern macOS)
- Meslo LG (Powerline-friendly)
- Fira Code (Ligatures)
- Source Code Pro (Adobe)
- JetBrains Mono (Modern)
- Courier New (Classic)
- Consolas (Windows-style)
- Inconsolata (Clean)
- Custom font name

## Available Themes

The script includes these color theme options:
- Default (Light)
- Dark Background
- Solarized Dark/Light
- Tomorrow Night (variations)
- Dracula
- One Dark
- Gruvbox Dark
- Nord
- Material Design
- Monokai
- Pastel (Dark Background)
- Tango Dark
- Custom theme name

**Note**: For themes to work, they must be installed in iTerm2 first. You can download and import themes from [iTerm2 Color Schemes](https://iterm2colorschemes.com/).

## Customization

You can customize the script by modifying the preference values in the script. Common settings you might want to change:

- **Scrollback Lines**: Change `ScrollbackLines` value (default: 10000)
- **Window Style**: Modify `WindowStyle` (0-5 for different positions)
- **Tab Style**: Adjust `TabStyleWithAutomaticOption` (0-2)

## Notes

- **Theme Installation**: If a selected theme doesn't appear, you may need to import it first through iTerm2's preferences (Preferences → Profiles → Colors → Color Presets → Import). Download themes from [iTerm2 Color Schemes](https://iterm2colorschemes.com/)
- **Font Availability**: Make sure the selected font is installed on your system. Some fonts (like Fira Code, JetBrains Mono) may need to be installed separately
- The script uses `defaults` command and `PlistBuddy` to modify iTerm2's preference plist file
- You may need to restart iTerm2 for all changes to take effect
- The script is compatible with both bash and zsh
- Complex keyboard shortcuts are best configured through iTerm2's GUI preferences panel

## Requirements

- macOS
- iTerm2 installed (though the script will continue even if not found)
- Standard macOS utilities (`defaults`, `PlistBuddy`)

## Safety

The script creates backups implicitly through the `defaults` command system. However, it's recommended to:
- Close iTerm2 before running the script
- Review the settings before applying them
- Keep a backup of your iTerm2 preferences if you have custom configurations

