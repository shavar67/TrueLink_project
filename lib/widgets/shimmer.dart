import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../constants/spacers.dart';
import '../model/movie_model.dart';

class ShimmerList extends StatefulWidget {
  const ShimmerList({
    Key? key,
  }) : super(key: key);

  @override
  State<ShimmerList> createState() => _ShimmerListState();
}

class _ShimmerListState extends State<ShimmerList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade400,
                  highlightColor: Colors.grey.shade200,
                  child: GridView.builder(
                      padding: const EdgeInsets.symmetric(
                          vertical: Spacers.spacer16 * 2,
                          horizontal: Spacers.spacer8),
                      itemCount: 8,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: .95,
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                            decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(
                              Radius.circular(Spacers.spacer8)),
                        ));
                      })),
            ),
          ],
        ),
      ),
    );
  }
}

      // body: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: const [
      //     Center(
      //       child: CustomGradientText(
      //           content: 'Movies you search for will populate here.',
      //           primaryColor: Colors.lightBlueAccent,
      //           secondaryColor: Colors.deepPurpleAccent,
      //           size: 18),
      //     )
      //   ],
      // ),
