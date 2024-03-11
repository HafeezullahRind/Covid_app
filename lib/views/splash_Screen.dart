import 'dart:async';
import 'dart:math' as math;

import 'package:covid_app/views/world_stats.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(seconds: 3))
        ..repeat();
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 5),
        () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const worldstatsScreen(),
            )));
    print('Init function is called');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  var devheight;
  @override
  Widget build(BuildContext context) {
    devheight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              child: Center(
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/virus.png'))),
                ),
              ),
              builder: (context, child) {
                return Transform.rotate(
                    angle: _controller.value * 2.0 * math.pi, child: child);
              },
            ),
            SizedBox(
              height: devheight * 0.08,
            ),
            const Text(
              'Covid-19\nTracker App',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
