import 'package:flutter/material.dart';

class InputPage extends StatefulWidget {

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {

  String _nombre = '';
  String _email = '';
  String _password = '';
  String _fecha = '';
  List<String> _poderes = ['Volar', 'Rayos x', 'Super velocidad', 'Super fuerza'];
  String _opcionSeleccionada = 'Volar';


  TextEditingController _inputFieldDateController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text('Inputs de texto'),
       ),
       body: ListView(
         padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
         children: [
           _crearInput(),
           Divider(),
           _crearEmail(),
           Divider(),
           _crearPersona(),
           Divider(),
           _crearPassword(),
           Divider(),
           _crearFecha( context ),
           Divider(),
           _crearDropdown( ),

         ],
       ),
    );
  }

  Widget _crearInput() {
    return TextField(
      autofocus: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        counter: Text('Letras ${ _nombre.length }'),
        hintText: 'Nombre de la persona',
        labelText: 'Nombre',
        helperText: 'Solo es el nombre',
        suffixIcon: Icon(Icons.help),
        icon: Icon(Icons.account_circle),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        )
      ),
      onChanged: ( valor ){
        setState(() {
          _nombre = valor;          
        });
      },
    );
  }

  Widget _crearPersona() {
    return ListTile(
      title: Text('Nombre es: $_nombre'),
      subtitle: Text('El email es: $_email'),
      trailing: Text(_opcionSeleccionada),
    );
  }

  Widget _crearEmail() {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Email',
        labelText: 'Email',
        helperText: 'Solo correo electrónico',
        suffixIcon: Icon(Icons.alternate_email),
        icon: Icon(Icons.email),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        )
      ),
      onChanged: ( valor ){
        setState(() {
          _email = valor;          
        });
      },
    ); 
  }

  Widget _crearPassword() {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        labelText: 'Password',
        suffixIcon: Icon(Icons.password),
        icon: Icon(Icons.vpn_key),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        )
      ),
      onChanged: ( valor ){
        setState(() {
          _password = valor;          
        });
      },
    ); 
  }

  Widget _crearFecha( BuildContext context) {
    return TextField(
      controller: _inputFieldDateController,
      enableInteractiveSelection: false,
      decoration: InputDecoration(
        hintText: 'Fecha de nacimiento',
        labelText: 'Fecha de nacimiento',
        suffixIcon: Icon(Icons.date_range),
        icon: Icon(Icons.calendar_today),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        )
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context);
      },
    ); 
  }

  _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context, 
      initialDate: new DateTime.now(), 
      firstDate: new DateTime(2018), 
      lastDate: new DateTime(2025),
      locale: Locale('es', '')
    );

    if( picked != null){
      setState(() {
        _fecha = picked.toString();
        _inputFieldDateController.text = _fecha;
      });
    }
  }


  List<DropdownMenuItem<String>> getOpcionesDropDown() {
    List<DropdownMenuItem<String>> lista = [];

    _poderes.forEach((poder) {
      lista.add(DropdownMenuItem(
        child: Text(poder),
        value: poder,
      ));     
    });

    return lista;
  }
  Widget _crearDropdown() {
    return Row(      
      children: [
        Icon(Icons.select_all),
        SizedBox(width: 30.0,),
        Expanded(
          child: DropdownButton(
            value: _opcionSeleccionada,
            items: getOpcionesDropDown(),
            onChanged: ( opt ) {
              setState(() {
                _opcionSeleccionada = opt.toString();
              });
            },
          ),
        )
      ],
    );
    
    
    
    
  }


















}