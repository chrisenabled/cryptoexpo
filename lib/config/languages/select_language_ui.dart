

import 'package:cryptoexpo/constants/constants.dart';
import 'package:cryptoexpo/widgets/simple_check_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'language_controller.dart';


class SelectLanguage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton (icon:Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: Text('Select your language'),
      ),
      body: _buildLanguageList(),
    );
  }

  Widget _buildLanguageList() {
    return GetBuilder<LanguageController>(
        builder: (controller) {

          final language = controller.currentLanguage;

          final List<Widget> languagesTiles =
          Lang.values.map(
                  (lang) {
                return LanguageTile(
                  language: lang.name,
                  isSelected: language == lang.code? true : false,
                  onClick: (language) async {
                    await controller.updateLanguage(lang.code);
                    Get.forceAppUpdate();
                  },
                );
              }
          ).toList();

          return ListView(children: languagesTiles);

        }
    );
  }
}

typedef LanguageTileOnclick = Function(String language);

class LanguageTile extends StatelessWidget {

  LanguageTile({
    Key? key,
    required this.language,
    this.isSelected = false,
    this.onClick
  }): super(key: key);

  final String language;
  final bool isSelected;
  final LanguageTileOnclick? onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick!(language),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected? Theme.of(context).colorScheme.secondary :
            Theme.of(context).colorScheme.secondaryVariant,
            width: 0.9
          ),
          borderRadius: BorderRadius.all(Radius.circular(5))
        ),
        child: Row(
          children: [
            SimpleCheckBox(
              isRound: true,
              isChecked: isSelected,
            ),
            SizedBox(width: 10),
            Text(language, style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontWeight: FontWeight.bold
            ),)
          ],
        ),
      ),
    );
  }

}