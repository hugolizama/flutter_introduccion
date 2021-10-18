import 'package:flutter/material.dart';
import 'package:news_app/src/models/models.dart';
import 'package:news_app/src/widgets/noticia_widget.dart';

class ListaNoticiasWidget extends StatelessWidget {

  final List<Article> noticias;
  const ListaNoticiasWidget( this.noticias );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(      
      itemCount: this.noticias.length,
      itemBuilder: (BuildContext context, int index) { 
        return NoticiaWidget(noticia: this.noticias[index], index: index);
      },
      
    );
  }
}
