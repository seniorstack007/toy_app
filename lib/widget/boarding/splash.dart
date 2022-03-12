import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff283488),
        body: Image.asset(
          'assets/img/splash/1.png',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ));
  }
}
