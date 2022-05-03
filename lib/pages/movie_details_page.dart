// ignore_for_file: slash_for_doc_comments

import 'dart:ui';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:movie_demo/provider/omdb_model_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/api_.dart';
import '../constants/spacers.dart';
import '../model/movie_model.dart';
import '../widgets/customText.dart';
import '../widgets/gradient_text.dart';

class MovieDetailsScreen extends StatefulWidget {
  final double _collapsedMovieCard = 20;
  final double _closedMovieCard = -450;
  final List<MovieModel> imdb_movie;
  final int index;
  const MovieDetailsScreen({required this.imdb_movie, required this.index})
      : super();

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreen();
}

class _MovieDetailsScreen extends State<MovieDetailsScreen>
    with AfterLayoutMixin<MovieDetailsScreen> {
  bool isDismissed = true;
  double defaultPosition = -450;
  bool isLiked = false;
  String url = ApiConstants.OMDBAPIURL;

  @override
  void initState() {
    super.initState();
    final movieProvider =
        Provider.of<OmdbModelProvider>(context, listen: false);
    movieProvider.getMovieData(widget.imdb_movie[widget.index].imdbID);
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    final movieProvider = Provider.of<OmdbModelProvider>(context);
    return Scaffold(
        body: Stack(children: [
      Hero(
        tag: '${movieProvider.movie.poster}${widget.index}',
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                alignment: FractionalOffset.topCenter,
                image: widget.imdb_movie[widget.index].poster == 'N/A'
                    ? const NetworkImage(
                        'https://api.lorem.space/image/movieProvider?w=150&h=220')
                    : NetworkImage(
                        '${widget.imdb_movie[widget.index].poster}')),
          ),
        ),
      ),
      Positioned.fill(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: _width,
            height: _height,
            color: Colors.black.withOpacity(0.75),
          ),
        ),
      ),
      // Positioned(
      //     top: 50,
      //     child: IconButton(
      //       color: Colors.blue,
      //       icon: const Icon(Icons.arrow_back_ios),
      //       onPressed: () {
      //         Navigator.of(context).pop();
      //       },
      //     )),
      // const Positioned(
      //     top: 66.5,
      //     left: 30,
      //     child: CustomText(content: 'Back', size: 12, color: Colors.blue)),
      AnimatedPositioned(
        curve: Curves.easeInOutExpo,
        left: 5,
        // TODO:Adjust default offset //
        bottom: defaultPosition,
        duration: const Duration(milliseconds: 500),
        child: buildCard(context),
      ),
      Positioned(
        top: 70,
        left: 80,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: _width * 0.65,
            height: _width * 0.80,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  alignment: FractionalOffset.topCenter,
                  image: widget.imdb_movie[widget.index].poster == 'N/A'
                      ? const NetworkImage(
                          'https://api.lorem.space/image/movieProvider?w=150&h=220')
                      : NetworkImage(
                          '${widget.imdb_movie[widget.index].poster}')),
            ),
          ),
        ),
      ),
    ]));
  }

  Widget buildCard(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    final movieProvider = Provider.of<OmdbModelProvider>(context);

    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        color: Colors.grey.shade900.withOpacity(0.75),
        child: SizedBox(
          width: _width * 0.95,
          height: _height * 0.42,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isDismissed
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isDismissed = !isDismissed;
                                defaultPosition = 20;
                              });
                            },
                            child: const Icon(
                              Icons.arrow_upward,
                              color: Colors.deepPurpleAccent,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 20),
                          const CustomText(
                              content: 'Show Summary',
                              size: 12,
                              color: Colors.white),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                defaultPosition = -275;
                                isDismissed = !isDismissed;
                              });
                            },
                            child: const Icon(Icons.arrow_downward,
                                color: Colors.deepPurpleAccent, size: 24),
                          ),
                          const SizedBox(width: 20),
                          const CustomText(
                              content: 'Hide Summary',
                              size: 12,
                              color: Colors.white),
                        ],
                      ),
                Padding(
                  padding: const EdgeInsets.only(top: Spacers.spacer16),
                  child: Center(
                    child: CustomGradientText(
                        size: 18,
                        content: '${movieProvider.movie.title}',
                        primaryColor: Colors.deepPurpleAccent,
                        secondaryColor: Colors.lightBlueAccent),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomGradientText(
                    size: 16,
                    content: 'Year Released: ${movieProvider.movie.year}',
                    primaryColor: Colors.lightBlueAccent,
                    secondaryColor: Colors.deepPurpleAccent),
                CustomGradientText(
                    size: 14,
                    content: '${movieProvider.movie.plot}',
                    primaryColor: Colors.lightBlueAccent,
                    secondaryColor: Colors.deepPurpleAccent),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        Uri uri = Uri.parse(
                            'https://www.imdb.com/title/${movieProvider.movie.imdbID}/');

                        _launchUrl(uri);
                      },
                      child: Container(
                          width: 150,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.deepPurpleAccent.withOpacity(0.7),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0),
                                spreadRadius: 3,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 0), // changes position of shadow
                              ),
                            ],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16)),
                          ),
                          child: const Center(
                            child: CustomText(
                                content: 'open in webview',
                                size: 12,
                                color: Colors.white),
                          )),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: IconButton(
                          icon: Icon(Icons.thumb_up,
                              color: (isLiked) ? Colors.red : Colors.grey),
                          onPressed: () {
                            setState(() {
                              isLiked = !isLiked;
                            });
                          },
                        ))
                  ],
                )
              ],
            ),
          ),
        ));
  }

  void _launchUrl(url) async {
    if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
      throw 'Could not launch $url';
    }
  }

  @override
  void afterFirstLayout(BuildContext context) {
    setState(() {
      isDismissed = true;
      defaultPosition = widget._collapsedMovieCard;
      isDismissed = false;
    });
  }
}
