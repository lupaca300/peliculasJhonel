import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:peliculas/models/movies.dart';

import 'package:peliculas/widgets/casting_card.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<dynamic> movie =
        (ModalRoute.of(context)?.settings.arguments ?? '') as List<dynamic>;
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _CustomAppBar(
          movieC: movie,
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          PosterAndTitle(
            movie: movie,
          ),
          _OverView(overview: movie[0].overview),
          CastingCard(
            index: movie[0].id,
          )
        ]))
      ],
    ));
  }
}

class _CustomAppBar extends StatelessWidget {
  final movieC;
  _CustomAppBar({required this.movieC});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 30,
      collapsedHeight: 150,
      floating: false,
      pinned: false,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.only(),
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Text(
              textAlign: TextAlign.center,
              style: TextStyle(color: const Color.fromARGB(255, 190, 190, 190)),
              "${movieC[0].originalTitle}"),
        ),
        background: FadeInImage(
          placeholder: NetworkImage('https://via.placeholder.com/300x400'),
          image: NetworkImage("https://image.tmdb.org/t/p/w500/" +
              movieC[0].backdropPath.toString()),
          imageErrorBuilder: (context, error, stackTrace) {
            return Container();
          },
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class PosterAndTitle extends StatelessWidget {
  final movie;
  const PosterAndTitle({
    super.key,
    this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final sizePoster = MediaQuery.of(context).size;
    print(movie[0].id);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: sizePoster.width * 0.3,
          height: sizePoster.height * 0.3,
          margin: EdgeInsets.all(15),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Hero(
              tag: movie[0].id.toString(),
              child: FadeInImage(
                image: NetworkImage("https://image.tmdb.org/t/p/w500/" +
                    movie[0].posterPath.toString()),
                placeholder:
                    NetworkImage("https://via.placeholder.com/300x400"),
                imageErrorBuilder: (context, error, stackTrace) {
                  return Container();
                },
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Flexible(
            child: Container(
                child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              movie[0].title.toString(),
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              movie[0].originalTitle.toString(),
              style: Theme.of(context).textTheme.labelLarge,
            ),
            Row(children: [
              Icon(
                Icons.star_outline_outlined,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(movie[0].voteAverage.toString()))
            ])
          ],
        )))
      ],
    );
  }
}

class _OverView extends StatelessWidget {
  final overview;
  const _OverView({super.key, this.overview});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(20),
        child: Text(
          textAlign: TextAlign.justify,
          overview.toString(),
        ));
  }
}
