import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

typedef LottieBottomNavigationSelectedCallback = Function(int selectedPos);

class LottieTabItem {
  final String iconPathOnLight;
  final String iconPathOnDark;
  final String label;
  final double size;

  const LottieTabItem(this.iconPathOnLight, this.iconPathOnDark, this.label,
      {this.size = 0});
}

class LottieBottomNavigation extends StatefulWidget {
  final List<LottieTabItem> tabItems;
  final double itemsSize;
  final Color backgroundColor;
  final LottieBottomNavigationSelectedCallback? selectedCallback;
  final LottieBottomNavigationController? controller;

  LottieBottomNavigation({
    required this.tabItems,
    this.backgroundColor = Colors.white,
    this.selectedCallback,
    this.itemsSize = 24,
    this.controller,
  });

  @override
  State<StatefulWidget> createState() => _LottieBottomNavigationState();
}

class _LottieBottomNavigationState extends State<LottieBottomNavigation>
    with TickerProviderStateMixin {

  late AnimationController idleAnimation;

  late AnimationController onSelectedAnimation;

  // late AnimationController onChangedAnimation; for reverse animation

  late LottieBottomNavigationController _controller;

  var selectedIndex = 0;

  var previousIndex;

  Duration animationDuration = Duration(milliseconds: 700);

  @override
  void initState() {
    super.initState();

    previousIndex = selectedIndex;

    _controller = widget.controller?? LottieBottomNavigationController(selectedIndex);

    idleAnimation = AnimationController(vsync: this);
    onSelectedAnimation =
        AnimationController(vsync: this, duration: animationDuration);
    // onChangedAnimation =
    //     AnimationController(vsync: this, duration: animationDuration);

    _controller.addListener(_newSelectedPosNotify);

    _makeSelectedIndexAnimate();
  }

  @override
  void dispose() {
    super.dispose();
    idleAnimation.dispose();
    onSelectedAnimation.dispose();
    // onChangedAnimation.dispose();
    _controller.removeListener(_newSelectedPosNotify);
  }

  List<BottomNavigationBarItem> barItems() {
    return widget.tabItems.asMap().entries.map((e) {
      int index = e.key;
      final tabItem = e.value;
      return BottomNavigationBarItem(
        icon: Lottie.asset(
            Get.isDarkMode ? tabItem.iconPathOnDark : tabItem.iconPathOnLight,
            height: tabItem.size == 0 ? widget.itemsSize : tabItem.size,
            controller: selectedIndex == index
                ? onSelectedAnimation
                : previousIndex == index
                    ? idleAnimation //onChangedAnimation
                    : idleAnimation),
        label: tabItem.label,
      );
    }).toList();
  }

  _setSelectedIndex(int index) {

    _makeSelectedIndexAnimate();

    // onChangedAnimation.value = 1;
    // onChangedAnimation.reverse();

    if(widget.selectedCallback != null) {
      widget.selectedCallback!(index);
    }

    setState(() {
      previousIndex = selectedIndex;
      selectedIndex = index;
    });
  }

  _makeSelectedIndexAnimate() {
    onSelectedAnimation.reset();
    onSelectedAnimation.forward();
  }

  void _newSelectedPosNotify() {
    printInfo(
        info: "This tab has been selected:"
            " ${widget.tabItems[_controller.value].label}"
    );
    _setSelectedIndex(_controller.value);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          // backgroundColor: widget.backgroundColor,
          currentIndex: selectedIndex,
          onTap: (index) {
            if (index != selectedIndex) {
              _controller.value = index;
            }
          },
          items: barItems(),
        ));
  }
}

class LottieBottomNavigationController extends ValueNotifier<int> {
  LottieBottomNavigationController(int value) : super(value);
}
