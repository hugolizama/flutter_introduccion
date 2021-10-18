import 'package:flutter/material.dart';
import '../widgets/menu_widget.dart';
import '../shared_prefs/preferencias_usuario.dart';

class SettingsPage extends StatefulWidget {

  static final String routeName = 'settings';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  late bool _colorSecundario;
  late int _genero;
  late String _nombreUsuario;

  late TextEditingController _textController;

  final _prefs = new PreferenciasUsuario();

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    _genero = _prefs.genero;
    _colorSecundario = _prefs.colorSecundario;
    _nombreUsuario = _prefs.nombreUsuario;
    _prefs.ultimaPagina = SettingsPage.routeName;

    _textController = new TextEditingController( text: _nombreUsuario );
  }

  _setSelectedRadio(int? valor){
    setState(() {
      _genero = valor ?? 1;  
      _prefs.genero = _genero ;  
    });
  }

  _setColorSecundario(bool? valor){
    setState(() {
      _colorSecundario = valor ?? false;  
      _prefs.colorSecundario = _colorSecundario;  
    });
  }

  _setNombreUsuario(String? valor){
    setState(() {
      _nombreUsuario = valor ?? '';  
      _prefs.nombreUsuario = _nombreUsuario;  
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajustes de usuario'),
        backgroundColor: _prefs.getColor(),
      ),

      drawer: MenuWidget(),
      
      body: Center(
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.all(5),
              child: Text('Settings', style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),),
            ),

            Divider(),

            SwitchListTile(
              value: this._colorSecundario, 
              title: Text('Valor secundario'),
              onChanged: _setColorSecundario
            ),

            RadioListTile(
              value: 1, 
              title: Text('Masculino'),
              groupValue: _genero, 
              onChanged: _setSelectedRadio
            ),

            RadioListTile(
              value: 2, 
              title: Text('Femenino'),
              groupValue: _genero, 
              onChanged: _setSelectedRadio
            ),

            Divider(),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  helperText: 'Ingrese su nombre'
                ),
                onChanged: _setNombreUsuario,
              ),
            ),
          ],
        ),
      ),
    );
  }

 
}