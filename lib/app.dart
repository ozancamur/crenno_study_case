import 'package:crenno_study_case/core/config/router.dart';
import 'package:crenno_study_case/core/constants/string_constants.dart';
import 'package:crenno_study_case/core/di/app_dependencies.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class InsuranceApp extends StatefulWidget {
  const InsuranceApp({super.key});

  @override
  State<InsuranceApp> createState() => _InsuranceAppState();
}

class _InsuranceAppState extends State<InsuranceApp> {
  late final AppDependencies _dependencies;

  @override
  void initState() {
    super.initState();
    _dependencies = AppDependencies.create();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router(_dependencies),
      debugShowCheckedModeBanner: false,
      title: StringConstants.appTitle,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: const [Locale('en')],
      locale: const Locale('en'),
      theme: ThemeData(useMaterial3: false),
    );
  }
}
