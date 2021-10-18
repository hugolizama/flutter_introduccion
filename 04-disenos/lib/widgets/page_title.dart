import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        margin: EdgeInsets.only( left: 30, right: 30, top: 15 ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Classify transaction', style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),),
            SizedBox( height: 10, ),
            Text('Classify this transaction into a particular category', style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),),
          ],
        ),
      ),
    );
  }
}