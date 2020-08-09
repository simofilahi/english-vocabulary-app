import 'package:flutter/material.dart';

class _GooglePayment extends StatefulWidget {
  _GooglePayment({Key key}) : super(key: key);

  @override
  __GooglePaymentState createState() => __GooglePaymentState();
}

class __GooglePaymentState extends State<_GooglePayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: RaisedButton(
            onPressed: () {},
            child: Text('click here'),
          ),
        ),
      ),
    );
  }
}
