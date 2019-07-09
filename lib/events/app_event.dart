/// App全局事件
///
/// - 语言切换
/// - 界面配色
///

/// 语言变更
class LocaleChangedEvent {
  final String languageCode;
  final String countryCode;

  LocaleChangedEvent({this.languageCode, this.countryCode});
}
