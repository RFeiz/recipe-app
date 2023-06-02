import 'package:flutter/material.dart';

class ThemeSelectDialog extends StatefulWidget {
  const ThemeSelectDialog({Key? key}) : super(key: key);

  @override
  ThemeSelectDialogState createState() => ThemeSelectDialogState();
}

class ThemeSelectDialogState extends State<ThemeSelectDialog> {
  ThemeMode _selectedTheme = ThemeMode.system;

  void _applySelectedTheme(BuildContext context) {
    //  Apply the selected theme
    switch (_selectedTheme) {
      case ThemeMode.light:
        // Apply light theme
        ThemeManager.setTheme(ThemeMode.light);
        break;
      case ThemeMode.dark:
        // Apply dark theme
        ThemeManager.setTheme(ThemeMode.dark);
        break;
      case ThemeMode.system:
        // Apply system theme
        ThemeManager.setTheme(ThemeMode.system);
        break;
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select a Theme'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile<ThemeMode>(
            title: const Text('Light'),
            value: ThemeMode.light,
            groupValue: _selectedTheme,
            onChanged: (ThemeMode? value) {
              setState(() {
                _selectedTheme = value!;
              });
            },
          ),
          RadioListTile<ThemeMode>(
            title: const Text('Dark'),
            value: ThemeMode.dark,
            groupValue: _selectedTheme,
            onChanged: (ThemeMode? value) {
              setState(() {
                _selectedTheme = value!;
              });
            },
          ),
          RadioListTile<ThemeMode>(
            title: const Text('System'),
            value: ThemeMode.system,
            groupValue: _selectedTheme,
            onChanged: (ThemeMode? value) {
              setState(() {
                _selectedTheme = value!;
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            _applySelectedTheme(context);
          },
          child: const Text('Apply'),
        ),
      ],
    );
  }
}

class ThemeManager {
  static ThemeMode currentTheme = ThemeMode.system;

  static void setTheme(ThemeMode theme) {
    currentTheme = theme;
    print('Theme changed to $currentTheme');
    //  Apply the theme to the app
  }
}
