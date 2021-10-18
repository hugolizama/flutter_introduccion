import 'package:flutter/material.dart';
import 'package:news_app/src/pages/pages.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new _NavegacionModel(),
      child: Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget { 
  @override
  Widget build(BuildContext context) {

    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return BottomNavigationBar(
      currentIndex: navegacionModel.paginaActual,
      items: [
        BottomNavigationBarItem(
          icon: Icon( Icons.person_outline ),
          label: 'Para ti',
        ),


        BottomNavigationBarItem(
          icon: Icon( Icons.public ),
          label: 'Encabezados',
        ),

        BottomNavigationBarItem(
          icon: Icon( Icons.view_column ),
          label: 'Responsive',
        ),
      ],

      onTap: (int i){
        navegacionModel.paginaActual = i;
      },
    );
  }
}

class _Paginas extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return PageView(
      controller: navegacionModel.pageController,
      // physics: BouncingScrollPhysics(),
      physics: NeverScrollableScrollPhysics(),
      children: [
        Tab1Page(),

        Tab2Page(),

        Tab3Page(),
      ],
    );
  }
}



class _NavegacionModel with ChangeNotifier{
  int _paginaActual = 0;
  PageController _pageController = new PageController();

  int get paginaActual => this._paginaActual;

  set paginaActual(int pag){

    //establece la pagina en el menu
    this._paginaActual = pag;

    // establece la pagina que se muestra dentreo del PageView
    this._pageController.animateToPage(pag, 
      duration: Duration(milliseconds: 250), 
      curve: Curves.easeOut
    );

    notifyListeners();
  }

  PageController get pageController => this._pageController;
}