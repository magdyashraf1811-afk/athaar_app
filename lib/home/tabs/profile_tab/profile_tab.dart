import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:athaar_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../../providers/app_theme_provider.dart';
import '../../../utils/app_theme.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    bool isChanged = false;

    return ThemeSwitchingArea(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.04,
              vertical: height * 0.04,
            ),
            child: Column(
              spacing: 20,
              children: [
                Column(
                  spacing: height * 0.02,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                      decoration: BoxDecoration(
                        color: themeProvider.isDarkMode()
                            ? AppColors.transparentColor
                            : AppColors.whiteColor,
                        border: Border.all(
                          color: themeProvider.isDarkMode()
                              ? AppColors.whiteColor
                              : AppColors.whiteColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            themeProvider.isDarkMode()
                                ? AppLocalizations.of(context)!.dark_mode
                                : AppLocalizations.of(context)!.light_mode,
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          ThemeSwitcher(
                            builder: (context) => IconButton(
                              onPressed: () async {
                                if (isChanged) return;

                                isChanged = true;

                                final isDark = themeProvider.isDarkMode();

                                final newTheme = isDark
                                    ? AppTheme.lightTheme
                                    : AppTheme.darkTheme;

                                ThemeSwitcher.of(context).changeTheme(
                                  theme: newTheme,
                                  isReversed: isDark,
                                );

                                themeProvider.changeThemeLanguage(
                                  isDark ? ThemeMode.light : ThemeMode.dark,
                                );

                                await Future.delayed(
                                  const Duration(seconds: 5),
                                );

                                if (mounted) {
                                  setState(() {
                                    isChanged = false;
                                  });
                                }
                              },
                              icon: Icon(
                                color: AppColors.gold,
                                themeProvider.isDarkMode()
                                    ? Icons.dark_mode_outlined
                                    : Icons.light_mode_outlined,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
