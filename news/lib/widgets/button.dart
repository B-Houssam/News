import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
        opacity: 1,
        child: Container(
          width: 50,
          height: 50,
          child: FloatingActionButton(
            tooltip: 'Next Step',
            onPressed: () {},
            elevation: 0,
            backgroundColor: Color(0XFFFFC15E),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.arrow_forward),
          ),
        ));
  }
}
