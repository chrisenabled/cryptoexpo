import 'package:cryptoexpo/utils/helpers/validator.dart';
import 'package:cryptoexpo/widgets/my_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:core';
import 'package:get/get.dart';
import 'package:cryptoexpo/core/auth/auth.dart';
import 'package:cryptoexpo/widgets/widgets.dart';

import 'auth_controller.dart';

class SignInUI extends StatelessWidget {
  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  LogoGraphicHeader(),
                  SizedBox(height: 48.0),
                  // MyFormField(inputType: MyFormField.mobile,),
                  FormInputFieldWithIcon(
                    controller: authController.emailController,
                    iconPrefix: Icons.email,
                    labelText: 'auth.emailFormField'.tr,
                    validator: Validator().email,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => null,
                    onSaved: (value) =>
                    authController.emailController.text = value!,
                  ),
                  FormVerticalSpace(),
                  // MyFormField(inputType: MyFormField.password,),
                  FormInputFieldWithIcon(
                    controller: authController.passwordController,
                    iconPrefix: Icons.lock,
                    labelText: 'auth.passwordFormField'.tr,
                    validator: Validator().password,
                    obscureText: true,
                    onChanged: (value) => null,
                    onSaved: (value) =>
                    authController.passwordController.text = value!,
                    maxLines: 1,
                  ),
                  FormVerticalSpace(),
                  // PrimaryButton(
                  //     labelText: 'auth.signInButton'.tr,
                  //     onPressed: () async {
                  //       if (_formKey.currentState!.validate()) {
                  //         authController.signInWithEmailAndPassword(context);
                  //       }
                  //     }),
                  FormVerticalSpace(),
                  LabelButton(
                    labelText: 'auth.resetPasswordLabelButton'.tr,
                    onPressed: () => Get.to(ResetPasswordUI()),
                  ),
                  LabelButton(
                    labelText: 'auth.signUpLabelButton'.tr,
                    onPressed: () => Get.to(() => SignUpUI()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// class SignInUI extends StatelessWidget {
//   final AuthController authController = AuthController.to;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   Widget emailField() {
//     return FormInputFieldWithIcon(
//       controller: authController.emailController,
//       iconPrefix: Icons.email,
//       labelText: 'auth.emailFormField'.tr,
//       validator: Validator().email,
//       keyboardType: TextInputType.emailAddress,
//       onChanged: (value) => null,
//       onSaved: (value) => authController.emailController.text = value!,
//     );
//   }
//
//   Widget passwordField() {
//     return FormInputFieldWithIcon(
//       controller: authController.passwordController,
//       iconPrefix: Icons.lock,
//       labelText: 'auth.passwordFormField'.tr,
//       validator: Validator().password,
//       obscureText: true,
//       onChanged: (value) => null,
//       onSaved: (value) => authController.passwordController.text = value!,
//       maxLines: 1,
//     );
//   }
//
//   Widget signUpForm(context) {
//     return Column(
//       key: Key("signup"),
//       children: [
//         LogoGraphicHeader(),
//         SizedBox(height: 48.0),
//         FormInputFieldWithIcon(
//           controller: authController.nameController,
//           iconPrefix: Icons.person,
//           labelText: 'auth.nameFormField'.tr,
//           validator: Validator().name,
//           onChanged: (value) => null,
//           onSaved: (value) => authController.nameController.text = value!,
//         ),
//         FormVerticalSpace(),
//         emailField(),
//         FormVerticalSpace(),
//         passwordField(),
//         FormVerticalSpace(),
//         PrimaryButton(
//             labelText: 'auth.signUpButton'.tr,
//             onPressed: () async {
//               if (_formKey.currentState!.validate()) {
//                 SystemChannels.textInput.invokeMethod(
//                     'TextInput.hide'); //to hide the keyboard - if any
//                 authController.registerWithEmailAndPassword(context);
//               }
//             }),
//         FormVerticalSpace(),
//         LabelButton(
//           labelText: 'Already have an account',
//           onPressed: () => authController.flipEmailCredentialForm(),
//         ),
//       ],
//     );
//   }
//
//   Widget signInForm(context) {
//     return Column(
//       key: Key("signin"),
//       children: [
//         LogoGraphicHeader(),
//         SizedBox(height: 48.0),
//         emailField(),
//         FormVerticalSpace(),
//         passwordField(),
//         FormVerticalSpace(),
//         PrimaryButton(
//             labelText: 'auth.signInButton'.tr,
//             onPressed: () async {
//               if (_formKey.currentState!.validate()) {
//                 authController.signInWithEmailAndPassword(context);
//               }
//             }),
//         FormVerticalSpace(),
//         LabelButton(
//           labelText: 'auth.resetPasswordLabelButton'.tr,
//           onPressed: () => Get.to(ResetPasswordUI()),
//         ),
//         LabelButton(
//           labelText: 'Create an account',
//           onPressed: () => authController.flipEmailCredentialForm(),
//         ),
//       ],
//     );
//   }
//
//   Widget flipFormSwitcher(context, value) {
//     return AnimatedSwitcher(
//       child: value == 'signin'
//           ? signInForm(context)
//           : signUpForm(context),
//       duration: Duration(milliseconds: 300),
//       // layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
//       //   return currentChild!;
//       // },
//       transitionBuilder: (Widget child, Animation<double> animation)  {
//         final inAnimation =
//         Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
//             .animate(animation);
//         final outAnimation =
//         Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset(0.0, 0.0))
//             .animate(animation);
//
//         if (child.key == Key(value)) {
//           return ClipRect(
//             child: SlideTransition(
//               position: inAnimation,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: child,
//               ),
//             ),
//           );
//         } else {
//           return ClipRect(
//             child: SlideTransition(
//               position: outAnimation,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: child,
//               ),
//             ),
//           );
//         }
//       },
//     );
//   }
//
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       body: Form(
//         key: _formKey,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0),
//           child: Center(
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: <Widget>[
//                   Obx(() => flipFormSwitcher(context, authController.emailAuthIntentTag.value)),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     ));
//   }
// }
