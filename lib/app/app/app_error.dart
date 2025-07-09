enum AppError {
  unKnown,
}

extension AppErrorExt on AppError {
  String get message {
    switch (this) {
      case AppError.unKnown:
        return 'unknown';
    }
  }
}
