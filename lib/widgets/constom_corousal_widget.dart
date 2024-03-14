import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clon/common/utils.dart';
import 'package:netflix_clon/models/tv_seres_model.dart';

class CostomCorouselSlider extends StatelessWidget {
  final TvSeriesModel data;

  const CostomCorouselSlider({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: (size.height * 0.33 < 300) ? 300 : size.height * 0.33,
      child: CarouselSlider.builder(
          itemCount: data.results.length,
          itemBuilder: (context, index, realIndex) {
            var url = data.results[index].backdropPath.toString();

            return GestureDetector(
                child: Column(
              children: [
                CachedNetworkImage(imageUrl: "$imageurl$url"),
                const SizedBox(
                  height: 20,
                ),
                Text(data.results[index].name)
              ],
            ));
          },
          options: CarouselOptions(
              height: (size.height * 0.33 < 300) ? 300 : size.height * 0.33,
              aspectRatio: 16 / 9,
              reverse: false,
              initialPage: 0,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal)),
    );
  }
}
