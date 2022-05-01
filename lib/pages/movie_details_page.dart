import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:movie_demo/provider/omdb_model_provider.dart';
import 'package:provider/provider.dart';
import '../constants/api_.dart';
import '../constants/spacers.dart';
import '../model/movie_model.dart';
import '../widgets/gradient_text.dart';
import 'package:animate_icons/animate_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailsScreen extends StatefulWidget {
  final List<MovieModel> imdb_movie;
  final int index;
  const MovieDetailsScreen({required this.imdb_movie, required this.index})
      : super();

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreen();
}

class _MovieDetailsScreen extends State<MovieDetailsScreen> {
  late bool tap;
  bool isLiked = false;
  late AnimateIconController _animationController;
  String url = '${ApiConstants.OMDBAPIURL}';
  @override
  void initState() {
    super.initState();
    final movieProvider =
        Provider.of<OmdbModelProvider>(context, listen: false);
    movieProvider.getMovieData(widget.imdb_movie[widget.index].imdbID);
    setState(() {
      tap = false;
    });
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
                    ? NetworkImage(
                        'https://api.lorem.space/image/movieProvider?w=150&h=220')
                    : NetworkImage(
                        '${widget.imdb_movie[widget.index].poster}')),
          ),
        ),
      ),
      Positioned.fill(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            width: _width,
            height: _height,
            color: Colors.black.withOpacity(0.75),
          ),
        ),
      ),
      Positioned(
          top: 50,
          child: IconButton(
            color: Colors.deepPurpleAccent,
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )),
      AnimatedPositioned(
        curve: Curves.linearToEaseOut,
        left: 5,
        bottom: tap ? 10 : -259,
        duration: const Duration(milliseconds: 300),
        child: buildCard(context),
      ),
      Positioned(
        top: 70,
        left: 70,
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

    return GestureDetector(
      onTap: () {
        setState(() {
          tap = !tap;
        });
      },
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          color: Colors.grey.shade900.withOpacity(0.75),
          child: SizedBox(
            width: _width * 0.95,
            height: _height * 0.35,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  !tap
                      ? const Center(
                          child: Icon(
                            Icons.arrow_upward,
                            color: Colors.deepPurpleAccent,
                            size: 24,
                          ),
                        )
                      : const Center(
                          child: Icon(Icons.arrow_downward,
                              color: Colors.deepPurpleAccent, size: 24),
                        ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: Spacers.spacer16),
                      child: CustomGradientText(
                          size: 20,
                          content: '${movieProvider.movie.title}',
                          primaryColor: Colors.deepPurpleAccent,
                          secondaryColor: Colors.lightBlueAccent),
                    ),
                  ),
                  CustomGradientText(
                      size: 18,
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
                              child: Text('open in webview',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            )),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: isLiked
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.thumb_up,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isLiked = !isLiked;
                                    });
                                  },
                                )
                              : IconButton(
                                  icon: const Icon(
                                    Icons.thumb_down,
                                    color: Colors.grey,
                                  ),
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
          )),
    );
  }

  void _launchUrl(url) async {
    if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
      throw 'Could not launch $url';
    }
  }
}
