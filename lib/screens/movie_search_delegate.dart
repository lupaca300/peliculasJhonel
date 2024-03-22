import 'dart:async';

import 'package:flutter/material.dart';
import 'package:peliculas/models/search_movie.dart';
import 'package:peliculas/providers/movie_provider.dart';
import 'package:provider/provider.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';

class MovieSerachDelagate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'buscar pelicula';
  List? memorySearchMovie;

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [IconButton(onPressed: () => query = '', icon: Icon(Icons.delete))];
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 3, horizontal: 3),
          leading: FadeInImage(
              placeholder: NetworkImage('https://via.placeholder.com/300x400'),
              image: NetworkImage(memorySearchMovie![index].fullPosterPath)),
          title: Text(memorySearchMovie![index].title),
        );
      },
      itemCount: memorySearchMovie!.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container(
        child: Center(
          child: Icon(
            Icons.movie_creation_outlined,
            size: 200,
          ),
        ),
      );
    } else {
      MoviesProvider? movieP =
          Provider.of<MoviesProvider>(context, listen: false);
      movieP.getSuggestionSearch(query);
      return StreamBuilder(
        stream: movieP.streamC,
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: LoadingAnimationWidget.discreteCircle(
                  color: Colors.red, size: 50),
            );
          } else {
            memorySearchMovie = snapshot.data;
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                //   memorySearchMovie = snapshot.data;

                return ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                  onTap: () => Navigator.pushNamed(context, 'details',
                      arguments: [snapshot.data![index]]),
                  leading: FadeInImage(
                      width: 100,
                      height: 100,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 100,
                          height: 100,
                        );
                      },
                      placeholder:
                          NetworkImage('https://via.placeholder.com/300x400'),
                      image:
                          NetworkImage(snapshot.data![index].fullPosterPath)),
                  title: Text(snapshot.data![index].title),
                  subtitle: Text(snapshot.data![index].originalTitle),
                );
              },
            );
          }
        },
      );
    }
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }
}
