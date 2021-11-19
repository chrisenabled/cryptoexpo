import 'package:cryptoexpo/constants/test_data.dart';
import 'package:cryptoexpo/modules/models/country_model.dart';
import 'package:cryptoexpo/utils/helpers/validator.dart';
import 'package:cryptoexpo/utils/ui/widgets.dart';
import 'package:cryptoexpo/widgets/simple_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyFormField extends StatelessWidget {
  static const String email = 'Email';
  static const String password = 'Password';
  static const String mobile = 'Mobile';

  final String? inputType;
  final Widget? bottomWidget;
  final bool includeBottomWidgetOnToggle = false;

  MyFormField({
    Key? key,
    this.inputType,
    this.bottomWidget
  }) : super(key: key);

  final RxString _inputType = ''.obs;

  final Rx<CountryModel> _countryModel = countryModels[0].obs;

  @override
  Widget build(BuildContext context) {

    _inputType.value = inputType?? email;

    return Container(
      child: Obx(() => Column(
            children: [
              _buildHeading(context),
              SimpleSlider(
                  isUpDownAnimation: true,
                  slide: _getFormField(context, _inputType.value)
              ),
              if((null != bottomWidget &&
                  (_inputType.value == inputType || _inputType.value == email))
                  || (null != bottomWidget && includeBottomWidgetOnToggle)
              ) bottomWidget!
            ],
          )),
    );
  }

  Widget _getFormField(BuildContext context, String inputType) {
    if (inputType == MyFormField.mobile)
      return _mobileTextFormField(context);
    if (inputType == MyFormField.password)
      return _passwordTextFormField(context);
    return _emailTextFormField(context);
  }

  Padding _buildHeading(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _headerText(context),
          if (_inputType.value != MyFormField.password) _headerButton()
        ],
      ),
    );
  }

  Widget _headerText(BuildContext context) {
    return Text(
      _inputType.value,
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.secondaryVariant),
    );
  }

  Widget _headerButton() {
    return _inputType.value == MyFormField.email
        ? TextButton(
            child: Text('Log in with mobile'),
            onPressed: () => _inputType.value = MyFormField.mobile,
          )
        : TextButton(
            child: Text('Log in with email'),
            onPressed: () => _inputType.value = MyFormField.email,
          );
  }

  Widget _emailTextFormField(BuildContext context) {
    return _MyFormFieldBuilder(
      key: Key(email),
      builder: (context, controller, focusNode, state) {
        return myTextFormField(
          context: context,
          controller: controller,
          focusNode: focusNode,
          hintText: 'Enter email',
          inputType: TextInputType.emailAddress,
          validator: Validator().email
        );
      },
    );
  }

  Widget _mobileTextFormField(BuildContext context) {
    Widget countryCodeSelector() {
      return GestureDetector(
        onTap: () {
          showCountryModalBottomSheet(
            context: context,
            countryModels: countryModels,
            onPressed: (selectedCountry) {
              _countryModel.value = selectedCountry;
            },
          );
        },
        child: Obx(() => countryCodeIndicator(
          iconSize: 16,
            context: context,
            countryAsset: _countryModel.value.asset,
            dialCode: '${_countryModel.value.countryDetails.dialCode}'
        )),
      );
    }

    return _MyFormFieldBuilder(
        key: Key(mobile),
        builder: (context, controller, focusNode, state) {
          return myTextFormField(
            prefix: Container(
              padding: EdgeInsets.only(left: 15),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  countryCodeSelector(),
                  SizedBox(width: 10),
                  verticalLine(context: context),
                  SizedBox(width: 10),
                ],
              ),
            ),
            context: context,
            hintText: 'Enter phone number',
            controller: controller,
            focusNode: focusNode,
            inputType: TextInputType.phone,
          );
        }
    );
  }

  Widget _passwordTextFormField(BuildContext context) {
    return _MyFormFieldBuilder(
        key: Key(password),
        builder: (context, controller,focusNode, state) {
          return myTextFormField(
            key: Key(password),
            context: context,
            controller: controller,
            focusNode: focusNode,
            hintText: 'Enter your password',
            inputType: TextInputType.visiblePassword,
            obscureText: true,
          );
        }
    );
  }
}

class _MyFormFieldBuilder extends StatelessWidget {

  static const int IsEmpty = 0;
  static const int NotEmpty = 1;
  static const int NoFocus = 3;
  static const int HasFocus = 4;

  _MyFormFieldBuilder({
    Key? key,
    required this.builder,
    this.validator,
    this.onError,
  }) : super(key: key) ;

  final Widget Function(
      BuildContext,
      TextEditingController,
      FocusNode,
      List<int>) builder;

  final String? Function(String? value)? validator;

  final void Function(String? error)? onError;

  @override
  Widget build(BuildContext context) {

    TextEditingController? controller;
    FocusNode? focusNode;
    bool isControllerInitiated = false;
    bool isFocusNodeInitiated = false;

    return ValueBuilder<List<int>?>(
      initialValue: [],
      builder: (state, updateFn) {
        if(!isFocusNodeInitiated && null == focusNode) {
          isFocusNodeInitiated = true;
          focusNode = FocusNode();
          // focusNode!.addListener(() {
          //   if(focusNode!.hasFocus) {
          //     if(state!.contains(NoFocus)) {
          //       state.remove(NoFocus);
          //     }
          //     if(!state.contains(HasFocus)) {
          //       state.add(HasFocus);
          //     }
          //   } else {
          //     if(state!.contains(HasFocus)) {
          //       state.remove(HasFocus);
          //     }
          //     if(!state.contains(NoFocus)) {
          //       state.add(NoFocus);
          //     }
          //   }
          //   if(controller!.text.isNotEmpty) {
          //     var error = validator!(controller!.text)?? '';
          //     onError!(error);
          //   } else {
          //     onError!('');
          //   }
          //   updateFn(state);
          // });
        }
        if (!isControllerInitiated && null == controller) {
          isControllerInitiated = true;
          controller = TextEditingController();

          controller!.addListener(() {
            if (controller!.text.isEmpty) {
              if(state!.contains(NotEmpty)){
                state.remove(NotEmpty);
              }
              if(!state.contains(IsEmpty)){
                state.add(IsEmpty);
                updateFn(state);
              }
            } else {
              if(state!.contains(IsEmpty)) {
                state.remove(IsEmpty);
              }
              if(!state.contains(NotEmpty)) {
                state.add(NotEmpty);
                updateFn(state);
              }
            }
          });
        }
        return builder(context, controller!, focusNode!, state!);
      },
      // if you need to call something outside the builder method.
      onUpdate: (state) => print("_MyFormFieldBuilder State updated: $state"),
      onDispose: () {
        print("_MyFormFieldBuilder ValueBuilder Widget unmounted");
        // the animatedSwitcher calls Dispose twice so we need to delay controller. dispose()
        // to avoid calling it twice and thus having an exception thrown
        Future.delayed(const Duration(milliseconds: 500), () {
          if (null != controller) {
            controller!.dispose();
            controller = null;
            isControllerInitiated = false;
          }
        });
      },
    );
  }

}
