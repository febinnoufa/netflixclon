import 'package:flutter/material.dart';
import 'package:netflix_clon/models/upcomin_model.dart';
//import 'package:netflix_clon/models/upcoming_model.dart'; // Corrected the import statement
//import 'package:netflix_clon/services/api_service.dart'; // Corrected the import statement
import 'package:netflix_clon/services/api_servise.dart';
import 'package:netflix_clon/widgets/coming_soon_movie_widget.dart';
import 'package:netflix_clon/widgets/evryone_watch_widget.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key); // Corrected the constructor

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  late Future<UpcominMovieModel> upcomingFuture;
  ApiServise apiService = ApiServise(); // Corrected the variable name
  @override
  void initState() {
    super.initState();
    upcomingFuture = apiService.getUpcomingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.black,
            title: const Text(
              "New & Hot",
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              const Icon(
                Icons.cast,
                color: Colors.white,
              ),
              const SizedBox(
                width: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  color: Colors.blue,
                  height: 27,
                  width: 27,
                ),
              ),
              const SizedBox(
                width: 20,
              )
            ],
            bottom: TabBar(
              dividerColor: Colors.black,
              isScrollable: false,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              labelColor: Colors.black,
              labelStyle:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              unselectedLabelColor: Colors.white,
              tabs: const [
                Tab(
                  text: "   🍿 Coming Soon   ",
                ),
                Tab(
                  text: "   🔥 Everyone's Watching   ",
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    FutureBuilder<UpcominMovieModel>(
                      future: upcomingFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasData &&
                            snapshot.data!.results.isNotEmpty) {
                          final movie = snapshot.data!.results[0];
                          return ComingSoonMovieWidget(
                            imageUrl: movie.posterPath,
                            overview: movie.overview,
                            logourl: movie.backdropPath,
                            month:
                                "Apr", // You might want to update this dynamically
                            day:
                                "12", // You might want to update this dynamically
                            logoUrl: "", // Corrected the parameter name
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FutureBuilder<UpcominMovieModel>(
                      future: upcomingFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasData &&
                            snapshot.data!.results.isNotEmpty) {
                          final movie = snapshot.data!.results[1];
                          return ComingSoonMovieWidget(
                            imageUrl: movie.posterPath,
                            overview: movie.overview,
                            logourl: movie.backdropPath,
                            month:
                              "Mar", // You might want to update this dynamically
                            day:
                                "29", // You might want to update this dynamically
                            logoUrl: "", // Corrected the parameter name
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    FutureBuilder<UpcominMovieModel>(
                      future: upcomingFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasData &&
                            snapshot.data!.results.isNotEmpty) {
                          final movie = snapshot.data!.results[2];
                          return EveryoneWatchWidget(
                            imageUrl: movie.posterPath,
                            overview: movie.overview,
                            logourl: movie.backdropPath,
                            month: "Apr",
                            day: "12",
                            logoUrl: "",
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FutureBuilder<UpcominMovieModel>(
                      future: upcomingFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasData &&
                            snapshot.data!.results.isNotEmpty) {
                          final movie = snapshot.data!.results[3];
                          return EveryoneWatchWidget(
                            imageUrl: movie.posterPath,
                            overview: movie.overview,
                            logourl: movie.backdropPath,
                            month: "Mar",
                            day: "29",
                            logoUrl: "",
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
