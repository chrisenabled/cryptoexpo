


import 'package:cryptoexpo/config/themes/app_themes.dart';
import 'package:flutter/material.dart';

class MyTabBar extends StatelessWidget implements PreferredSizeWidget {

  const MyTabBar({
    Key? key,
    required this.tabs,
    this.rightButtonText,
    this.rightButtonIcon,
    this.tabColor,
    this.padding
  }) : super(key: key);

  final List<String> tabs;
  final String? rightButtonText;
  final IconData? rightButtonIcon;
  final Color? tabColor;
  final EdgeInsetsGeometry? padding;

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
            Align(
                alignment: Alignment.centerLeft,
                child: Transform.translate(
                    offset: Offset(-12, 0),
                    //-12 because TabBar applies 12 horizontal padding
                    child: Container(
                        color: tabColor,
                        child: TabBar(
                          isScrollable: true,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorColor: colorScheme.secondary,
                          labelPadding: EdgeInsets.only(bottom: labelPadding, right: 12, left: 12),
                          tabs: tabs.map((name) =>
                              Text(
                                name,
                              )
                          ).toList(),
                        )))),
            if (rightButtonIcon != null || rightButtonText != null)
              Align(
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
              ),
          ]),
          Divider()
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(0);

}