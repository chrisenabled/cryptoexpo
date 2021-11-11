

import 'dart:async';

import 'package:cryptoexpo/config/themes/app_themes.dart';
import 'package:cryptoexpo/widgets/simple_carousel.dart';
import 'package:cryptoexpo/widgets/simple_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BillboardAds extends StatelessWidget {

  final List<Widget> views;

  const BillboardAds({
    Key? key,
    required this.views
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxInt _currentPage = 0.obs;

    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage.value < views.length - 1) {
        _currentPage.value++;
      } else {
        _currentPage.value = 0;
      }
    });

    return Column(
      children: [
        SimpleCarousel(
          slidingAnimationDuration: 500,
            slides: views.map((view) => Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                decoration: BoxDecoration(
                    color: MyColors.trueBlue,
                    borderRadius: BorderRadius.circular(15)
                ),
                key: view.key,
                height: 130,
                width: double.infinity,
                child: Center(
                    child: view
                )
            )).toList()
        ),
        SizedBox(height: 6,),
        Obx(() => DotIndicator(
          number: views.length,
          selectedIndex: _currentPage.value,
        ))
      ],
    );

  }

}

class DotIndicator extends StatelessWidget {

  final int number;
  final int selectedIndex;

  const DotIndicator({
    Key? key,
    required this.number,
    this.selectedIndex = 0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(number, (index) => SimpleDot(
        isSelected: index == selectedIndex,
      )),
    );
  }

}

class SimpleDot extends StatelessWidget {

  final bool isSelected;
  final double horizontalMargin;

  const SimpleDot({
    Key? key,
    this.isSelected = false,
    this.horizontalMargin = 4.0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
        angle: 95,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
          width: isSelected? 5 : 4,
          height: isSelected? 5 : 4,
          color: isSelected? Theme.of(context).colorScheme.onPrimary :
          Theme.of(context).colorScheme.secondaryVariant,
        )
    );
  }

}