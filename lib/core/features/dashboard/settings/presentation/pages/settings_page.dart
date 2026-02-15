import 'package:finance_treker/core/constants/app_icons.dart';
import 'package:finance_treker/core/constants/app_strings.dart';
import 'package:finance_treker/core/constants/app_text_styles.dart';
import 'package:finance_treker/core/theme/theme_cubit.dart';
import 'package:finance_treker/core/widgets/app_svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [

          Text(
            AppStrings.settings,
            style:
                AppTextStyles.headlineLarge(context),
          ),

          const SizedBox(height: 30),


          _settingsCard(
            context,
            child: BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, themeMode) {
                final isDark =
                    themeMode == ThemeMode.dark;

                return Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const AppSvgIcon(
                          path: AppIcons.settings,
                          size: 22,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          AppStrings.darkMode,
                          style:
                              AppTextStyles.bodyLarge(
                                  context),
                        ),
                      ],
                    ),
                    Switch(
                      value: isDark,
                      onChanged: (_) {
                        context
                            .read<ThemeCubit>()
                            .toggleTheme();
                      },
                    ),
                  ],
                );
              },
            ),
          ),

          const SizedBox(height: 20),

  
          _settingsCard(
            context,
            child: Row(
              children: [
                const AppSvgIcon(
                  path: AppIcons.bell,
                  size: 22,
                ),
                const SizedBox(width: 12),
                Text(
                  "Finance App v1.0.0",
                  style:
                      AppTextStyles.bodyMedium(
                          context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }



  Widget _settingsCard(
    BuildContext context, {
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
