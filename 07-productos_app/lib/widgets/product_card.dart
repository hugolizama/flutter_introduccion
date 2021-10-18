import 'package:flutter/material.dart';
import '../models/models.dart';

class ProductCard extends StatelessWidget {

  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only( top: 30, right: 20, bottom: 20, left: 20),
      width: double.infinity,
      height: 400,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [

          // tarjeta de contenido
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Container(
              width: double.infinity,
              height: 400,
              child: (this.product.picture == null) ? Image(
                image: AssetImage('assets/img/no-image.png'),
                fit: BoxFit.cover,
              ) : FadeInImage(
                placeholder: AssetImage('assets/img/jar-loading.gif'), 
                image:  NetworkImage( this.product.picture! ),
                fit: BoxFit.cover,
              ),
            ),
          ),


          //detalles del producto
          Padding(
            padding: const EdgeInsets.only( right: 50 ),
            child: Container(
              padding: EdgeInsets.symmetric( horizontal: 20, vertical: 10 ),
              width: double.infinity,
              height: 70,              
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // nombre del producto
                  Text( this.product.name, 
                    style: TextStyle(
                      fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  // id del producto
                  Text( this.product.id.toString(),  
                    style: TextStyle(
                      fontSize: 14, color: Colors.white, 
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),



          // etiqueta del precio
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric( horizontal: 20, vertical: 10 ),
              child: FittedBox( // ayuda a modificar el contenido para que se adapte al espacio
                fit: BoxFit.contain,
                child: Text('\$ ${ this.product.price.toStringAsFixed(2) }', style: TextStyle(
                  color: Colors.white, fontSize: 18
                ),),
              ),
              width: 150,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25)
                ),
              ),
            ),
          ),




          // etiqueta para mostrar cuando el producto no esta disponible
          if(this.product.available == false)
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric( horizontal: 20, vertical: 10 ),
                child: FittedBox( // ayuda a modificar el contenido para que se adapte al espacio
                  fit: BoxFit.contain,
                  child: Text('No disponible', style: TextStyle(
                    color: Colors.white, fontSize: 18
                  ),),
                ),
                width: 150,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.red[600],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25)
                  ),
                ),
              ),
            ),

        ],
      ),

      //decoracion
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 7)
          ),
        ]
      ),
    );
  }
}