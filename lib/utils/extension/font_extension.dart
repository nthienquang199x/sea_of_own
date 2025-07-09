// ignore_for_file: constant_identifier_names

enum FontFamily { SpaceGrotesk }

extension FontFamilyExtension on FontFamily {
  String get name {
    switch (this) {
      case FontFamily.SpaceGrotesk:
        return 'SpaceGrotesk';
    }
  }
}
