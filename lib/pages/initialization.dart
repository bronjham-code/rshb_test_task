import 'package:flutter/material.dart';

class InitializationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 30,
            width: 30,
            margin: EdgeInsets.all(10),
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),
          Text('Loading data...',
              style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Please wait until the end of the process.'),
        ],
      ),
    ));
  }
}
