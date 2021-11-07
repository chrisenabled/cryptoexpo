

import 'package:cryptoexpo/widgets/simple_button.dart';
import 'package:cryptoexpo/widgets/simple_check_box.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class TermsOfUse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    TextTheme textTheme = Theme.of(context).textTheme;

    RxBool agreed = false.obs;

    return Scaffold(
      appBar: AppBar(
          leading: IconButton (icon:Icon(Icons.arrow_back),
            onPressed: () => Get.back(),
          )
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right:20, top: 10, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Text("Terms of Use", style: textTheme.headline2!.copyWith(
                      fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                ExternalLinkButton(text: 'Terms of service', onPressed: () {}),
                SizedBox(height: 15,),
                ExternalLinkButton(text: 'Privacy Policy', onPressed: () {})
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    Transform.translate(
                      offset: Offset(0,-7),
                      child: SimpleCheckBox(
                        onPressed: (isChecked) {
                          if(isChecked == true) {
                            agreed.value = true;
                          } else {
                            agreed.value = false;
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: Text(
                        'I have read and accepted the Terms of Service and Privacy Policy',
                        overflow: TextOverflow.clip,
                        style: textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.bold,
                          wordSpacing: 1.5
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 15,),
                GestureDetector(
                  onTap: () {
                    if(agreed.isTrue) {

                    }
                  },
                  child: Obx(() => SimpleButton(
                    isEnabled: agreed.value,
                    text: 'Enter Crypto Expo',
                    onPressed: (){},
                    icon: Icons.chevron_right_rounded,
                  )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

}



class ExternalLinkButton extends StatelessWidget {

  ExternalLinkButton({
    required this.text,
    required this.onPressed,
});

  final String text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () => onPressed,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(3)),
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text, style: textTheme.bodyText2?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary
            ),),
            FaIcon(
                FontAwesomeIcons.externalLinkAlt, size: 12,
                color: Theme.of(context).colorScheme.secondary
            )
          ],
        ),
      ),
    );
  }

}