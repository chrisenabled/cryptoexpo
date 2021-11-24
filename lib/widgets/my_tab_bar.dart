


import 'package:cryptoexpo/config/themes/app_themes.dart';
import 'package:cryptoexpo/config/themes/theme_controller.dart';
import 'package:flutter/material.dart';

class MyTabBar extends StatelessWidget implements PreferredSizeWidget {

  const MyTabBar({
    Key? key,
    required this.tabs,
    this.rightButtonText,
    this.rightButtonIcon,
    this.tabColor,
    this.padding,
    this.isCapsuleStyle = false,
    this.isScrollable = true,
  }) : super(key: key);

  final List<String> tabs;
  final String? rightButtonText;
  final IconData? rightButtonIcon;
  final Color? tabColor;
  final EdgeInsetsGeometry? padding;
  final bool isCapsuleStyle;
  final bool isScrollable;

  @override
  Widget build(BuildContext context) {

    double labelPadding = 8.0;
    final textTranslateY = labelPadding ;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      color: Theme.of(context).colorScheme.primary,
      padding: padding,
      child: Column(
        children: [
          Stack(children: <Widget>[
            isCapsuleStyle
                ? _buildTabCapsule(context, colorScheme)
                :_buildTab(colorScheme, labelPadding),
            if (rightButtonIcon != null || rightButtonText != null)
              _buildRightButton(textTranslateY),
          ]),
          if(!isCapsuleStyle) Divider()
        ],
      ),
    );
  }

  Align _buildRightButton(double textTranslateY) {
    return Align(
              alignment: Alignment.centerRight,
              child: Transform.translate(
                offset: Offset(0, textTranslateY),
                child: GestureDetector(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (rightButtonIcon != null)
                        Icon(
                          rightButtonIcon,
                          size: 16,
                        ),
                      if (rightButtonIcon != null && rightButtonText != null)
                        SizedBox(width: 5,),
                      if (rightButtonText != null) Text(rightButtonText!),
                    ],
                  ),
                  onTap: () {
                    print('Pressed');
                  },
                ),
              ),
            );
  }

  Widget _buildTabCapsule(BuildContext context, ColorScheme colorScheme) {
    final radius =  Radius.circular(10);
    var labelStyle = Theme.of(context).tabBarTheme.labelStyle;

    // the default shadows in the appTheme does not fit well when in dark mode
    // so we change remove it for dark mode
    if(ThemeController.to.isDarkModeOn) {
      labelStyle = labelStyle!.copyWith(
        shadows: []
      );
    }

    return TabBar(
        isScrollable: isScrollable,
        // labelPadding: EdgeInsets.symmetric(vertical:8.0),
        labelColor: colorScheme.primary,
        labelStyle: labelStyle,
        unselectedLabelColor: colorScheme.onPrimary,
        indicator: ShapeDecoration(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(radius)
            ),
            color: colorScheme.secondary
        ),
        tabs: tabs.map((name) =>
            Text(
              name,
            )
        ).toList()
    );
  }

  Widget _buildTab(ColorScheme colorScheme, double labelPadding) {
    return Align(
              alignment: Alignment.centerLeft,
              child: Transform.translate(
                  offset: Offset(-12, 0),
                  //-12 because TabBar applies 12 horizontal padding
                  child: Container(
                      color: tabColor,
                      child: TabBar(
                        isScrollable: isScrollable,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorColor: colorScheme.secondary,
                        labelPadding: EdgeInsets.only(bottom: labelPadding, right: 12, left: 12),
                        tabs: tabs.map((name) =>
                            Text(
                              name,
                            )
                        ).toList(),
                      ))));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(0);

}