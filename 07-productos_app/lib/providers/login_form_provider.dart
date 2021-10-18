import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier{

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String email = '';
  String password = '';

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  set isLoading (bool valor){
    _isLoading = valor;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}