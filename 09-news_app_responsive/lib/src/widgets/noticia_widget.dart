import 'package:flutter/material.dart';
import 'package:news_app/src/models/models.dart';
import 'package:news_app/src/theme/tema.dart';



class NoticiaWidget extends StatelessWidget {
  final Article noticia;
  final int index;

  const NoticiaWidget({Key? key, required this.noticia, required this.index}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // _TarjetaTopBar
        Container(          
          margin: EdgeInsets.only( right: 10, left: 10, bottom: 5 ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only( right: 5),
                child: Text('${ index + 1 }', style: TextStyle(color: miTema.accentColor),),
              ),
              Text('${ noticia.source.name }'),
            ],
          ),
        ),


        // _TarjetaTitulo
        Container(
          margin: EdgeInsets.only( right: 15, left: 15, bottom: 5 ),
          child: Text( noticia.title, style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold,
          ), textAlign: TextAlign.justify,),
        ),


        //_TarjetaImagen
        Container(
          margin: EdgeInsets.only(left: 15, right: 15, bottom: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50), 
              bottomRight: Radius.circular(50)
            ),
            child: (noticia.urlToImage != null) 
              ? FadeInImage(
                placeholder: AssetImage('assets/img/giphy.gif'), 
                image: NetworkImage( noticia.urlToImage! )
              )
              : Image(image: AssetImage('assets/img/no-image.png')),
          ),
        ),



        //_TarjetaBody
        Container(
          margin: EdgeInsets.only(left: 15, right: 15, bottom: 10),
          child: Text( 
            noticia.description != null ? noticia.description! : '' ,
            textAlign: TextAlign.justify,
          ),
        ),


        //_TarjetaBotones
        Container(
          margin: EdgeInsets.only(left: 15, right: 15, bottom: 10),
          child: RawMaterialButton(                
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon( Icons.article ),
                Text('Leer más...'),
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            ),
            fillColor: miTema.accentColor,
            onPressed: (){},
          ),                      
        ),



        Container(
          margin: EdgeInsets.only(left: 15, right: 15, bottom: 20),
          child: Divider(color: Colors.grey,)
        ),
        
      ],
    );
  }
}