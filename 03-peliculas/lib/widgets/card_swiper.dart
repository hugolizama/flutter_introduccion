import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import '../models/models.dart';

class CardSwipper extends StatelessWidget {

  final List<Movie> movies;

  const CardSwipper({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if(this.movies.length == 0){
      return Container(
        width: double.infinity,
        height: size.height * 0.5,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Container(
      width: double.infinity,
      height: size.height * 0.5,
      // color: Colors.red,
      child: Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        scrollDirection: Axis.horizontal,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.45,
        itemBuilder: (BuildContext context, int index) {

          final movie = movies[index];

          movie.heroId = 'swiper-${ movie.id }';

          return GestureDetector(
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage( movie.fullPosterImg ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            onTap: () =>
                Navigator.pushNamed(context, 'details', arguments: movie),
          );
        },
      ),
    );
  }
}
