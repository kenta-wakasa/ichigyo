import 'dart:developer' as developer;

class Utils {
  Utils._();
  static final instance = Utils._();

  /// ログを表示したくないときはfalseにする
  bool enableLog = true;

  /// デバッグコンソールにログを表示させる
  void log({
    String? title,
    required Object value,
  }) {
    if (title != null) {
      developer.log('$title: $value');
    } else {
      developer.log('$value');
    }
  }
}
