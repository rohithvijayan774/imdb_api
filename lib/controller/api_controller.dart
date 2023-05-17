import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imdb_api/const/api_key.dart';
import 'package:imdb_api/model/movie_model.dart';

class MovieAPI {
  static Future<List<Movie>> fetchMovies() async {
    try {
      print('FetchMovie Called');
      const url = 'https://imdb-top-100-movies.p.rapidapi.com/';
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'X-RapidAPI-Key': apiKey,
        'X-RapidAPI-Host': 'imdb-top-100-movies.p.rapidapi.com'
      });
      final statusCode = response.statusCode;
      print(statusCode);
      if (statusCode == 200) {
        final body = response.body;
        final json = jsonDecode(body) as List<dynamic>;
        print(json);

        final movies = json.map((json) {
          return Movie.fromMap(json);
        }).toList();
        //final movies = movieListmodel(json);

        print('Fetch Movie Completed');
        return movies;
      } else {
        return [];
      }
    } on Exception catch (e) {
      print(e.toString());
      return [];
    }
  }
}
