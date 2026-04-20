import 'package:crenno_study_case/app.dart';
import 'package:crenno_study_case/core/constants/app.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'core/constants/locale_enum.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: LocaleEnum.values.map((e) => e.locale).toList(),
      path: AppConstants.localizationPath,
      fallbackLocale: LocaleEnum.en.locale,
      child: const InsuranceApp(),
    ),
  );
}
