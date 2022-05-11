import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:healthapp/components/app_bar.dart';
import 'package:healthapp/components/background.dart';
import 'package:healthapp/components/button.dart';
import 'package:healthapp/components/spacer.dart';
import 'package:healthapp/components/text_form_feild.dart';
import 'package:healthapp/util/colors.dart';

import '../main.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';
import '../util/dialog.dart';

class ProfileScreen extends StatelessWidget {
  User? user;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    user = locator<UserProvider>().getSession();
    nameController.text = user?.name ?? '';
    passwordController.text = user?.password ?? '';
    usernameController.text = user?.username ?? '';
    emailController.text = user?.email ?? '';

    return Scaffold(
      body: Background(
        isAppBar: true,
        alignment: Alignment.topCenter,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    ProfileHeader(nameController: nameController, emailController: emailController),
                    const HealthSpacer(height: 0.03),
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
                      enabled: false,
                      controller: usernameController,
                      text: 'Username',
                      obscureText: true,
                    ),
                    const HealthSpacer(height: 0.03),
                    HealthTextFormFeild(
                      controller: passwordController,
                      text: 'Password',
                      obscureText: true,
                    ),
                    const HealthSpacer(height: 0.03),
                    HealthButton(
                      text: 'UPDATE',
                      alignment: Alignment.center,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          var update = User()
                            ..username = user?.username
                            ..password = passwordController.text
                            ..name = nameController.text
                            ..email = emailController.text;

                          UserState result =
                              locator<UserProvider>().update(update);

                          if (result == UserState.completed) {
                            HealthDialog.showDialog(
                              context: context,
                              title: 'Profile',
                              desc: 'Profile update was successful',
                              dialogType: DialogType.SUCCES,
                            );
                          } else {
                            HealthDialog.showDialog(
                              context: context,
                              title: 'Profile',
                              desc: 'Profile update was unsuccessful',
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            const HealthAppBar(
              title: 'Profile',
              isBack: true,
              isTransperent: true,
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    Key? key,
    required this.nameController,
    required this.emailController,
  }) : super(key: key);

  final TextEditingController nameController;
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [kBlue, Colors.blue.shade300],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: const [0.5, 0.9],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.white70,
                minRadius: 60.0,
                child: CircleAvatar(
                  radius: 50.0,
                  child: Text(
                    nameController.text.length > 2
                        ? nameController.text.substring(0, 2).toUpperCase()
                        : nameController.text.toUpperCase(),
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
              ),
            ],
          ),
          const HealthSpacer(height: 0.03),
          Text(
            nameController.text,
            style: TextStyle(color: Colors.white),
          ),
          const HealthSpacer(height: 0.01),
          Text(
            emailController.text,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
