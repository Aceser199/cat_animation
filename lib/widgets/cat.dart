import 'package:flutter/material.dart';

class Cat extends StatelessWidget {
  const Cat({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/cat.png',
      // width: 200,
      // height: 200,
    );
  }
}
