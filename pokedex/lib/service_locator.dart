import 'package:get_it/get_it.dart';
import 'package:pokedex/network_layer/network_layer.dart';
import 'package:pokedex/repository/repository.dart';
import 'bloc/bloc.dart';

final sl = GetIt.instance;

void initialDependencies() {
  //! Register Network Provider
  sl.registerLazySingleton(() => NetworkProvider());

  //! Register Repositories
  sl.registerLazySingleton(() => PokemonRepository(sl<NetworkProvider>()));

  //! Register Blocs
  sl.registerLazySingleton(() => FetchPokemonBloc(sl<PokemonRepository>()));
}
