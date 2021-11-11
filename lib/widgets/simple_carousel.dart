

import 'dart:async';

import 'package:cryptoexpo/widgets/simple_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SimpleCarousel extends StatelessWidget {

  final bool? isUpDownAnimation;
  final int? upDownMilliseconds;
  final int? leftRightMilliseconds;
  final List<Widget> slides;
  final int? slidingAnimationDuration;
  final int currentViewDuration;

  const SimpleCarousel({
    Key? key,
    this.isUpDownAnimation,
    this.upDownMilliseconds,
    this.leftRightMilliseconds,
    required this.slides,
    this.slidingAnimationDuration,
    this.currentViewDuration = 5
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    RxInt _currentPage = 0.obs;

    Timer.periodic(Duration(seconds: currentViewDuration), (Timer timer) {
      if (_currentPage.value < slides.length - 1) {
        _currentPage.value++;
      } else {
        _currentPage.value = 0;
      }
    });


    return Obx(() {
      Widget slide = slides[_currentPage.value];

      return SimpleSlider(
        slide: slide.key == null? Container(
          key: Key('${_currentPage.value}'),
          child: slide,
        ) : slide,
        isUpDownAnimation: isUpDownAnimation?? false,
        milliseconds: slidingAnimationDuration,
      );
    });
  }

}