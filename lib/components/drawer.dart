import 'package:flutter/material.dart';
import 'package:healthapp/components/background.dart';
import 'package:healthapp/components/button.dart';
import 'package:healthapp/components/spacer.dart';
import 'package:healthapp/screens/goals.dart';
import 'package:healthapp/screens/predicts.dart';
import 'package:healthapp/screens/qll.dart';
import 'package:healthapp/screens/workouts.dart';
import 'package:healthapp/util/colors.dart';

import '../main.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';
import '../screens/login.dart';

class HealthDrawer extends StatefulWidget {
  const HealthDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<HealthDrawer> createState() => _HealthDrawerState();
}

class _HealthDrawerState extends State<HealthDrawer> {
  User? user;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    user = locator<UserProvider>().getSession();
    nameController.text = user?.name ?? '';
    emailController.text = user?.email ?? '';
    return Drawer(
      child: Background(
        isAppBar: true,
        alignment: Alignment.topCenter,
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(nameController.text),
              accountEmail: Text(emailController.text),
              currentAccountPicture: CircleAvatar(
                backgroundColor:
                    Theme.of(context).platform == TargetPlatform.iOS
                        ? Colors.blue
                        : Colors.white,
                child: Text(
                  nameController.text.length > 2
                      ? nameController.text.substring(0, 2).toUpperCase()
                      : nameController.text.toUpperCase(),
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),

            DrawerItem(
              title: 'Goals',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GoalsScreen()));
              },
            ),
            DrawerItem(
              title: 'Improve QOL',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => QLLScreen()));
              },
            ),
            DrawerItem(
              title: 'Workout Plans',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WorkOutPlanScreen()));
              },
            ),
            DrawerItem(
              title: 'Health Predicts',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PredictsScreen()));
              },
            ),
            HealthSpacer(
              height: 0.08,
            ),
            HealthButton(
              text: 'Sign Out',
              alignment: Alignment.center,
              onPressed: () {
                locator<UserProvider>().reset();
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  const DrawerItem({
    Key? key,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.w500, fontSize: 16.0, color: kBlue),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_outlined,
          size: 10,
          color: kBlue,
        ),
      ),
    );
  }
}
