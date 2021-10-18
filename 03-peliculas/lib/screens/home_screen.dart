import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';
import '../providers/movies_provider.dart';
import '../search/search_delegate.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Películas en cines'),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search_outlined),
            onPressed: () => showSearch(context: context, delegate: MovieSearchDelegate()), 
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardSwipper( movies: moviesProvider.onDisplayMovies ),
            MovieSlider( 
              movies: moviesProvider.popularMovies, 
              title: 'Populares!!',
              onNextPage: () => moviesProvider.getPopularMovies(),
            ),
          ],
        ),
      )
    );
  }
}