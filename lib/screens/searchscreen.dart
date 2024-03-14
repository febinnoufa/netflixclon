import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clon/common/utils.dart';
import 'package:netflix_clon/models/movierecommentation.dart';
import 'package:netflix_clon/models/search_model.dart';
import 'package:netflix_clon/screens/movie_detail_screen.dart';
import 'package:netflix_clon/services/api_servise.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SearchScreen> {
  TextEditingController searchcontroller = TextEditingController();
  ApiServise apiServise = ApiServise();
  late Future<MovieRecommentationModel> populerMovies;

  SearchModel? searchModel;

  void search(String query) {
    apiServise.getSearchMovie(query).then((result) {
      setState(() {
        searchModel = result;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    populerMovies = apiServise.getPopulerMovies();
  }

  @override
  void dispose() {
    searchcontroller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CupertinoSearchTextField(
              controller: searchcontroller,
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
                } else {
                  search(searchcontroller.text);
                }
              },
            ),
            searchcontroller.text.isEmpty
                ? FutureBuilder(
                    future: populerMovies,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data?.results;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              "Top Searches",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ListView.builder(
                              itemCount: data!.length,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) =>MovieDetailScreen(movieId: data[index].id,) ,));
                                  },
                                  child: Container(
                                    height: 150,
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20)),
                                    child: Row(
                                      children: [
                                        Image.network(
                                            "${imageurl}${data[index].posterPath}"),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        SizedBox(
                                          width: 240,
                                          child: Text(
                                            data[index].title,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          ],
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    })
                : searchModel == null
                    ? const SizedBox.shrink()
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: searchModel?.results.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 15,
                                crossAxisSpacing: 5,
                                childAspectRatio: 1.2 / 2),
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              searchModel!.results[index].backdropPath == null
                                  ? Image.asset(
                                      "assets/netflix.png",
                                      height: 150,
                                    )
                                  : CachedNetworkImage(
                                      imageUrl:
                                          "$imageurl${searchModel!.results[index].backdropPath}",
                                      height: 150,
                                    ),
                              SizedBox(
                                width: 100,
                                child: Text(
                                  searchModel!.results[index].originalTitle,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      )
          ],
        ),
      ),
    ));
  }
}
