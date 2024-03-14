import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clon/common/utils.dart';
import 'package:netflix_clon/models/movie_detailmodel.dart';
import 'package:netflix_clon/services/api_servise.dart';

class MovieDetailScreen extends StatefulWidget {
 final int movieId;
  const MovieDetailScreen({super.key, required this.movieId});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {

  ApiServise apiServise =ApiServise();
  late Future<MovieDeatailModel> movieDetail;

  @override
  void initState() {
    
    movieDetail=apiServise.getMovieDetail(widget.movieId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imageurl),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
