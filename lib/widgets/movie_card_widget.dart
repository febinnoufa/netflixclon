import 'package:flutter/material.dart';
import 'package:netflix_clon/common/utils.dart';
import 'package:netflix_clon/models/upcomin_model.dart';
import 'package:netflix_clon/screens/movie_detail_screen.dart';

class MovieCardWidget extends StatelessWidget {
  final Future<UpcominMovieModel> fucture;
  final String headlinetext;
  const MovieCardWidget(
      {super.key, required this.fucture, required this.headlinetext});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fucture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          
        
        var data = snapshot.data?.results;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              headlinetext,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: data?.length ??
                    0, // Ensure data is not null before accessing its length
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  // Check if data is null or index is out of bounds
                  if (data == null || index >= data.length) {
                    return const SizedBox(); // Return an empty SizedBox if data is null or index is out of bounds
                  }
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MovieDetailScreen(
                                      movieId:data[index].id),
                                ),
                              );
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(20)),
                      child:
                          Image.network("${imageurl}${data[index].posterPath}"),
                    ),
                  );
                },
              ),
            )
          ],
        );
      }else{
        return const SizedBox.shrink();
      }
      }
    );
  }
}
