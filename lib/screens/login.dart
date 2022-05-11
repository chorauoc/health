import 'package:flutter/material.dart';
import 'package:healthapp/components/background.dart';
import 'package:healthapp/components/button.dart';
import 'package:healthapp/components/heading.dart';
import 'package:healthapp/components/link_button.dart';
import 'package:healthapp/components/spacer.dart';
import 'package:healthapp/components/text_form_feild.dart';
import 'package:healthapp/screens/dashboard.dart';
import 'package:healthapp/screens/register.dart';
import 'package:permission_handler/permission_handler.dart';

import '../main.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';
import '../util/dialog.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    //_requestPermissions();
    super.initState();
  }

  void _requestPermissions() async {
    final status = await Permission.activityRecognition.request();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: const HealthHeading(
                text: 'LOGIN',
              ),
            ),
            const HealthSpacer(height: 0.03),
            Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  HealthTextFormFeild(
                    controller:usernameController,
                    text: 'Username',
                  ),
                  const HealthSpacer(height: 0.03),
                  HealthTextFormFeild(
                    controller:passwordController,
                    text: 'Password',
                    obscureText: true,
                  ),
                  const HealthSpacer(height: 0.05),
                  HealthButton(
                    text: 'LOGIN',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        var user = User()
                          ..username = usernameController.text
                          ..password = passwordController.text;
                        UserState result = locator<UserProvider>().check(user);
                        if (result == UserState.notExsist) {
                          HealthDialog.showDialog(
                            context: context,
                            title: 'Login',
                            desc:
                            'Login was unsuccessful, user not registered, please register to proceed',
                            onAction: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterScreen()));
                            },
                          );
                        } else if (result == UserState.incorrectUserCredentials) {
                          HealthDialog.showDialog(
                            context: context,
                            title: 'Login',
                            desc:
                            'Login was unsuccessful, incorrect user credentials',
                          );
                        } else {
                          if (result == UserState.completed) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DashboardScreen()));
                          }
                        }
                      }

                    },
                  ),
                  HealthLinkButton(
                    text: 'Don\'t Have an Account? Sign up',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterScreen()));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
