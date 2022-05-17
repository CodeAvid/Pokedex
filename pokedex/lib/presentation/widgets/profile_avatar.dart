import 'package:flutter/material.dart';
import 'package:pokedex/shared/app_images.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    Key? key,
    this.radius = 20,
    required this.borderColor,
  }) : super(key: key);

  final double radius;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
      ),
      child: CircleAvatar(
        radius: radius,
        backgroundImage: const AssetImage(
          kProfilePicture,
        ),
      ),
    );
  }
}
