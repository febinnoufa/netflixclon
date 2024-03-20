import 'package:flutter/material.dart';
import 'package:netflix_clon/common/utils.dart';
import 'package:netflix_clon/models/tv_seres_model.dart';
import 'package:netflix_clon/models/upcomin_model.dart';
import 'package:netflix_clon/screens/searchscreen.dart';
import 'package:netflix_clon/services/api_servise.dart';
import 'package:netflix_clon/widgets/constom_corousal_widget.dart';
import 'package:netflix_clon/widgets/movie_card_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<UpcominMovieModel> upcomingFuture;
  late Future<UpcominMovieModel> nowplayingFuture;
  late Future<TvSeriesModel> topRatedSeries;
  ApiServise apiServise = ApiServise();

  @override
  void initState() {
    super.initState();

    upcomingFuture = apiServise.getUpcomingMovies();
    nowplayingFuture = apiServise.getNowPlayingMovies();
    topRatedSeries = apiServise.getTopRatedSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kbackgroundcolor,
        title: Image.asset(
          'assets/netflixlogo.png',
          height: 100,
          width: 400,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 70),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchScreen(),
                  ),
                );
              },
              child: const Icon(
                Icons.search,
                color: Colors.white,
                size: 30,
              ),
            ),
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: topRatedSeries,
              builder: (context, AsyncSnapshot<TvSeriesModel> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if(snapshot.hasError){
                   return Center(child: CircularProgressIndicator());
                }
                
                
                else if (snapshot.hasData) {
                  return CostomCorouselSlider(data: snapshot.data!);
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            SizedBox(
              height: 220,
              child: MovieCardWidget(
                fucture: nowplayingFuture,
                headlinetext: "Now Playing ",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 220,
              child: MovieCardWidget(
                fucture: upcomingFuture,
                headlinetext: "Upcoming Movies",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
