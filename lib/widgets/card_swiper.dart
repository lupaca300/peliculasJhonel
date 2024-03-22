import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/models/movies.dart';
import 'package:peliculas/providers/movie_provider.dart';
import 'package:provider/provider.dart';

class CardSwiper extends StatefulWidget {
  CardSwiper({super.key, required movie});

  List<Movie> movie = [];
  @override
  State<CardSwiper> createState() => _CardSwiperState();
}

class _CardSwiperState extends State<CardSwiper> {
  final urlPlaceholder = 'https://via.placeholder.com/400x400';
  final aux = 'https://image.tmdb.org/t/p/w500';
  Widget build(BuildContext context) {
    final MoviesProvider moviesP = Provider.of<MoviesProvider>(context);
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.5,
      child: Swiper(
        index: 0,
        itemCount: moviesP.onDisplayMovie.length,
        layout: SwiperLayout.STACK,
        itemHeight: size.height * 0.7,
        itemWidth: size.width * 0.6,
        itemBuilder: (_, int index) {
          if (moviesP.onDisplayMovie[index] == '') {
            return gesture(urlPlaceholder, index, urlPlaceholder);
          } else {
            return gesture(moviesP, index, urlPlaceholder);
          }
        },
      ),
    );
  }

  GestureDetector gesture(moviesP, index, urlPlaceholder) {
    try {
      String aux2;
      Movie movie = moviesP.onDisplayMovie[index];
      if (moviesP != urlPlaceholder) {
        aux2 = this.aux + movie.posterPath;
      } else {
        aux2 = aux;
      }
      return GestureDetector(
        onTap: () => Navigator.pushNamed(context, 'details',
            arguments: [moviesP.onDisplayMovie[index]]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Hero(
            tag: movie.id.toString(),
            child: FadeInImage(
              placeholder: NetworkImage(urlPlaceholder),
              image: NetworkImage(aux2),
              imageErrorBuilder: (context, error, stackTrace) => Container(
                height: 200,
                width: 150,
                color: Color.fromARGB(255, 183, 183, 183),
                alignment: Alignment.center,
                child: Text(movie.title),
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    } catch (e) {
      return GestureDetector(
        child: Container(
          color: Colors.red,
          child: Text("$e"),
        ),
      );
    }
  }
}
