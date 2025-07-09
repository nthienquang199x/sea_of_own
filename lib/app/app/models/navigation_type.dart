import 'package:flutter/material.dart';

enum NavigationType {
  dashboard,
  myAutomations,
  chat,
  createAutomation,
  integrations,
  templates,
  settings,
  help;

  String get title {
    switch (this) {
      case NavigationType.dashboard:
        return "Dashboard";
      case NavigationType.myAutomations:
        return "My Automations";
      case NavigationType.chat:
        return "Chat";
      case NavigationType.createAutomation:
        return "Create Automation";
      case NavigationType.integrations:
        return "Integrations";
      case NavigationType.templates:
        return "Templates";
      case NavigationType.settings:
        return "Settings";
      case NavigationType.help:
        return "Help";
    }
  }

  IconData get icon {
    switch (this) {
      case NavigationType.dashboard:
        return Icons.home_rounded;
      case NavigationType.myAutomations:
        return Icons.space_dashboard_outlined;
      case NavigationType.chat:
        return Icons.chat_bubble_outline_rounded;
      case NavigationType.createAutomation:
        return Icons.insert_drive_file_outlined;
      case NavigationType.integrations:
        return Icons.terminal_rounded;
      case NavigationType.templates:
        return Icons.photo_size_select_actual_rounded;
      case NavigationType.settings:
        return Icons.settings;
      case NavigationType.help:
        return Icons.help_outline_rounded;
    }
  }
}
