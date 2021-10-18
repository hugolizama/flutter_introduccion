import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';

class ProductFormProvider extends ChangeNotifier{
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  Product product;

  ProductFormProvider( this.product );

  updateAvailabilty( bool value ){
    this.product.available = value;
    notifyListeners();
  }

  bool isValidForm(){
    
    return formKey.currentState?.validate() ?? false;
  }
}