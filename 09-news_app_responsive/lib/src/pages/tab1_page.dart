import 'package:flutter/material.dart';
import 'package:news_app/src/services/services.dart';
import 'package:news_app/src/theme/tema.dart';
import 'package:news_app/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

class Tab1Page extends StatefulWidget {
  @override
  _Tab1PageState createState() => _Tab1PageState();
}

// AutomaticKeepAliveClientMixin necesario para manterner el estado de las noticias
// y envitar que vueva al inicio la lista de noticias al navegar a otra pagina
// y regresemos. Hugo Lizama
class _Tab1PageState extends State<Tab1Page> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);

    return Scaffold(
      body: ( newsService.headLines.length == 0) 
        ? Center(child: Container(
              height: 80,
              width: 80,
              child: CircularProgressIndicator(
                color: miTema.accentColor,
                strokeWidth: 8,               
              )
            ),
          )
        : SafeArea(child: ListaNoticiasWidget( newsService.headLines )),
    );
  }


  // funcion para mantener las noticias en la misma posicion donde estaba
  // aunque se navegue a una pagina distinta y regresemos. Hugo Lizama
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}