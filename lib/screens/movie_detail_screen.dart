import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clon/common/utils.dart';
import 'package:netflix_clon/models/movie_detailmodel.dart';
import 'package:netflix_clon/models/movierecommentation.dart';
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
  late Future<MovieRecommentationModel> movieRecommentation;

  @override
  void initState() {
    fetchinitialdata();
    super.initState();
  }

  fetchinitialdata() {
    movieDetail = apiServise.getMovieDetail(widget.movieId);
    movieRecommentation = apiServise.getMovieRecommentations(widget.movieId);

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
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                            const SizedBox(
                              width: 30,
                            ),
                            Text(
                              genresText,
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 17),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          movie.overview,
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 17),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    FutureBuilder(
                      future: movieRecommentation,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final movie = snapshot.data;
                          return movie!.results.isEmpty
                              ? const SizedBox()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("More like this"),
                                    const SizedBox(),
                                    GridView.builder(
                                      itemCount: movie.results.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        mainAxisSpacing: 15,
                                        crossAxisSpacing: 5,
                                        childAspectRatio: 1.5 / 2,
                                      ),
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    MovieDetailScreen(
                                                        movieId: movie
                                                            .results[index].id),
                                              ),
                                            );
                                          },
                                          child: CachedNetworkImage(
                                              imageUrl:
                                                  "${imageurl}${movie.results[index].posterPath}"),
                                        );
                                      },
                                    )
                                  ],
                                );
                        }
                        return const Text("somthing wrong");
                      },
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
