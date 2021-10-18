
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/models.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier {

  final String _baseUrl = 'pruebasyejercicios.firebaseio.com';
  final List<Product> products = [];
  bool isLoading = true;
  Product? selectedProduct;
  bool isSaving = false;
  File? newPictureFile;
  final _storage = new FlutterSecureStorage();


  ProductsService(){
    this.loadProducts();
  }
  




  Future<List<Product>> loadProducts() async{

    this.isLoading = true;
    notifyListeners();

    final url = Uri.https( _baseUrl, 'products.json', {
      'auth': await _storage.read(key: 'idToken') ?? ''
    });
    final resp = await http.get(url);

    final Map<String, dynamic> productsMap = json.decode( resp.body );

    productsMap.forEach((key, value) {
      final tempProduct = Product.fromMap( value );
      tempProduct.id = key;

      this.products.add( tempProduct );
    });

    this.isLoading = false;
    notifyListeners();

    return this.products;
  }



  Future saveOrCreateProduct( Product product ) async {
    isSaving = true;
    notifyListeners();


    if( product.id == null ){
      // nuevo registro
      await this.createProduct(product);
    } else {
      // actualizar
      await this.updateProduct(product);
    }




    isSaving = false;
    notifyListeners();
  }



  Future<String> createProduct( Product product ) async {
    final url = Uri.https( _baseUrl, 'products.json', {
      'auth': await _storage.read(key: 'idToken') ?? ''
    });
    final resp = await http.post(url, body: product.toJson());
    final decodedData = json.decode( resp.body );

    product.id = decodedData['name'];
    this.products.add( product );

    return product.id!;
  }



  Future<String> updateProduct ( Product product ) async {
    final url = Uri.https( _baseUrl, 'products/${ product.id }.json', {
      'auth': await _storage.read(key: 'idToken') ?? ''
    });
    final resp = await http.put(url, body: product.toJson());

    
    // actualizar lista de productos
    // mi implementacion
    /*int index = 0;
    this.products.forEach((element) {      
      if( element.id == product.id ){
        this.products[index]= product;
        return;
      }
      index++;
    });*/

    // implementacion del profe
    final index = this.products.indexWhere((element) => (element.id == product.id));
    this.products[index] = product;

    return product.id!;
  }



  void updateSelectedProductImage( String path ){

    this.selectedProduct?.picture = path;
    this.newPictureFile = File.fromUri( Uri(path: path) );
    notifyListeners();

  }


  Future<String?> uploadImage() async{
    if( this.newPictureFile == null ) return null;

    this.isSaving = true;
    notifyListeners();

    final url = Uri.parse( 'https://api.cloudinary.com/v1_1/hug0666/image/upload?upload_preset=flutter-test' );

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath('file', newPictureFile!.path);

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream( streamResponse );

    if( resp.statusCode != 200 && resp.statusCode!= 201 ) {
      // print('Algo salio mal');
      // print( resp.body );
      return null;
    }

    final decodedData = json.decode( resp.body );

    // this.isSaving = false;
    // notifyListeners();

    this.newPictureFile = null; //limpiar la nueva imagen para indicar que ya se guardo
    return decodedData['secure_url'];
  }
}