import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/movies_provider.dart';
import '../models/models.dart';

class CastingCards extends StatelessWidget {

  final int movieID;
  const CastingCards({required this.movieID});

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getMovieCast(movieID),
      builder: (context, AsyncSnapshot<List<Cast>> snapshot) {


        if( !snapshot.hasData ){
          return Container(
            margin: EdgeInsets.only(bottom: 30),
            width: double.infinity,
            height: 180,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final List<Cast> cast = snapshot.data!;

        return Container(
          margin: EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 180,
          // color: Colors.green,
          child: ListView.builder(
            itemCount: cast.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: ( BuildContext context, int index) {
              return _CastCard( actor: cast[index], );
            },
          ),
        );
      },
    );

    
  }
}

class _CastCard extends StatelessWidget {

  final Cast actor;

  const _CastCard({required this.actor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric( horizontal: 10, ),
      width: 110,
      height: 100,
      // color: Colors.orange,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/img/no-image.jpg'), 
              image: NetworkImage( actor.fullProfileImg ),
              height: 140,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),

          SizedBox(height: 5,),

          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}