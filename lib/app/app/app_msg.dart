enum AppMsg {
  unKnown,
}

extension AppMsgExt on AppMsg {
  String get message {
    switch (this) {
      case AppMsg.unKnown:
        return 'unknown';
    }
  }
}
