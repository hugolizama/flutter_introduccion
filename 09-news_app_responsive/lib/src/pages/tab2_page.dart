import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';
import '../models/models.dart';
import '../services/services.dart';
import '../theme/tema.dart';

class Tab2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // _ListaCategorias
            Container(
              width: double.infinity,
              height: 90,
              child: ListView.builder(                
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: newsService.categories.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      children: [
                        // _CategoryButton
                        _CategoryButton( newsService.categories[index] ),
                        SizedBox(height: 5,),
                        Text( StringUtils.capitalize(newsService.categories[index].name) ),
                      ],
                    ),
                  );
                },
              ),
            ),


            // lista de noticias
            Expanded(
              child: (newsService.categoryArticles[newsService.selectedCategory]!.length == 0) 
                ? Center(child: CircularProgressIndicator(color: miTema.accentColor,),)
                : ListaNoticiasWidget(newsService.getArticulosCategoriaSeleccionada!)
            ),
            
          ],
        ),
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final Category category;
  const _CategoryButton(this.category);

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);


    return GestureDetector(      
      child: Container(
        width: 50,
        height: 50,        
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white
        ),
        child: Icon(
          category.icon,
          color: (newsService.selectedCategory == category.name) ? miTema.accentColor : Colors.black54,
        ),
      ),

      onTap: () {
        newsService.selectedCategory = category.name;
      },
    );
  }
}