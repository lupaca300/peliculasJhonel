import 'package:flutter/material.dart';
import 'package:peliculas/providers/movie_provider.dart';
import 'package:peliculas/screens/movie_search_delegate.dart';
import 'package:peliculas/screens/screens.dart';
import 'package:peliculas/widgets/card_swiper.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moviesProvider = context.watch<MoviesProvider>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 107, 12, 158),
        title: Text(
          "PELICULAS",
          style: TextStyle(
              fontSize: 18,
              letterSpacing: 3,
              color: Color.fromARGB(255, 137, 135, 136)),
        ),
        actions: [
          IconButton(
              color: const Color.fromARGB(255, 184, 138, 0),
              onPressed: () =>
                  showSearch(context: context, delegate: MovieSerachDelagate()),
              icon: Icon(Icons.search)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            CardSwiper(
              movie: moviesProvider.onDisplayMovie,
            ),
            MovieSlider(),
          ],
        ),
      ),
    );
  }
}
