

import 'dart:async';

import 'package:cryptoexpo/widgets/simple_carousel.dart';
import 'package:cryptoexpo/widgets/simple_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewsSnippets extends StatelessWidget {

  const NewsSnippets({
    required this.news,
    this.onPressed,
    this.isUpDownAnimation = false,
  });

  final List<String> news;
  final Function()? onPressed;
  final isUpDownAnimation;

  @override
  Widget build(BuildContext context) {

    RxInt _currentPage = 0.obs;

    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage.value < news.length - 1) {
        _currentPage.value++;
      } else {
        _currentPage.value = 0;
      }
    });

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Row(
        children: [
          Icon(
            CupertinoIcons.news_solid,
            size: 15,
            color: Theme.of(context).colorScheme.secondary,
          ),
          SizedBox(width: 5,),
          Text('News', style: Theme.of(context).textTheme.caption!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          )),
          SizedBox(width: 10,),
          Expanded(
              child: SimpleCarousel(
                isUpDownAnimation: true,
                slides: news.map((news) => Text(
                  news,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.caption!.copyWith(
                      fontSize: 13
                  ),
                  overflow: TextOverflow.ellipsis,
                )).toList(),
              )
          )
        ],
      ),
    );
  }



}