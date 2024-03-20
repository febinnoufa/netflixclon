import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clon/common/utils.dart';
import 'package:netflix_clon/models/movierecommentation.dart';
import 'package:netflix_clon/models/search_model.dart';
import 'package:netflix_clon/screens/movie_detail_screen.dart';
import 'package:netflix_clon/services/api_servise.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  ApiServise apiService = ApiServise();
  late Future<MovieRecommentationModel> popularMovies;

  SearchModel? searchModel;

  @override
  void initState() {
    super.initState();
    popularMovies = apiService.getPopulerMovies();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  void search(String query) {
    apiService.getSearchMovie(query).then((result) {
      setState(() {
        searchModel = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              CupertinoSearchTextField(
                controller: searchController,
                padding: const EdgeInsets.all(10.0),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                suffixIcon: const Icon(
                  Icons.cancel,
                  color: Colors.grey,
                ),
                style: const TextStyle(color: Colors.white),
                backgroundColor: Colors.grey.withOpacity(0.3),
                onChanged: (value) {
                  if (value.isEmpty) {
                    setState(() {
                      searchModel = null;
                    });
                  } else {
                    search(value);
                  }
                },
              ),
              searchController.text.isEmpty
                  ? FutureBuilder<MovieRecommentationModel>(
                      future: popularMovies,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasData) {
                          var data = snapshot.data?.results;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              const Text(
                                "Top Searches",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 20),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: data!.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                MovieDetailScreen(
                                              movieId: data[index].id,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        height: 120,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Row(
                                          children: [
                                            Image.network(
                                              "$imageurl${data[index].posterPath}",
                                              fit: BoxFit.fitHeight,
                                            ),
                                            const SizedBox(width: 20),
                                            SizedBox(
                                              width: 240,
                                              child: Text(
                                                data[index].title,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    )
                  : searchModel == null
                      ? const SizedBox.shrink()
                      : GridView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: searchModel!.results.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 5,
                            childAspectRatio: 1.2 / 2,
                          ),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MovieDetailScreen(
                                      movieId: searchModel!.results[index].id,
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  searchModel!.results[index].backdropPath ==
                                          null
                                      ? Column(
                                          children: [
                                            Image.asset(
                                              "assets/netflix.png",
                                              height: 150,
                                            ),
                                            Text(
                                              searchModel!.results[index].title,
                                              maxLines: 2,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        )
                                      : Column(
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl:
                                                  "$imageurl${searchModel!.results[index].backdropPath}",
                                              height: 150,
                                            ),
                                            Text(
                                              searchModel!.results[index].title,
                                              maxLines: 2,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                ],
                              ),
                            );
                          },
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
