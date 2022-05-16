part of 'fetch_pokemon_bloc.dart';

enum FetchPokemonStatus {
  initial,
  failure,
  success,
}

class FetchPokemonState extends Equatable {
  const FetchPokemonState({
    this.status = FetchPokemonStatus.initial,
    this.pokemonList = const [],
    this.errorMessage = '',
  });

  final FetchPokemonStatus status;
  final List<PokemonDetailResponse> pokemonList;
  final String errorMessage;

  FetchPokemonState copyWith({
    FetchPokemonStatus? status,
    List<PokemonDetailResponse>? pokemonList,
    String? errorMessage,
  }) {
    return FetchPokemonState(
      status: status ?? this.status,
      pokemonList: pokemonList ?? this.pokemonList,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [status, pokemonList, errorMessage];

  @override
  String toString() =>
      'FetchPokemonState(status: $status, pokemonList: $pokemonList, errorMessage: $errorMessage)';
}
