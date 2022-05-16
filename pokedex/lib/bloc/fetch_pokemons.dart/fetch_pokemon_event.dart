part of 'fetch_pokemon_bloc.dart';

abstract class FetchPokemonEvent extends Equatable {
  const FetchPokemonEvent();

  @override
  List<Object> get props => [];
}

class FetchPokemon extends FetchPokemonEvent {}
