# macOS iTerm2 Configuration Script

This script automates the configuration of iTerm2 terminal application settings on macOS.

## Features

The script configures various iTerm2 settings including:

- **General Preferences**: Appearance, update settings, window behavior
- **Window Appearance**: Window style, borders, scrollbars
- **Tab Settings**: Tab appearance and behavior
- **Terminal Settings**: Scrollback, encoding, mouse reporting
- **Font Settings**: Default font configuration
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
   - Configure iTerm2 preferences using macOS `defaults` command
   - Optionally restart iTerm2 to apply changes

## Customization

You can customize the script by modifying the preference values. Common settings you might want to change:

- **Font**: Edit the font name and size in the "Font Settings" section
- **Scrollback Lines**: Change `ScrollbackLines` value (default: 10000)
- **Window Style**: Modify `WindowStyle` (0-5 for different positions)
- **Tab Style**: Adjust `TabStyleWithAutomaticOption` (0-2)

## Notes

- Some advanced settings (like color schemes and complex keyboard shortcuts) are best configured through iTerm2's GUI preferences panel
- The script uses `defaults` command and `PlistBuddy` to modify iTerm2's preference plist file
- You may need to restart iTerm2 for all changes to take effect
- The script is compatible with both bash and zsh

## Requirements

- macOS
- iTerm2 installed (though the script will continue even if not found)
- Standard macOS utilities (`defaults`, `PlistBuddy`)

## Safety

The script creates backups implicitly through the `defaults` command system. However, it's recommended to:
- Close iTerm2 before running the script
- Review the settings before applying them
- Keep a backup of your iTerm2 preferences if you have custom configurations

