import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clon/common/utils.dart';

class ComingSoonMovieWidget extends StatelessWidget {
  final String imageUrl;
  final String overview;
  final String logourl;
  final String month;
  final String day;
  const ComingSoonMovieWidget(
      {super.key,
      required this.imageUrl,
      required this.overview,
      required this.logourl,
      required this.month,
      required this.day,
      required String logoUrl});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      child: Row(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                month,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                day,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    letterSpacing: 5),
              )
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(imageUrl: "$imageurl$imageUrl"),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: size.width * 0.5,
                    height: size.height * 0.2,
                    child: CachedNetworkImage(
                      imageUrl: "$imageurl$logourl",
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  // const SizedBox(width: 10,),
                  const Spacer(),

                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.notifications_none_rounded,
                        size: 25,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Remind me",
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                  //  SizedBox(width: 20,),
                  const Column(
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        size: 25,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "info ",
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Coming on $month $day",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    overview,
                    maxLines: 4,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}
