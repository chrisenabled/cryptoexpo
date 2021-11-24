

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
            Expanded(
              flex: 4,
              child: Container(
                child: Stack(
                  children: [
                    SvgPicture.asset(
                      'assets/images/cx-landing.svg',
                      semanticsLabel: 'Landing Page Svg',
                      width: MediaQuery.of(context).size.width,
                    ),
                    _buildLanguageSelector(context)
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: _buildWelcomeMsg(context),
            ),
            Expanded(
              flex: 2,
              child: _buildButtons(),
            ),
          ],
        ),

      );
  }

  Column _buildButtons() {
    return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SimpleButton(
                  text: 'landing.GetStartedButtonText'.tr,
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  onPressed: () {},
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('question.haveAccount'.tr),
                      SizedBox(width: 10,),
                      TextButton(onPressed: (){}, child: Text('auth.signInButton'.tr))
                    ],
                  ),
                )
              ],
            );
  }

  Column _buildWelcomeMsg(BuildContext context) {
    return Column(
              mainAxisAlignment: MainAxisAlignment.end,
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
                    style: Theme.of(context).textTheme.subtitle1,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            );
  }

  SafeArea _buildLanguageSelector(BuildContext context) {
    return SafeArea(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Transform.translate(
                      offset: Offset(-10, 20),
                      child: GestureDetector(
                        onTap: () => Get.to(() => SelectLanguage()),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary.withOpacity(0.7),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            border: Border.all(
                                width: 2.0,
                                color: Theme.of(context).colorScheme.primary
                            )
                          ),
                          child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                    'lang.code'.tr.toString().toUpperCase(),
                                    style: Theme.of(context).textTheme.caption?.copyWith(
                                        color: Theme.of(context).colorScheme.onPrimary,
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
                  ),
                );
  }

}