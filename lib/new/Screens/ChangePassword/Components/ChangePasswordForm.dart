import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Bloc/User/user_bloc.dart';
import 'package:shakosh/new/Config/Utils/SizeConfig.dart';
import 'package:shakosh/new/Config/Utils/Validator.dart';
import 'package:shakosh/new/components/default_button.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';

// ignore: must_be_immutable
class ChangePasswordForm extends StatefulWidget {
  ChangePasswordForm({super.key});

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  late GlobalKey<FormState> formstate;
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  @override
  void initState() {
    formstate = GlobalKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formstate,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: screenWidth > 768
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                Text(
                  screenWidth > 768
                      ? "password-change".tr
                      : "change-password-your-old-password-with-your-new-password"
                          .tr,
                  style: TextStyle(
                      color: screenWidth > 768 ? null : colors(context).grey1,
                      fontWeight: screenWidth > 768 ? FontWeight.bold : null,
                      fontSize: mySize(16, 16, 22, 22, 22)),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            textField(password, "password".tr, true, Icons.lock, (value) {
              return Validators().validEmpty(value);
            }),
            SizedBox(
              height: 20,
            ),
            textField(confirmPassword, "retype-password".tr, true, Icons.lock,
                (value) {
              return Validators().validConfirmPassword(value, password.text);
            }),
            SizedBox(
              height: 20,
            ),
            SizedBox(
                height: 55,
                child: BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    return DefaultButton(
                      fontsize: 18,
                      text: "save".tr,
                      submit: (state is SubmitLoadingState) ? true : false,
                      press: () {
                        if (state is SubmitLoadingState) {
                        } else {
                          var formdata = formstate.currentState!;
                          if (formdata.validate()) {
                            BlocProvider.of<UserBloc>(context).add(
                                UpdateUserPassword(password: password.text));
                          }
                        }
                      },
                    );
                  },
                ))
          ],
        ));
  }

  TextFormField textField(controller, text, secure, icon, validation) {
    return TextFormField(
      controller: controller,
      obscureText: secure,
      validator: (value) {
        return validation(value);
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(prefixIcon: Icon(icon), label: Text(text)),
    );
  }
}