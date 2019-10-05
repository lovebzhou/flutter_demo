/// 日志
class Log {
  static void exception(dynamic content, {String tag}) {
    print('EXCEPTION:${tag ?? ""} $content');
  }

  static void e(dynamic content, {String tag}) {
    print('ERROR:${tag ?? ""} $content');
  }

  static void w(dynamic content, {String tag}) {
    print('WARN:${tag ?? ""} $content');
  }

  static void i(dynamic content, {String tag}) {
    print('INFO:${tag ?? ""} $content');
  }

  static void d(dynamic content, {String tag}) {
    print('DEBUG:${tag ?? ""} $content');
  }

  static void v(dynamic content, {String tag}) {
    print('VERBOSE:${tag ?? ""} $content');
  }
}
