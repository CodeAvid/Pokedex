import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import 'package:pokedex/models/pokemon_detail_response.dart';
import 'package:pokedex/repository/pokemon_repository.dart';
part 'fetch_pokemon_event.dart';
part 'fetch_pokemon_state.dart';

class FetchPokemonBloc extends Bloc<FetchPokemonEvent, FetchPokemonState> {
  FetchPokemonBloc(
    this._repository,
  ) : super(const FetchPokemonState()) {
    on<FetchPokemon>(_onFetchPokemon);
  }

  final PokemonRepository _repository;

  _onFetchPokemon(
      FetchPokemonEvent event, Emitter<FetchPokemonState> emit) async {
    try {
      if (state.status == FetchPokemonStatus.initial) {
        final pokemonList = await _fetchPokemonList();
        emit(
          FetchPokemonState(
              status: FetchPokemonStatus.success, pokemonList: pokemonList),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: FetchPokemonStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<List<PokemonDetailResponse>> _fetchPokemonList() async {
    List<PokemonDetailResponse> pokemonList = <PokemonDetailResponse>[];
    try {
      pokemonList = await _repository.fetchPokemonList();
    } on DioError catch (e) {
      throw e.toString();
    }
    return pokemonList;
  }
}
