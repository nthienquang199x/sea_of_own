import 'dart:math' as math;

extension WatchedPercentageExt on int? {
  double watchedPercentage(double? watchedSeconds) {
    if (this == null ||
        this! <= 0 ||
        watchedSeconds == null ||
        watchedSeconds <= 0) {
      return 0.0;
    }
    final percentage = (watchedSeconds / this!) * 100;
    return math.min(percentage, 100.0);
  }
}
