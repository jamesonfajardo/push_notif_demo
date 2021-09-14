import 'package:flutter/material.dart';

class Pink extends StatefulWidget {
  @override
  _PinkState createState() => _PinkState();
}

class _PinkState extends State<Pink> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.pink[100],
        child: Center(
          child: Text(
            'This page is only accessible through push notifications',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
