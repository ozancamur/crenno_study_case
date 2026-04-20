import 'package:crenno_study_case/core/components/custom_text.dart';
import 'package:crenno_study_case/core/constants/locale_enum.dart';
import 'package:crenno_study_case/core/constants/string_constants.dart';
import 'package:crenno_study_case/core/network/dio.dart';
import 'package:crenno_study_case/core/utils/context_extension.dart';
import 'package:crenno_study_case/features/dashboard/domain/usecases/get_policies.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/dashboard_bloc.dart';
import '../widgets/dashboard_empty.dart';
import '../widgets/dashboard_error.dart';
import '../widgets/dashboard_loaded.dart';
import '../widgets/dashboard_loading.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key, required this.getPolicies});

  final GetPolicies getPolicies;

  @override
  Widget build(BuildContext context) {
    DioService().setAcceptLanguage(context.locale.languageCode);

    return BlocProvider(
      create: (context) =>
          DashboardBloc(getPolicies: getPolicies)
            ..add(const DashboardPoliciesRequested()),
      child: Builder(
        builder: (context) {
          Future<void> onRefresh() async {
            final bloc = context.read<DashboardBloc>();
            bloc.add(const DashboardPoliciesRequested());
            await bloc.stream.firstWhere(
              (state) => state.status != DashboardStatus.loading,
            );
          }

          Future<void> onLanguageSelected(Locale locale) async {
            await context.setLocale(locale);
            DioService().setAcceptLanguage(locale.languageCode);
            if (!context.mounted) {
              return;
            }
            context.read<DashboardBloc>().add(
              const DashboardPoliciesRequested(),
            );
          }

          final selectedLanguage = context.locale.languageCode.toLowerCase();

          return Scaffold(
            appBar: AppBar(
              title: CustomText(
                text: StringConstants.dashboardTitle,
                color: Theme.of(context).colorScheme.onPrimary,
                weight: FontWeight.w600,
              ),
              actions: [
                _LanguageSwitch(
                  selectedLanguage: selectedLanguage,
                  onSelectEn: () => onLanguageSelected(LocaleEnum.EN.locale),
                  onSelectTr: () => onLanguageSelected(LocaleEnum.TR.locale),
                ),
                SizedBox(width: context.width * 0.03),
              ],
            ),
            body: RefreshIndicator(
              onRefresh: onRefresh,
              child: BlocBuilder<DashboardBloc, DashboardState>(
                builder: (context, state) {
                  switch (state.status) {
                    case DashboardStatus.initial:
                    case DashboardStatus.loading:
                      return const DashboardLoadingWidget();
                    case DashboardStatus.loaded:
                      if (state.policies.isEmpty) {
                        return DashboardEmptyWidget(
                          onRefresh: () {
                            context.read<DashboardBloc>().add(
                              const DashboardPoliciesRequested(),
                            );
                          },
                        );
                      }

                      return DashboardLoadedWidget(
                        policies: state.policies,
                        onPolicyTap: (policy) {
                          context.push('/policy/${policy.id}', extra: policy);
                        },
                      );
                    case DashboardStatus.error:
                      return DashboardErrorWidget(
                        message: StringConstants.dashboardErrorDescription,
                        onRetry: () {
                          context.read<DashboardBloc>().add(
                            const DashboardPoliciesRequested(),
                          );
                        },
                      );
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class _LanguageSwitch extends StatelessWidget {
  const _LanguageSwitch({
    required this.selectedLanguage,
    required this.onSelectEn,
    required this.onSelectTr,
  });

  final String selectedLanguage;
  final VoidCallback onSelectEn;
  final VoidCallback onSelectTr;

  @override
  Widget build(BuildContext context) {
    final isEnSelected = selectedLanguage == 'en';
    final textColor = Theme.of(context).colorScheme.onPrimary;
    final currentFlag = isEnSelected ? '🇬🇧' : '🇹🇷';
    final currentLanguageLabel = isEnSelected
        ? StringConstants.commonEnglish
        : StringConstants.commonTurkish;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: context.width * 0.02,
        vertical: context.height * 0.01,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => isEnSelected ? onSelectTr() : onSelectEn(),
            child: Container(
              width: context.width * 0.16,
              height: context.height * 0.04,
              padding: EdgeInsets.symmetric(horizontal: context.width * 0.007),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(context.width * 0.08),
              ),
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeInOut,
                alignment: isEnSelected
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Container(
                  width: context.height * 0.03,
                  height: context.height * 0.03,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: CustomText(
                      text: currentFlag,
                      tr: false,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: context.width * 0.01),
          CustomText(
            text: currentLanguageLabel,
            color: textColor,
            weight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
