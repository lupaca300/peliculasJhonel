import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:peliculas/models/cast.dart';
import 'package:peliculas/providers/movie_provider.dart';
import 'package:provider/provider.dart';

class CastingCard extends StatelessWidget {
  int index;
  CastingCard({super.key, required this.index});
  @override
  Widget build(BuildContext context) {
    final moviesP = Provider.of<MoviesProvider>(context, listen: false);
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: FutureBuilder(
          future: moviesP.getCredits(index),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container(
                child: Center(
                  child: LoadingAnimationWidget.discreteCircle(
                      color: const Color.fromARGB(255, 51, 136, 147), size: 50),
                ),
              );
            } else {
              final listCast = snapshot.data as List<Cast>;
              return Container(
                margin: EdgeInsets.only(bottom: 30),
                width: double.infinity,
                height: 200,
                child: ListView.builder(
                    itemCount: listCast.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      if (listCast[index].profilePath != null) {
                        return _CastCard(
                          profilePath: listCast[index].profilePath!,
                          name: listCast[index].name,
                        );
                      } else {
                        print('null');
                        return Container();
                      }
                    }),
              );
            }
          },
        ));
  }
}

class _CastCard extends StatefulWidget {
  String profilePath;
  String? name;
  _CastCard({required this.profilePath, required this.name});

  @override
  State<_CastCard> createState() => _CastCardState();
}

class _CastCardState extends State<_CastCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 100,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: NetworkImage('https://via.placeholder.com/300x400'),
              image: NetworkImage(
                  'https://image.tmdb.org/t/p/w500${widget.profilePath}'),
              fit: BoxFit.cover,
            ),
          ),
          Text(
            widget.name.toString(),
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
