import 'package:crenno_study_case/core/config/router.dart';
import 'package:crenno_study_case/core/constants/string_constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class InsuranceApp extends StatelessWidget {
  const InsuranceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router(),
      debugShowCheckedModeBanner: false,
      title: StringConstants.appTitle,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: const [Locale('en')],
      locale: const Locale('en'),
      theme: ThemeData(useMaterial3: false),
    );
  }
}
