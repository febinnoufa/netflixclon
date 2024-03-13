import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clon/common/utils.dart';
import 'package:netflix_clon/models/search_model.dart';
import 'package:netflix_clon/services/api_servise.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SearchScreen> {
  TextEditingController searchcontroller = TextEditingController();
  ApiServise apiServise = ApiServise();

  SearchModel? searchModel;

  void search(String query) {
    apiServise.getSearchMovie(query).then((result) {
      setState(() {
        searchModel = result;
      });
    });
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
              searchModel == null
                  ? const SizedBox.shrink()
                  : GridView.builder(
                      shrinkWrap: true,
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
                            CachedNetworkImage(
                              imageUrl:
                                  "$imageurl${searchModel!.results[index].backdropPath}",
                              height: 170,
                            ),
                            Text("${searchModel!.results[index].originalTitle}",
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 14,

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
