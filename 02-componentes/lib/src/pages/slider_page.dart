import 'package:flutter/material.dart';

class SliderPage extends StatefulWidget {
  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {

  double _valorSlider = 100;
  bool _bloquearCheck = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Slider'),
      ),
      body: Container(
        child: Column(
          children: [
            _crearSlider(),
            _crearCheckBox(),
            _crearSwitch(),
            Expanded(child: _crearImagen()),
          ],
        )
      ),
    );
  }

  Widget _crearSlider() {
    return Slider(
      activeColor: Colors.indigoAccent,
      label: 'Tamaño de la imagen',
      //divisions: 20,
      value: _valorSlider, 
      min: 10,
      max: 400,
      onChanged: ( _bloquearCheck ) ? null : ( valor ) {
        setState(() {
          _valorSlider = valor;
        });
      }
    );
  }

  Widget _crearImagen() {
    return Image(
      image: NetworkImage('https://i.pinimg.com/736x/56/0d/5f/560d5fef78acc6eec0e3c21b8c4b3e4f.jpg'),
      width: _valorSlider,
      fit: BoxFit.contain,
    );
  }

  Widget _crearCheckBox() {
    /*return Checkbox(
      value: _bloquearCheck, 
      onChanged: ( valor ){
        setState(() {
          _bloquearCheck = valor as bool;
        });
      }
    );*/



    return CheckboxListTile(
      title: Text('Bloquear slilder'),
      value: _bloquearCheck, 
      onChanged: ( valor ){
        setState(() {
          _bloquearCheck = valor as bool;
        });
      }
    );
  }

  Widget _crearSwitch() {
    return SwitchListTile(
      title: Text('Bloquear slilder'),
      value: _bloquearCheck, 
      onChanged: ( valor ){
        setState(() {
          _bloquearCheck = valor as bool;
        });
      }
    );
  }
}