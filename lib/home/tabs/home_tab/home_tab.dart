
import 'package:athaar_app/home/widget/app_bar_widget.dart';
import 'package:athaar_app/home/widget/scroll_widget.dart';
import 'package:athaar_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../../../providers/app_theme_provider.dart';

class HomeTab extends StatefulWidget {
  final VoidCallback onScrollDown;
  final VoidCallback onScrollUp;

  const HomeTab({
    super.key,
    required this.onScrollDown,
    required this.onScrollUp,
  });

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return Scaffold(
      backgroundColor: themeProvider.isDarkMode()
          ? AppColors.darkColor
          : AppColors.whiteColor,

      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          if (notification.depth != 0 ||
              notification.metrics.axis != Axis.vertical) {
            return false;
          }

          if (notification.direction == ScrollDirection.reverse) {
            widget.onScrollDown();
          } else if (notification.direction ==
              ScrollDirection.forward) {
            widget.onScrollUp();
          }

          return false;
        },

        child: const CustomScrollView(
          slivers: [
            AppBarWidget(),
            ScrollWidget(),
          ],
        ),
      ),
    );
  }
}
