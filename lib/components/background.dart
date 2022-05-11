import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  final AlignmentGeometry? alignment;
  final bool isAppBar;

  const Background({
    Key? key,
    required this.child,
    this.alignment,
    this.isAppBar = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: alignment ?? Alignment.center,
        children: <Widget>[
          isAppBar
              ? Container()
              : Positioned(
                  top: 0,
                  right: 0,
                  child:
                      Image.asset("assets/images/top1.png", width: size.width),
                ),
          isAppBar
              ? Container()
              : Positioned(
                  top: 0,
                  right: 0,
                  child:
                      Image.asset("assets/images/top2.png", width: size.width),
                ),
          isAppBar
              ? Container()
              : Positioned(
                  top: 0,
                  right: 0,
                  child: Image.asset(
                    "assets/images/logo.png",
                    width: size.width * 0.45,
                  ),
                ),
          isAppBar
              ? Container()
              : Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image.asset("assets/images/bottom1.png",
                      width: size.width),
                ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset("assets/images/bottom2.png", width: size.width),
          ),
          child
        ],
      ),
    );
  }
}
