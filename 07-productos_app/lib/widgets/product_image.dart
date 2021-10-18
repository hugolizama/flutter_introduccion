import 'dart:io';

import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {

  final String? url;

  const ProductImage({Key? key, this.url}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 10, ),
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25)
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: Offset(0, 5)
            ),
          ]
        ),

        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25)
          ),
          child: getImage( url ),
        ),
      ),
    );
  }


  Widget getImage( String? picture ){

    if(picture == null ){
      return Image(
        image: AssetImage('assets/img/no-image.png'),
        fit: BoxFit.cover,
      );
    } else if( picture.startsWith('http') ){
       return FadeInImage(
          fit: BoxFit.cover,
          placeholder: AssetImage('assets/img/jar-loading.gif'), 
          image: NetworkImage( this.url! )
        );
    } else {
      return Image.file(
        File( picture ),
        fit: BoxFit.cover,
      );
    }
     
  }
}