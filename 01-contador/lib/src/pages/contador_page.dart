import 'package:flutter/material.dart';

class ContadorPage extends StatefulWidget {
  @override
  createState() {
    return _ContagorPageState();
  }
}

class _ContagorPageState extends State<ContadorPage> {
  final TextStyle _estiloTexto = TextStyle(fontSize: 25);
  int _conteo = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Titulo'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Número de clics:',
              style: _estiloTexto,
            ),
            Text(
              '$_conteo',
              style: _estiloTexto,
            )
          ],
        ),
      ),
      floatingActionButton: _crearBotones(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _crearBotones() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: 30.0,
        ),
        FloatingActionButton(
          child: Icon(Icons.exposure_zero),
          onPressed: _reset,
        ),
        Expanded(child: SizedBox()),
        FloatingActionButton(
          child: Icon(Icons.remove),
          onPressed: _sustraer,
        ),
        Expanded(child: SizedBox()),
        FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: _agregar,
        ),
        SizedBox(
          width: 30.0,
        ),
      ],
    );
  }

  void _agregar() {
    _conteo++;
    setState(() {});
  }

  void _sustraer() {
    _conteo--;
    setState(() {});
  }

  void _reset() {
    _conteo = 0;
    setState(() {
      
    });
  }
}
