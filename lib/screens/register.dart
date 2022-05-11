import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:healthapp/components/background.dart';
import 'package:healthapp/components/button.dart';
import 'package:healthapp/components/heading.dart';
import 'package:healthapp/components/link_button.dart';
import 'package:healthapp/components/spacer.dart';
import 'package:healthapp/components/text_form_feild.dart';
import 'package:healthapp/screens/login.dart';

import '../main.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';
import '../util/dialog.dart';

class RegisterScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const HealthSpacer(height: 0.2),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: const HealthHeading(
                text: 'REGISTER',
              ),
            ),
            const HealthSpacer(height: 0.03),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    HealthTextFormFeild(
                      controller: nameController,
                      text: 'Name',
                    ),
                    const HealthSpacer(height: 0.03),
                    HealthTextFormFeild(
                      controller: emailController,
                      text: 'Email',
                    ),
                    const HealthSpacer(height: 0.03),
                    HealthTextFormFeild(
                      controller: usernameController,
                      text: 'Username',
                    ),
                    const HealthSpacer(height: 0.03),
                    HealthTextFormFeild(
                      controller: passwordController,
                      text: 'Password',
                      obscureText: true,
                    ),
                    const HealthSpacer(height: 0.05),
                    HealthButton(
                      text: 'REGISTER',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          var user = User()
                            ..username = usernameController.text
                            ..password = passwordController.text
                            ..name = nameController.text
                            ..email = emailController.text;

                          UserState result = locator<UserProvider>().add(user);
                          if (result == UserState.completed) {
                            HealthDialog.showDialog(
                                context: context,
                                title: 'Registration',
                                desc: 'Registration was successful',
                                dialogType:DialogType.SUCCES,
                                onAction: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()));
                                });
                          } else {
                            HealthDialog.showDialog(
                              context: context,
                              title: 'Registration',
                              desc:
                              'Registration was unsuccessful, user already registered',
                            );
                          }
                        }
                      },
                    ),
                    HealthLinkButton(
                      text: 'Already Have an Account? Sign in',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
