import 'package:dio/dio.dart';
import 'package:pokedex/models/pokemon_detail_response.dart';
import 'package:pokedex/models/pokemon_response.dart';
import 'package:pokedex/network_layer/network_provider.dart';
import 'package:pokedex/network_layer/endpoints.dart';

class PokemonRepository {
  final NetworkProvider _networkProvider;

  PokemonRepository(this._networkProvider);

  Future<List<PokemonDetailResponse>> fetchPokemonList([int limit = 10]) async {
    List<PokemonDetailResponse> pokemonDetailList = <PokemonDetailResponse>[];
    try {
      const path = '$kBaseUrl/pokemon';
      var response = await _networkProvider.call(
        path: path,
        method: RequestMethod.get,
        queryParams: {
          'limit': '$limit',
        },
      );
      if (response?.statusCode == 200) {
        PokemonResponse? pokemonResponse =
            PokemonResponse.fromJson(response?.data);
        for (var result in pokemonResponse.results!) {
          var pokemon = await fetchPokemonDetail(result.url);
          pokemonDetailList.add(pokemon);
        }
      }
    } catch (e) {
      throw e.toString();
    }
    return pokemonDetailList;
  }

  Future<PokemonDetailResponse> fetchPokemonDetail(String url) async {
    late PokemonDetailResponse pokemonResponse;
    try {
      var response =
          await _networkProvider.call(path: url, method: RequestMethod.get);
      if (response?.statusCode == 200) {
        pokemonResponse = PokemonDetailResponse.fromJson(response?.data);
      }
    } on DioError catch (e) {
      throw e.toString();
    }
    return pokemonResponse;
  }
}
