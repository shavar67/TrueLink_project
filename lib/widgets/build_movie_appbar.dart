import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/colors.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool isSearching = false;
  late TextEditingController _editingController;

  String searchText = '';
  bool isLoading = true;

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
      appBar: AppBar(
        centerTitle: false,
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
                            style:
                                TextStyle(color: Colors.blue, fontSize: 18))),
                  ),
                )
              : Text("")
        ],
        elevation: 0,
        title: CupertinoTextField(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            placeholderStyle: TextStyle(color: Colors.white),
            enableInteractiveSelection: true,
            maxLength: 20,
            style: const TextStyle(color: Colors.blue),
            onChanged: onChange,
            placeholder: "Search Movies",
            controller: _editingController,
            suffixMode: OverlayVisibilityMode.editing,
            onSubmitted: _submission,
            suffix: GestureDetector(
                onTap: () {
                  setState(() {
                    _editingController.clear();
                  });
                },
                child:
                    Icon(Icons.cancel, size: 18, color: KColors.bgColorOffet)),
            prefixMode: OverlayVisibilityMode.notEditing,
            prefix: const Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(Icons.search, size: 20, color: Colors.white),
            )),
      ),
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
