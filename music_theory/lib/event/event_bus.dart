import 'package:event_bus/event_bus.dart';

class GlobalEvent {
  static EventBus eventBus = new EventBus();
}

/// Token过期
class TokenExpiredEvent {}

/// 登录成功
class LoginEvent {}

/// 退出登录
class LogoutEvent {}
