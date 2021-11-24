import 'package:cryptoexpo/modules/models/country_model.dart';
import 'package:cryptoexpo/widgets/country_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget circularImage(
    {required String asset, required double size, String? package}) {
  return Container(
    height: size,
    width: size,
    decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: new DecorationImage(
            fit: BoxFit.fill,
            image: new AssetImage(
              asset,
              package: package,
            )
        )
    ),
  );
}

TextFormField myTextFormField({
  Key? key,
  required BuildContext context,
  String? hintText,
  TextInputType? inputType,
  bool? obscureText,
  TextEditingController? controller,
  FocusNode? focusNode,
  Widget? prefix,
  String? Function(String?)? validator,
  String? helperText,
  TextStyle? style,
}) {

  return TextFormField(
    key: key,
    decoration: new InputDecoration(
      helperText: helperText,
      prefixIcon: prefix,
      suffix: controller!.text.isEmpty
          ? null
          : textFormFieldCancelButton(context: context, controller: controller),
      hintText: hintText,
    ),
    keyboardType: inputType ?? TextInputType.emailAddress,
    autocorrect: false,
    obscureText: obscureText ?? false,
    controller: controller,
    focusNode: focusNode,
    validator: validator,
    // autovalidateMode: AutovalidateMode.onUserInteraction,
    style: style ??
        Theme.of(context).textTheme.headline5!.copyWith(letterSpacing: 0.7),
  );
}

Widget verticalLine({
  required BuildContext context,
  double? width,
  double? height,
}) {
  return Container(
    height: height ?? 15,
    decoration: BoxDecoration(
        border: Border(
            left: BorderSide(
                width: width ?? 1,
                color: Theme.of(context)
                    .colorScheme
                    .secondaryVariant
                    .withOpacity(0.2)))),
  );
}

Widget textFormFieldCancelButton(
    {required BuildContext context, TextEditingController? controller}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 5),
    padding: EdgeInsets.all(1.0),
    child: GestureDetector(
      onTap: () {
        controller!.clear();
      },
      child: Icon(
        Icons.cancel,
        size: 16,
        color: Theme.of(context).colorScheme.secondaryVariant,
      ),
    ),
  );
}

Future<dynamic> showCountryModalBottomSheet(
    {required BuildContext context,
    required List<CountryModel> countryModels,
    required Function(CountryModel) onPressed}) {
  return showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(0, AppBar().preferredSize.height, 0, 0),
          child: Column(
            children: [
              Expanded(
                  child: CountryList(
                countryModels: countryModels,
                onPressed: onPressed,
              )),
            ],
          ),
        );
      });
}

Widget countryCodeIndicator({
  required BuildContext context,
  required String countryAsset,
  required String dialCode,
  double iconSize = 11,
}) {
  return Padding(
    padding: const EdgeInsets.all(1.0),
    child: Row(
      children: [
        circularImage(
            asset: countryAsset, size: iconSize, package: 'country_icons'),
        SizedBox(
          width: 8,
        ),
        Text(
          '$dialCode',
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        SizedBox(width: 7),
        Icon(
          CupertinoIcons.arrowtriangle_down_fill,
          size: 11,
          color: Theme.of(context).colorScheme.secondaryVariant,
        ),
      ],
    ),
  );
}
