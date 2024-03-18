import 'dart:convert';
import 'dart:developer';
import 'package:netflix_clon/common/utils.dart';
import 'package:netflix_clon/models/movie_detailmodel.dart';
import 'package:netflix_clon/models/movierecommentation.dart';
import 'package:netflix_clon/models/search_model.dart';
import 'package:netflix_clon/models/tv_seres_model.dart';
import 'package:netflix_clon/models/upcomin_model.dart';
import 'package:http/http.dart' as http;

const baseurl = "https://api.themoviedb.org/3/";
var key = "?api_key=$apikey";
late String endpoint;

class ApiServise {
  Future<UpcominMovieModel> getUpcomingMovies() async {
    endpoint = "movie/upcoming";
    final url = "$baseurl$endpoint$key";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      log("Succes ");

      return UpcominMovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("field to log upcoming movies");
  }

  Future<UpcominMovieModel> getNowPlayingMovies() async {
    endpoint = "movie/now_playing";
    final url = "$baseurl$endpoint$key";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      log("Succes ");

      return UpcominMovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("field to log Now Playing movies");
  }

  Future<MovieRecommentationModel> getPopulerMovies() async {
    endpoint = "movie/popular";
    final url = "$baseurl$endpoint$key";
    print("search url = $url");
    final response = await http.get(Uri.parse(url), headers: {});

    if (response.statusCode == 200) {
      log("Succes ");

      return MovieRecommentationModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("field to log Popular Movies");
  }

  Future<TvSeriesModel> getTopRatedSeries() async {
    endpoint = 'tv/1396/recommendations';
    final url = "$baseurl$endpoint$key";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      log("Succes ");

      return TvSeriesModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("field to log Top Rated Series");
  }

  Future<MovieDeatailModel> getMovieDetail(int movieId) async {
    endpoint = "movie/$movieId";
    final url = "$baseurl$endpoint$key";
    print("search url = $url");
    final response = await http.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      log("Succes ");

      return MovieDeatailModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("field to log Movie detail ");
  }

  Future<SearchModel> getSearchMovie(String searchtext) async {
    endpoint = "search/movie?query=$searchtext";
    final url = "$baseurl$endpoint";
    print("search url = $url");
    final response = await http.get(Uri.parse(url), headers: {
      'Authorization':
          "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NTAyYjhjMDMxYzc5NzkwZmU1YzBiNGY5NGZkNzcwZCIsInN1YiI6IjYzMmMxYjAyYmE0ODAyMDA4MTcyNjM5NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.N1SoB26LWgsA33c-5X0DT5haVOD4CfWfRhwpDu9eGkc"
    });

    if (response.statusCode == 200) {
      log("Succes ");

      return SearchModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("field to log searched to Movie");
  }

  Future<MovieRecommentationModel> getMovieRecommentations(int movieId) async {
    endpoint = "movie/$movieId/recommendations";
    final url = "$baseurl$endpoint$key";
    print("recommentation url = $url");
    final response = await http.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      log("Succes ");

      return MovieRecommentationModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("field to log Movie detail ");
  }
}
