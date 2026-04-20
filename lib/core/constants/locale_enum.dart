import 'dart:ui';

enum LocaleEnum {
  en(Locale("en")),
  tr(Locale("tr"));

  final Locale locale;
  const LocaleEnum(this.locale);
}
