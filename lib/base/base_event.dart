import '../app/app/app_msg.dart';

abstract class BaseEvent {}

class MessageEvent extends BaseEvent {
  final dynamic msg;

  MessageEvent({
    this.msg,
  });
}

class ToastEvent extends BaseEvent {
  final String msg;
  ToastEvent({
    required this.msg,
  });
}

class ErrorEvent extends BaseEvent {
  final dynamic error;

  ErrorEvent({
    this.error,
  });
}

class LoadingEvent extends BaseEvent {
  final bool isLoading;
  final bool hasBlurBackground;
  final AppMsg? message;

  LoadingEvent({
    required this.isLoading,
    this.hasBlurBackground = true,
    this.message,
  });
}
