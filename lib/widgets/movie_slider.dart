import 'package:flutter/material.dart';
import 'package:peliculas/providers/movie_provider.dart';
import 'package:provider/provider.dart';

class MovieSlider extends StatelessWidget {
  const MovieSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final moviesP = Provider.of<MoviesProvider>(context);
    return Container(
      width: double.infinity,
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text("Populares"),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: moviesP.onDisplayMovie.length,
              itemBuilder: (_, int index) {
                print(index);
                return _MoviePoster(count: index);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  final count;
  const _MoviePoster({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    final moviesP = Provider.of<MoviesProvider>(context);
    if (moviesP.onDisplayMovie[count] == '') {
      return Container();
    } else {
      return Container(
        width: 100,
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'details',
                  arguments: [moviesP.onDisplayMovie[count]]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  height: 170,
                  placeholder:
                      NetworkImage('https://via.placeholder.com/300x400'),
                  image: NetworkImage("https://image.tmdb.org/t/p/w500/" +
                      moviesP.onDisplayMovie[count].posterPath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              moviesP.onDisplayMovie[count].originalTitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      );
    }
  }
}
