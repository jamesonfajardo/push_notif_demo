import 'package:flutter/material.dart';

class BlueGrey extends StatefulWidget {
  @override
  _BlueGreyState createState() => _BlueGreyState();
}

class _BlueGreyState extends State<BlueGrey> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blueGrey[700],
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
