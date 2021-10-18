import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {

  final Widget child;

  const CardContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: 300,
      margin: EdgeInsets.symmetric( horizontal: 40, ),
      padding: EdgeInsets.all( 20 ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular( 25 ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 15,
            offset: Offset(0, 5)
          )
        ]
      ),
      child: this.child,
    );
  }
}