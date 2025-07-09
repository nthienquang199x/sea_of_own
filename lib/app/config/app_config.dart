class AppConfig {
  final String appName;

  AppConfig({
    required this.appName,
  });

  factory AppConfig.prod() => AppConfig(appName: 'RoomMobileWeb');
}
