import 'package:flutter/material.dart';
import 'package:news_app/src/services/services.dart';
import 'package:news_app/src/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid/responsive_grid.dart';

class Tab3Page extends StatefulWidget {
  @override
  _Tab3PageState createState() => _Tab3PageState();
}

class _Tab3PageState extends State<Tab3Page> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);


    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            ResponsiveGridRow(
            children: [
              for (var i = 0; i < newsService.headLines.length; i++)           
                ResponsiveGridCol(
                  md: 6,       
                  sm: 6,     
                  child: NoticiaWidget(noticia: newsService.headLines[i], index: i),
                ),      
            ],
          ),
          ],
        ),
      )
            
    );

  }

  // funcion para mantener las noticias en la misma posicion donde estaba
  // aunque se navegue a una pagina distinta y regresemos. Hugo Lizama
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}