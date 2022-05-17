import 'package:flutter/material.dart';

class SearchIcon extends StatelessWidget {
  const SearchIcon({
    Key? key,
    required this.onTap,
    required this.backgroundColor,
  }) : super(key: key);
  final Function() onTap;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: const Icon(
          Icons.search,
          size: 24,
        ),
      ),
    );
  }
}
