import 'package:flutter/material.dart';

class ForgetBackground extends StatelessWidget {

  // final Widget child;
  //
  // ForgetBackground({required this.child});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange, Colors.white],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0, 1],
          tileMode: TileMode.clamp,
        ),
      ),
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset('assets/images/main_top.png',
              color: Colors.greenAccent.shade400,
              width: size.width*0.3,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset('assets/images/main_bottom.png',
              color: Colors.greenAccent.shade400,
              width: size.width*0.2,
            ),
          ),
          // child,
        ],
      ),
    );
  }
}
