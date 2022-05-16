import 'package:pokedex/models/base_response.dart';

class PokemonResponse extends BaseResponse {
  PokemonResponse({
    status,
    message,
    this.count,
    this.next,
    this.previous,
    this.results,
  }) : super(message: message, status: status);

  late final int? count;
  late final String? next;
  late final String? previous;
  late final List<Results>? results;

  PokemonResponse.fromJson(Map<String, dynamic> json) {
    status = json['errorStatus'] ?? true;
    message = json['errorMessage'] ?? '';
    count = json['count'];
    next = json['next'];
    previous = json['next'];
    results =
        List.from(json['results']).map((e) => Results.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['errorStatus'] = status;
    data['errorMessage'] = message;
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    data['results'] = results!.map((e) => e.toJson()).toList();
    return data;
  }
}

class Results {
  Results({
    required this.name,
    required this.url,
  });
  late final String name;
  late final String url;

  Results.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    return data;
  }
}
