

import 'package:cryptoexpo/config/languages/select_language_ui.dart';
import 'package:cryptoexpo/widgets/simple_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get_storage/get_storage.dart';

class Landing extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Stack(
                children: [
                  SvgPicture.asset(
                    'assets/images/cx-landing.svg',
                    semanticsLabel: 'Landing Page Svg',
                    width: MediaQuery.of(context).size.width,
                  ),
                  SafeArea(
                    child: Align(
                      alignment: Alignment(0.8, 0),
                      child: GestureDetector(
                        onTap: () => Get.to(() => SelectLanguage()),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            border: Border.all(width: 2.0, color: const Color(0xFFFFFFFF))
                          ),
                          child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                    'lang.code'.tr.toString().toUpperCase(),
                                    style: Theme.of(context).textTheme.caption?.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold
                                    )
                                ),
                                SizedBox(width: 5,),
                                Icon(
                                  Icons.keyboard_arrow_down_sharp,
                                  size: 16,
                                )
                              ],
                            ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Column(
              children: [
                Text(
                  'landing.WelcomeMsg'.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    'landing.WelcomeMsgSubtitle'.tr,
                    style: TextStyle(
                        color: Colors.black54
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SimpleButton(
                  text: 'landing.GetStartedButtonText'.tr,
                  onPressed: () {},
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('question.haveAccount'.tr),
                    TextButton(onPressed: (){}, child: Text('auth.signInButton'.tr))
                  ],
                )
              ],
            ),
          ],
        ),

      );
  }

}