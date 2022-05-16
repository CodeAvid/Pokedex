import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/shared/shared.dart';
import 'package:shimmer/shimmer.dart';
import '../presentation.dart';

class PokemonLoader extends StatelessWidget {
  const PokemonLoader({
    Key? key,
    required this.isLoading,
  }) : super(key: key);

  final bool isLoading;

  get baseColor => Colors.grey[300];
  get highlightColor => Colors.grey[100];

  @override
  Widget build(BuildContext context) {
    return DesignScaffold(
      body: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const RelativeYBox(height: 0.01),
                    isLoading
                        ? Shimmer.fromColors(
                            baseColor: baseColor,
                            highlightColor: highlightColor,
                            child: CircleAvatar(
                              radius: screenWidth(context) * 0.08,
                              backgroundColor: baseColor,
                            ),
                          )
                        : const SizedBox.shrink(),
                    const RelativeXBox(width: 0.03),
                    Column(
                      children: [
                        isLoading
                            ? Shimmer.fromColors(
                                baseColor: baseColor,
                                highlightColor: highlightColor,
                                child: Container(
                                  width: screenWidth(context) * 0.4,
                                  height: screenHeight(context) * 0.02,
                                  color: baseColor,
                                ),
                              )
                            : const SizedBox.shrink(),
                        const RelativeYBox(height: 0.01),
                        isLoading
                            ? Shimmer.fromColors(
                                baseColor: baseColor,
                                highlightColor: highlightColor,
                                child: Container(
                                  width: screenWidth(context) * 0.4,
                                  height: screenHeight(context) * 0.02,
                                  color: baseColor,
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ],
                ),
                isLoading
                    ? Shimmer.fromColors(
                        baseColor: baseColor,
                        highlightColor: highlightColor,
                        child: CircleAvatar(
                          radius: screenWidth(context) * 0.04,
                          backgroundColor: baseColor,
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            const RelativeYBox(height: 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                isLoading
                    ? Shimmer.fromColors(
                        baseColor: baseColor,
                        highlightColor: highlightColor,
                        child: Container(
                          width: screenWidth(context) * 0.4,
                          height: screenHeight(context) * 0.03,
                          color: baseColor,
                        ),
                      )
                    : const SizedBox.shrink(),
                isLoading
                    ? Shimmer.fromColors(
                        baseColor: baseColor,
                        highlightColor: highlightColor,
                        child: Container(
                          width: screenWidth(context) * 0.1,
                          height: screenHeight(context) * 0.05,
                          decoration: BoxDecoration(
                            color: baseColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            const RelativeYBox(height: 0.04),
            isLoading
                ? Shimmer.fromColors(
                    baseColor: baseColor,
                    highlightColor: highlightColor,
                    child: Container(
                      width: screenWidth(context) * 0.3,
                      height: screenHeight(context) * 0.03,
                      color: baseColor,
                    ),
                  )
                : const SizedBox.shrink(),
            const RelativeYBox(height: 0.02),
            SizedBox(
              height: screenHeight(context) * 0.025,
              child: isLoading
                  ? Shimmer.fromColors(
                      baseColor: baseColor,
                      highlightColor: highlightColor,
                      child: ListView.builder(
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Container(
                          margin: const EdgeInsets.only(right: 16),
                          height: 20,
                          width: screenWidth(context) * 0.3,
                          color: baseColor,
                        ),
                      ),
                    )
                  : const Text('Pokemon not found'),
            ),
            const RelativeYBox(height: 0.15),
            isLoading
                ? Shimmer.fromColors(
                    baseColor: baseColor,
                    highlightColor: highlightColor,
                    child: CarouselSlider.builder(
                      options: CarouselOptions(
                        height: screenHeight(context) * 0.34,
                        enlargeCenterPage: true,
                        viewportFraction: 0.7,
                        enableInfiniteScroll: false,
                        onPageChanged: (pageViewIndex, _) {},
                      ),
                      itemCount: 5,
                      itemBuilder: (context, index, _) => Container(
                        margin: const EdgeInsets.only(right: 20),
                        // height: double.,
                        width: screenWidth(context) * 0.6,

                        decoration: BoxDecoration(
                          color: baseColor,
                          borderRadius: BorderRadius.circular(padding * 2),
                        ),
                      ),
                    ),
                  )
                : const Text('Pokemon not found'),
          ],
        ),
      ),
    );
  }
}
