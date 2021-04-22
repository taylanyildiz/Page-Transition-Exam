import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final String title;
  const HomeScreen({
    Key key,
    @required this.title,
  }) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

TweenAnimationBuilder _tweenAnimation(Widget child) => TweenAnimationBuilder(
      child: child,
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(seconds: 1),
      builder: (context, value, child) {
        return ShaderMask(
          shaderCallback: (rect) => RadialGradient(
            radius: (value as double) * 2.0,
            colors: [
              Colors.white,
              Colors.white,
              Colors.transparent,
              Colors.transparent,
            ],
            stops: [0.0, 1.0, 0.0, 0.0],
            center: FractionalOffset(0.9, 0.9),
          ).createShader(rect),
          child: child,
        );
      },
    );

Widget _slideTransition(Animation animation, Widget child) => SlideTransition(
      position: animation.drive(
        Tween(
          begin: Offset(1.0, 0.0),
          end: Offset.zero,
        ).chain(
          CurveTween(
            curve: Curves.elasticOut,
          ),
        ),
      ),
      child: child,
    );

Widget _customTransition(Animation animation, Widget child) {
  var scaleAnim = animation.drive(
      Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: Curves.easeInCirc)));
  var angleAnim = animation.drive(
      Tween(begin: 0.0, end: pi).chain(CurveTween(curve: Curves.easeInCirc)));
  return AnimatedBuilder(
    animation: animation,
    builder: (context, child) {
      return Transform.rotate(
        angle: angleAnim.value,
        child: child,
      );
    },
    child: Transform.scale(
      scale: scaleAnim.value,
      child: child,
    ),
  );
}

Route _createRoute(index) => PageRouteBuilder(
      transitionDuration: Duration(seconds: 2),
      pageBuilder: (context, animation, secondaryAnimation) => Scaffold(
        body: Stack(
          children: [
            Container(
              color: Colors.blue,
              child: Center(
                child: Text(
                  'Page 2',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        switch (index) {
          case 1:
            return _tweenAnimation(child);
            break;
          case 2:
            return _slideTransition(animation, child);
            break;
          case 3:
            return _customTransition(animation, child);
            break;
        }
        return null;
      },
    );

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  nextPageClick() => {
        index++,
        if (index > 3) index = 1,
        Navigator.push(context, _createRoute(index))
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.red,
            child: Center(
              child: Text(
                'Page 1',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => nextPageClick(),
        child: Icon(
          Icons.arrow_forward_ios,
          color: Colors.white,
        ),
      ),
    );
  }
}
