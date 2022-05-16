// constant values
import 'package:flutter/material.dart';

const double padding = 10.0;
const double hPadding = 16.0;
const double vPadding = 20.0;

double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

double screenWidth(
  BuildContext context,
) =>
    MediaQuery.of(context).size.width;

class RelativeXBox extends StatelessWidget {
  const RelativeXBox({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth(context) * width,
    );
  }
}

class RelativeYBox extends StatelessWidget {
  const RelativeYBox({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight(context) * height,
    );
  }
}
