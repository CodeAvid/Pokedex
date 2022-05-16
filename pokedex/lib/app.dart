import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon_detail_response.dart';
import 'package:pokedex/presentation/widgets/pokemon_loader.dart';
import 'presentation/screens/screens.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokedex',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BottomNavBarScreen(),
    );
  }
}
