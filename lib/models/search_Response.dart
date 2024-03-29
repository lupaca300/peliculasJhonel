import 'dart:convert';

import 'package:peliculas/models/search_movie.dart';

class SearchResponse {
  int page;
  List<SearchMovie> results;
  int totalPages;
  int totalResults;

  SearchResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory SearchResponse.fromRawJson(String str) =>
      SearchResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
        page: json["page"],
        results: List<SearchMovie>.from(
            json["results"].map((x) => SearchMovie.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}
