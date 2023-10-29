import 'dart:async';

import 'package:doggy/components/navigate.dart';
import 'package:doggy/view_model/home/home_view_model.dart';
import 'package:doggy/views/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  startTimeout() {
    return Timer(const Duration(seconds: 3), handleTimeout);
  }

  void handleTimeout() {
    changeScreen();
  }

  changeScreen() async {
    Navigate.pushPageReplacement(
      context,
      const Home(),
    );
  }

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      initApp();
    });
    super.initState();
  }

  initApp() async {
    await Provider.of<HomeViewModel>(context, listen: false).getDogBreeds();
    await Provider.of<HomeViewModel>(context, listen: false)
        .getDogBreedAndSubBreed();

    startTimeout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/splash.png",
              height: 300.0,
              width: 300.0,
            ),
          ],
        ),
      ),
    );
  }
}
