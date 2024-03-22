import 'dart:convert';

import 'package:peliculas/models/cast.dart';

class Credits {
  int id;
  List<Cast> cast;
  List<Cast> crew;

  Credits({
    required this.id,
    required this.cast,
    required this.crew,
  });

  factory Credits.fromRawJson(String str) => Credits.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Credits.fromJson(Map<String, dynamic> json) => Credits(
        id: json["id"],
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromJson(x))),
        crew: List<Cast>.from(json["crew"].map((x) => Cast.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cast": List<dynamic>.from(cast.map((x) => x.toJson())),
        "crew": List<dynamic>.from(crew.map((x) => x.toJson())),
      };
}
