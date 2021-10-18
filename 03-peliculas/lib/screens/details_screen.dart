import 'package:flutter/material.dart';
import 'package:peliculas/widgets/widgets.dart';

import '../models/models.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie =
        ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      body: CustomScrollView(
      slivers: [
        _CustomAppBar( movie: movie ),
        SliverList(
          delegate: SliverChildListDelegate([
            _PosterAndTitle( movie: movie ),
            _Overview( movie: movie ),
            CastingCards( movieID: movie.id ),
          ])
        ),
      ],
    ));
  }
}

class _CustomAppBar extends StatelessWidget {

  final Movie movie;

  const _CustomAppBar({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.symmetric(horizontal: 20),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          padding: EdgeInsets.only(bottom: 10),
          child: Text(
            movie.title,
            style: TextStyle(fontSize: 18),
          )
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/img/loading.gif'),
          image: NetworkImage( movie.fullBackdropImg ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}


class _PosterAndTitle extends StatelessWidget {

  final Movie movie;

  const _PosterAndTitle({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: movie.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage( movie.fullPosterImg ),
                height: 150,
              ),
            ),
          ),

          SizedBox(width: 20,),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title, 
                  style: Theme.of(context).textTheme.headline6, 
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),

                Text(
                  movie.originalTitle, 
                  style: textTheme.subtitle1, 
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),

                Row(
                  children: [
                    Icon(Icons.star_outline, size: 25, color: Colors.grey,),
                    SizedBox(width: 5,),
                    Text(
                      movie.voteAverage.toString(),
                      style: textTheme.caption,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class _Overview extends StatelessWidget {

   final Movie movie;

  const _Overview({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),

    );
  }
}