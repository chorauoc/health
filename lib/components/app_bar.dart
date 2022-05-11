import 'package:flutter/material.dart';
import 'package:healthapp/screens/profile.dart';
import 'package:healthapp/util/colors.dart';

class HealthAppBar extends StatelessWidget {
  final bool isBack;
  final bool isTransperent;
  final String title;
  const HealthAppBar({
    Key? key,
    this.isBack = false,
    this.isTransperent = false,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
      color: isTransperent ? Colors.transparent : null,
      shadowColor: isTransperent ? Colors.transparent : null,
      elevation: 1,
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: isTransperent ? Colors.transparent : null,
          border: isTransperent
              ? null
              : const Border(
                  bottom: BorderSide(color: kBlue),
                ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                isBack
                    ? Navigator.pop(context)
                    : Scaffold.of(context).openDrawer();
              },
              child: Icon(
                isBack ? Icons.arrow_back : Icons.menu,
                color: isTransperent ? Colors.white : kBlue,
              ),
            ),
            isTransperent
                ? Container()
                : Text(
                    title,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
            isTransperent
                ? Container()
                : isBack
                    ? Container()
                    : InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfileScreen()));
                        },
                        child: const Icon(
                          Icons.settings,
                          color: kBlue,
                        ),
                      )
          ],
        ),
      ),
    );
  }
}
