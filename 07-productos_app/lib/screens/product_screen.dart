import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:productos_app/providers/providers.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/widgets.dart';
import '../ui/input_decorations.dart';
import '../services/services.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductsService>(context);
    
    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider( productService.selectedProduct! ),
      child: _ProductScreenBody(productService: productService),
    );
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ProductsService productService;

  @override
  Widget build(BuildContext context) {

    final productFormProvider = Provider.of<ProductFormProvider>(context);
    final product = productFormProvider.product;

    return Scaffold(
      body: SingleChildScrollView(
        //ocultar el teclaro cuando se hace scroll
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            // seccion de toma de fotografia
            Stack(
              children: [
                ProductImage( url: productService.selectedProduct?.picture ),

                // regresar a pagina anterior
                Positioned(
                  top: 60,
                  left: 20,
                  child: RawMaterialButton(
                    fillColor: Colors.black.withOpacity(0.05),
                    shape: CircleBorder(),
                    child: Icon( Icons.arrow_back, color: Colors.white ,),
                    onPressed: (){
                      Navigator.of(context).pop();
                    }
                  ), 
                  
                ),

                // abrir camara o galeria
                Positioned(
                  top: 60,
                  right: 10,
                  child: RawMaterialButton(
                    fillColor: Colors.black.withOpacity(0.05),
                    shape: CircleBorder(),
                    child: Icon( Icons.camera_alt, color: Colors.white ,),
                    onPressed: () async {
                      
                      final picker = new ImagePicker();
                      final XFile? pickedFile = await picker.pickImage(
                        source: ImageSource.camera,
                        imageQuality: 75,
                      );

                      if( pickedFile == null ){
                        // print('No selecciono nada');
                        return;
                      } else {
                        // print('Tenemos una imagen: ${ pickedFile.path }');
                        productService.updateSelectedProductImage(pickedFile.path);
                      }

                    }
                  ), 
                  
                ),
                
              ],
            ),



            // seccion de inputs (product form)
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              padding: EdgeInsets.symmetric( horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25)
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: Offset(0, 5)
                  ),
                ],
              ),

              child: Form(
                key: productFormProvider.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    // nombre del producto
                    TextFormField(
                      decoration: InputDecorations.authInputDecoration(
                        labelText: 'Producto',
                        hintText: 'Nombre del producto',
                      ),
                      initialValue: product.name,
                      onChanged: ( value ) => product.name = value,
                      validator: ( value ){
                        if( value == null || value.length < 1 ){
                          return 'El nombre es obligatorio';
                        }
                      },
                    ),
                    SizedBox(height: 10,),

                    // precio
                    TextFormField(                      
                      keyboardType: TextInputType.number,
                      decoration: InputDecorations.authInputDecoration(
                        labelText: 'Precio',
                        hintText: '\$ 00.00',
                      ),
                      initialValue: product.price.toStringAsFixed(2),
                      onChanged: ( value ) {

                        if( double.tryParse(value) == null || double.parse(value) < 0){
                          product.price = 0;
                        } else {
                          product.price = double.parse(value);
                        }

                      },
                      validator: ( value ){
                        if( value == null || value.length < 1 ){
                          return 'El precio es obligatorio';
                        }
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                      ],
                    ),
                    SizedBox(height: 10,),


                    // switch de disponibilidad
                    SwitchListTile.adaptive(
                      contentPadding: EdgeInsets.all(0),
                      title: Text('Producto disponible'),
                      value: product.available, 
                      activeColor: Colors.indigo,
                      onChanged: ( value ) => productFormProvider.updateAvailabilty(value),
                    ),



                    SizedBox(height: 20,),
                  ],
                ),
              ),
            ),

            /**Cuando aparezca el teclado en pantalla, este espacio adicional
             * nos ayudara a mover el formulario para que no sea oculto por el
             * teclado.
             */
            SizedBox( height: 100,)
          ],
        ),
      ),



      floatingActionButton: FloatingActionButton(
        child: (productService.isSaving == true)  
          ? CircularProgressIndicator( color: Colors.white, )
          : Icon(Icons.save_outlined, size: 35,),

        onPressed: (productService.isSaving == true) ? null         
          : () async {

            // guardar producto
            if( !productFormProvider.isValidForm() ) return;

            // subir imagen al servicio
            final String? imageUrl = await productService.uploadImage();
            // print( 'Subio imagen: $imageUrl' );

            if( imageUrl != null) product.picture = imageUrl;

            // guardar informacion del producto en el servicio
            await productService.saveOrCreateProduct(product);

            Navigator.pushReplacementNamed(context, 'home');
        },
      ),




    );
  }
}