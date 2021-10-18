import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/login_form_provider.dart';
import '../services/services.dart';
import '../widgets/widgets.dart';
import '../ui/input_decorations.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox( height:  250 ,),

              CardContainer(
                child: Column(
                  children: [
                    Text('Login', style: Theme.of(context).textTheme.headline4,),

                    ChangeNotifierProvider(
                      create: ( _ ) => LoginFormProvider(),
                      child: _LoginForm(),
                    ),

                    
                    
                  ],
                ),
              ),
              
              SizedBox( height: 50 ,),

              TextButton(
                child: Text('Crear una nueva cuenta', style: TextStyle(
                  fontSize: 18, color: Colors.black54
                ),),
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                  shape: MaterialStateProperty.all( StadiumBorder() ),
                  
                ),
                onPressed: (){
                  Navigator.pushReplacementNamed(context, 'register');
                }
              ), 
              

              SizedBox( height: 50 ,),

            ],
          ),
        )
      )
    );
  }
}

// formulario de login
class _LoginForm extends StatelessWidget { 

  @override
  Widget build(BuildContext context) {

    final loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
      child: Form(

        // referencia al form key
        key: loginForm.formKey,

        // establecer cuando validar los campos
        autovalidateMode: AutovalidateMode.onUserInteraction,

        child: Column(
          children: [

            // caja de texto de correo
            TextFormField(
              autocorrect: false,
              // autofocus: true,
              keyboardType: TextInputType.emailAddress, //tipo de dato

              // estilo de la caja de texto
              decoration: InputDecorations.authInputDecoration(
                labelText: 'Correo electrónico',
                hintText: 'nombre@correo.com',
                prefixIcon: Icons.alternate_email
              ),
              
              // validacion del correo electronico
              validator: ( value ){
                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
     
                RegExp regExp  = new RegExp(pattern);

                return regExp.hasMatch( value ?? '' ) ? null : 'El valor ingresado no es un correo electrónico';
              },

              onChanged: ( value ) => loginForm.email = value,
            ),

            SizedBox( height: 20 ,),

            // caja de texto de contrasena
            TextFormField(
              autocorrect: false,
              obscureText: true, // ocultar el texto para el password
              keyboardType: TextInputType.text, //tipo de dato

              // estilo de la caja de texto
              decoration: InputDecorations.authInputDecoration(
                labelText: 'Contraseña',
                hintText: '******',
                prefixIcon: Icons.lock
              ),

              // validacion de la contrasena
              validator: ( value ){
                if( value != null && value.length >= 6){
                  return null;
                } else {
                  return 'La contraseña no debe ser menos a 6 caracteres';
                }
              },

              onChanged: ( value ) => loginForm.password = value,
            ),

            SizedBox( height: 20 ,),

            // boton de ingresar
            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric( horizontal: 30, vertical: 20 ),
                child: Text(
                  (loginForm.isLoading) ? 'Espere...' : 'Ingresar', 
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),     

              // verificar si el formulario siendo enviado, con null se deshabilita
              // el boton, sino se devuelve la funcion         
              onPressed: (loginForm.isLoading) ? null : () async {

                final authService = Provider.of<AuthService>(context, listen: false);

                FocusScope.of(context).unfocus(); // ocultar el teclado del telefono

                //validar si el formulario es correcto
                if(!loginForm.isValidForm()) return;

                loginForm.isLoading = true; // cambiar el estado de loading

                // ejecutar accion de login de usuario
                final String? errorMessage = await authService.login(loginForm.email, loginForm.password);

                
                if( errorMessage == null){
                  Navigator.pushReplacementNamed(context, 'home');

                } else {
                  // todo mostrar error en pantalla
                  loginForm.isLoading = false; // cambiar el estado de loading


                  // notificacion con showDialog (implementacion personal)
                  /*showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text('Error'),
                      content: Text( errorMessage ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cerrar'),
                        ),
                      ],
                    ),
                  );*/


                  // notificacion con snackbar (implementacion profe)
                  NotificationsService.showSnackBar( errorMessage );

                }

              },
            ),
          ],
        ),
      ),
    );
  }
}