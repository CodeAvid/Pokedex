import 'package:flutter/material.dart';

import 'package:pokedex/presentation/presentation.dart';
import 'package:pokedex/shared/shared.dart';

class ErrorMessageScreen extends StatelessWidget {
  const ErrorMessageScreen({
    Key? key,
    required this.errorMessage,
  }) : super(key: key);
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return DesignScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const RelativeYBox(height: 0.2),
          Image.asset(
            kNoInternet,
            width: screenWidth(context) * 0.6,
          ),
          const RelativeYBox(height: 0.01),
          Text(
            errorMessage,
            style: TextStyle(
              color: Colors.white,
              fontSize: screenHeight(context) * 0.02,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
