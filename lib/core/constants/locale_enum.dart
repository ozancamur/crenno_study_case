import 'dart:ui';

enum LocaleEnum {
  EN(Locale("en")),
  TR(Locale("tr"));

  final Locale locale;
  const LocaleEnum(this.locale);
}
