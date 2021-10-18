import 'package:flutter/material.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:provider/provider.dart';

import '../services/services.dart';
import '../widgets/widgets.dart';
import '../models/models.dart';

class HomeScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final productsService = Provider.of<ProductsService>(context);
    final authService = Provider.of<AuthService>(context, listen: false);

    if(productsService.isLoading == true) return LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
        actions: [
          IconButton(
            icon: Icon( Icons.logout_outlined ),
            onPressed: () {
              authService.logout(context);
            }, 
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: productsService.products.length,
        itemBuilder: (BuildContext context, int index){
          return GestureDetector(
            child: ProductCard( product: productsService.products[index], ),
            onTap: () {
              productsService.selectedProduct = productsService.products[index].copy();
              Navigator.pushNamed(context, 'product');
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          productsService.selectedProduct = new Product(
            available: false, 
            name: '', 
            price: 0
          );
          Navigator.pushNamed(context, 'product');
        },
      ),
    );
  }
}