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

Route _createRoute() => PageRouteBuilder(
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
        return SlideTransition(
          position: animation.drive(
            Tween(
              begin: Offset(0, 1.0),
              end: Offset.zero,
            ).chain(
              CurveTween(
                curve: Curves.elasticOut,
              ),
            ),
          ),
          child: child,
        );
      },
    );

class _HomeScreenState extends State<HomeScreen> {
  nextPageClick() => Navigator.push(context, _createRoute());

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
