
import 'package:flutter/material.dart';
import 'dart:async';

class ListaPage extends StatefulWidget {
  @override
  _ListaPageState createState() => _ListaPageState();
}

class _ListaPageState extends State<ListaPage> {

  List<int> _listaNumeros = [];
  int _ultimoNumero = 0;
  ScrollController _scrollController = new ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _agregar10();

    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        // _agregar10();
        fetchData();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listas'),
      ),
      body: Stack(
        children: [
          _crearLista(),
          _crearLoading(),
        ],
      )

    );
  }


  Widget _crearLista(){
    return RefreshIndicator(
      child: ListView.builder(
        controller: _scrollController,
        itemCount: _listaNumeros.length,
        itemBuilder: (BuildContext contect, int index) {

          final imagen = _listaNumeros[index];

          return FadeInImage(
            placeholder: AssetImage('assets/img/jar-loading.gif'), 
            image: NetworkImage('https://picsum.photos/id/$imagen/500/300')
          );
        }
      ),
      onRefresh: obtenerPagina1,
    );
  }

  Future<Null> obtenerPagina1() async{
    final duration = new Duration(seconds: 2);
    new Timer(duration, (){
      _listaNumeros.clear();
      _ultimoNumero++;
      _agregar10();
    });

    return Future.delayed(duration);
  }


  void _agregar10(){
    for (var i = 1; i < 10; i++) {
      _ultimoNumero++;
      _listaNumeros.add(_ultimoNumero);
    }

    setState(() {
      
    });
  }

  Future fetchData() async {
    _isLoading = true;
    setState(() {
      
    });

    final duration = new Duration(seconds: 2);
    return new Timer(
      duration, 
      respuestaHTTP
    );
  }

  void respuestaHTTP(){
    _isLoading = false;
    _agregar10();
    _scrollController.animateTo(
      _scrollController.position.pixels + 100, 
      duration: Duration(seconds: 1), 
      curve: Curves.fastOutSlowIn
    );
  }

  Widget _crearLoading() {
    if( _isLoading ){
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,        
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
            ],
          ),
          SizedBox(height: 10,),
        ],
      );

    } else {
      return Container();
    }
  }
}