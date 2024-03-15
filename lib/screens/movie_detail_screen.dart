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
  ApiServise apiServise = ApiServise();
  late Future<MovieDeatailModel> movieDetail;
  // late Future<MovieRecommentationModel> movieRecommentationModel;

  @override
  void initState() {
    fetchinitialdata();
    super.initState();
  }

  fetchinitialdata() {
    movieDetail = apiServise.getMovieDetail(widget.movieId);
    //  movieRecommentationModel= apiServise.get
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print("detail page key : ${widget.movieId}");
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: movieDetail,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final movie = snapshot.data;

                String genresText =
                    movie!.genres.map((genre) => genre.name).join(', ');

                return Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                            height: MediaQuery.of(context).size.height * 0.4,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "$imageurl${movie.backdropPath}"),
                                  fit: BoxFit.cover),
                            ),
                            child: SafeArea(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(
                                        Icons.arrow_back_ios,
                                        color: Colors.white,
                                      )),
                                ],
                              ),
                            ))
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          movie.title,
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text(
                              movie.releaseDate.year.toString(),
                              style: const TextStyle(color: Colors.grey),
                            ),
                            SizedBox(width: 30,)
                          ],
                        )
                      ],
                    )
                  ],
                );
              } else {
                return const SizedBox();
              }
            }),
      ),
    );
  }
}
