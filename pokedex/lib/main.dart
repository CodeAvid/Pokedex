import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/simple_bloc_observer.dart';
import 'app.dart';
import 'service_locator.dart' as sl;

void main() {
  sl.initialDependencies();
  BlocOverrides.runZoned(
    () => runApp(const App()),
    blocObserver: SimpleBlocObserver(),
  );
}
