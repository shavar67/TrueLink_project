import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_demo/pages/movie_details_page.dart';
import 'package:movie_demo/widgets/customText.dart';
import '../constants/spacers.dart';
import '../model/movie_model.dart';
import '../pages/movie_details_page.dart';

class MovieGridItem extends StatefulWidget {
  final int index;
  final List<MovieModel> movies;
  const MovieGridItem({Key? key, required this.index, required this.movies})
      : super(key: key);

  @override
  State<MovieGridItem> createState() => _GridItemState();
}

class _GridItemState extends State<MovieGridItem> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Spacers.spacer8, vertical: Spacers.spacer8),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MovieDetailsScreen(
                      imdb_movie: widget.movies,
                      index: widget.index,
                    )));
          },
          child: Hero(
            tag: '${widget.movies[widget.index].poster}',
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                image: DecorationImage(
                    fit: BoxFit.cover,
                    alignment: FractionalOffset.topCenter,
                    image: '${widget.movies[widget.index].poster}' == 'N/A'
                        ? const NetworkImage(
                            'https://api.lorem.space/image/movie?w=150&h=220')
                        : NetworkImage(
                            '${widget.movies[widget.index].poster}')),
                borderRadius:
                    const BorderRadius.all(Radius.circular(Spacers.spacer8)),
                color: Colors.black,
              ),
              alignment: Alignment.center,
              child: Stack(children: [
                Positioned(
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                            width: _width,
                            height: _width * 0.16,
                            decoration: const BoxDecoration(
                                color: Colors
                                    .black, //Colors.white.withOpacity(0.5),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(Spacers.spacer8),
                                  bottomRight: Radius.circular(Spacers.spacer8),
                                )),
                            child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    bottomLeft:
                                        Radius.circular(Spacers.spacer8),
                                    bottomRight:
                                        Radius.circular(Spacers.spacer8)),
                                child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 10.0,
                                      sigmaY: 10.0,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          CustomText(
                                            content:
                                                '${widget.movies[widget.index].title}',
                                            size: 8,
                                            color: Colors.white,
                                          ),
                                          CustomText(
                                            content:
                                                '${widget.movies[widget.index].year}',
                                            size: 8,
                                            color: Colors.grey.withOpacity(0.7),
                                          ),
                                        ],
                                      ),
                                    ))))))
              ]),
            ),
          ),
          // ),
        ));
  }
}
