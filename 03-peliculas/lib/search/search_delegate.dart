
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../providers/movies_provider.dart';

class MovieSearchDelegate extends SearchDelegate {

  @override
  String get searchFieldLabel => 'Buscar película';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon( Icons.clear ),
        onPressed: () {
          query = '';
        }, 
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon( Icons.arrow_back ),
      onPressed: (){
        close(context, null);
      }, 
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('buildResults');
  }

  Widget _emptyContainer() {
    return Container(
      child: Center(
        child: Icon( Icons.movie_creation_outlined, color: Colors.black38, size: 200, ),
      ),
    ); 
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    if( query.isEmpty ){
      return _emptyContainer();
    }

    print('http request');

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    moviesProvider.getSuggestionsByQuery( query );    

    return StreamBuilder(
      stream: moviesProvider.suggestionStream,
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {

        if( !snapshot.hasData ) {
          return _emptyContainer();
        } 

        final movies = snapshot.data!;
        
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: ( BuildContext context, int index) {
            return _MovieItem(movie: movies[index]);
          },
        );
      },
    );
  }

} 



class _MovieItem extends StatelessWidget {

  final Movie movie;

  const _MovieItem({required this.movie});

  @override
  Widget build(BuildContext context) {

    movie.heroId = 'search-${ movie.id }';

    return Hero(
      tag: movie.heroId!,
      child: ListTile(
        leading: FadeInImage(
          placeholder: AssetImage('assets/img/no-image.jpg'), 
          image: NetworkImage( movie.fullPosterImg ),
          width: 50,
          fit: BoxFit.contain,
        ),
        title: Text( movie.title ),
        subtitle: Text( movie.originalTitle ),
        onTap: (){
          Navigator.pushNamed(context, 'details', arguments: movie );
        },
      ),
    );
  }
}