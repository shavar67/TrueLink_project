import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/colors.dart';
import '../constants/spacers.dart';
import '../services/request_movies.dart';
import '../widgets/customText.dart';
import '../widgets/error.dart';
import '../widgets/gradient_text.dart';
import '../widgets/movie_grid_item.dart';
import '../widgets/shimmer.dart';

class MovieSearchHome extends StatefulWidget {
  const MovieSearchHome({Key? key}) : super(key: key);

  @override
  State<MovieSearchHome> createState() => _MovieSearchHomeState();
}

class _MovieSearchHomeState extends State<MovieSearchHome> {
  bool isSearching = false;
  late TextEditingController _editingController;
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  final GlobalKey _scaffoldKey = new GlobalKey();
  String searchText = '';
  bool isLoading = true;
  bool sort = false;
  @override
  void initState() {
    super.initState();
    isSearching = false;
    _editingController = TextEditingController();
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      drawer: Drawer(
          backgroundColor: KColors.scaffoldBgColor,
          child: ListView(padding: EdgeInsets.zero, children: [
            DrawerHeader(
              curve: Curves.easeInOut,
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: KColors.bgColorOffet,
                    radius: 60,
                    child: const CustomText(
                        content: 'Guest', size: 24, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: CustomText(content: 'Sort', size: 18, color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                      content: 'Ascending Order',
                      color: Colors.white,
                      size: 14),
                  Switch(
                      value: sort,
                      onChanged: (bool value) {
                        setState(
                          () {
                            sort = value;
                          },
                        );
                      })
                ],
              ),
            ),
          ])),
      appBar: AppBar(
          leading: Text(''),
          centerTitle: true,
          title: const CustomGradientText(
              content: 'Movie App',
              primaryColor: Colors.lightBlueAccent,
              secondaryColor: Colors.deepPurpleAccent,
              size: 18),
          bottom: PreferredSize(
              child: buildAppBar(), preferredSize: Size.fromHeight(40))),
      body: FutureBuilder(
          future: searchMovies(searchText),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                  padding: const EdgeInsets.symmetric(
                      vertical: Spacers.spacer16 * 2,
                      horizontal: Spacers.spacer8),
                  itemCount: snapshot.data.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: .95,
                  ),
                  itemBuilder: (context, index) {
                    return MovieGridItem(movies: snapshot.data, index: index);
                  });
            } else if (snapshot.hasError) {
              return isSearching
                  ? const ShimmerList()
                  : Scaffold(
                      body: KErrorWidget(
                          onPressed: () {},
                          message: 'Movies you search for will appear here'),
                    );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      actions: [
        isSearching
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    isSearching = false;
                    _editingController.clear();
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Center(
                      child: Text("Cancel",
                          style: TextStyle(color: Colors.blue, fontSize: 18))),
                ),
              )
            : Text("")
      ],
      elevation: 0,
      title: CupertinoTextField(
          decoration: BoxDecoration(
            color: KColors.scaffoldBgColor,
            borderRadius: const BorderRadius.all(Radius.circular(4)),
          ),
          placeholderStyle: const TextStyle(color: Colors.white),
          enableInteractiveSelection: true,
          maxLength: 20,
          style: const TextStyle(color: Colors.blue),
          onChanged: onChange,
          placeholder: "search movies and keywords",
          controller: _editingController,
          suffixMode: OverlayVisibilityMode.editing,
          onSubmitted: _submission,
          suffix: GestureDetector(
              onTap: () {
                setState(() {
                  _editingController.clear();
                });
              },
              child: const Icon(Icons.cancel, size: 18, color: Colors.blue)),
          prefixMode: OverlayVisibilityMode.notEditing,
          prefix: const Padding(
            padding: EdgeInsets.all(8),
            child: Icon(Icons.search, size: 20, color: Colors.white),
          )),
    );
  }

  void _submission(String text) async {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    setState(() {
      searchText = _editingController.text;
    });
  }

  void onChange(String query) {
    setState(() {
      isSearching = true;
      searchText = _editingController.text;
    });
  }
}
