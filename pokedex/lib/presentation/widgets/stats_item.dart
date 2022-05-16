import 'package:flutter/widgets.dart';
import 'package:pokedex/shared/demensions.dart';

class StatsItem extends StatelessWidget {
  const StatsItem({
    Key? key,
    required this.title,
    required this.value,
    required this.titleColor,
    required this.bodyColor,
  }) : super(key: key);
  final String title;
  final String value;
  final Color? titleColor;
  final Color? bodyColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: titleColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        const RelativeYBox(height: 0.005),
        Text(
          value,
          style: TextStyle(
            color: bodyColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class ReverseStatsItem extends StatelessWidget {
  const ReverseStatsItem({
    Key? key,
    required this.title,
    required this.value,
    required this.titleColor,
    required this.bodyColor,
  }) : super(key: key);
  final String title;
  final String value;
  final Color? titleColor;
  final Color? bodyColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: titleColor,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        const RelativeYBox(height: 0.005),
        Text(
          title,
          style: TextStyle(
            color: bodyColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
