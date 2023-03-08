import 'dart:math';

import 'package:animation/widgets/box.dart';
import 'package:animation/widgets/cat.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late Animation<double> catAnimation;
  late AnimationController catController;

  late Animation<double> boxAnimation;
  late AnimationController boxController;

  @override
  void initState() {
    super.initState();

    catController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    catAnimation = Tween(begin: -35.0, end: -80.0).animate(
      CurvedAnimation(
        parent: catController,
        curve: Curves.linear,
      ),
    );

    boxController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    boxAnimation = Tween(begin: pi * 0.6, end: pi * 0.65).animate(
      CurvedAnimation(
        parent: boxController,
        curve: Curves.easeInOut,
      ),
    );

    boxAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        boxController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        boxController.forward();
      }
    });
    boxController.forward();

    catAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        boxController.stop();
      } else if (status == AnimationStatus.dismissed) {
        boxController.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: GestureDetector(
        onTap: moveCat,
        child: Center(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              buildCatAnimation(),
              buildBox(),
              buildLeftFlap(),
              buildRightFlap(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCatAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, Widget? child) {
        return Positioned(
          top: catAnimation.value,
          right: 0,
          left: 0,
          child: child ?? Container(),
        );
      },
      child: const Cat(),
    );
  }

  Widget buildBox() {
    return const Box();
  }

  Widget buildLeftFlap() {
    return Positioned(
      left: 3,
      top: 2,
      child: AnimatedBuilder(
        animation: boxAnimation,
        builder: (context, Widget? child) {
          return Transform.rotate(
            angle: boxAnimation.value,
            alignment: Alignment.topLeft,
            child: child ?? Container(),
          );
        },
        child: Container(
          height: 10,
          width: 125,
          color: Colors.brown,
        ),
      ),
    );
  }

  Widget buildRightFlap() {
    return Positioned(
      right: 3,
      top: 2,
      child: AnimatedBuilder(
        animation: boxAnimation,
        builder: (context, Widget? child) {
          return Transform.rotate(
            angle: boxAnimation.value * -1,
            alignment: Alignment.topRight,
            child: child ?? Container(),
          );
        },
        child: Container(
          height: 10,
          width: 125,
          color: Colors.brown,
        ),
      ),
    );
  }

  void moveCat() {
    if (catController.status == AnimationStatus.completed) {
      catController.reverse();
    } else if (catController.status == AnimationStatus.dismissed) {
      catController.forward();
    }
  }
}
