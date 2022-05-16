import 'package:flutter/material.dart';
import 'package:pokedex/shared/app_color.dart';
import 'package:pokedex/shared/demensions.dart';

class DesignScaffold extends StatelessWidget {
  const DesignScaffold({
    Key? key,
    required this.body,
    this.backgroundColor = kMartinique,
    this.hPadding = 20,
    this.respectSafeArea = true,
  }) : super(key: key);

  final Widget body;
  final double hPadding;
  final bool respectSafeArea;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: hPadding,
            vertical: screenWidth(context) * 0.05,
          ),
          children: [
            body,
          ],
        ),
      ),
    );
  }
}
