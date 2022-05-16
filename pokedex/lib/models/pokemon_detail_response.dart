import 'package:pokedex/models/base_response.dart';

class PokemonDetailResponse extends BaseResponse {
  PokemonDetailResponse({
    this.height,
    this.id,
    this.name,
    this.order,
    this.sprites,
    this.stats,
    this.weight,
    this.types,
    status,
    message,
  }) : super(message: message, status: status);

  late final int? height;
  late final int? id;
  late final String? name;
  late final int? order;
  late final Sprites? sprites;
  late final List<Stats>? stats;
  late final List<Types>? types;
  late final int? weight;
  String get imageUrl => sprites?.other?.home?.frontDefault ?? '';
  int get totalStats =>
      stats?.map((e) => e.baseStat).toList().reduce(
            (sum, element) => (sum ?? 0) + (element ?? 0),
          ) ??
      0;

  PokemonDetailResponse.fromJson(Map<String, dynamic> json) {
    status = json['errorStatus'] ?? true;
    message = json['errorMessage'] ?? '';
    height = json['height'];
    id = json['id'];
    name = json['name'];
    order = json['order'];
    sprites = Sprites.fromJson(Map<String, dynamic>.from(json['sprites']));
    stats = List.from(json['stats'])
        .map((e) => Stats.fromJson(Map<String, dynamic>.from(e)))
        .toList();
    types = List.from(json['types'])
        .map((e) => Types.fromJson(Map<String, dynamic>.from(e)))
        .toList();
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['errorStatus'] = status;
    data['errorMessage'] = message;
    data['height'] = height;
    data['id'] = id;
    data['name'] = name;
    data['order'] = order;
    data['sprites'] = sprites!.toJson();
    data['stats'] = stats!.map((e) => e.toJson()).toList();
    data['types'] = types!.map((e) => e.toJson()).toList();
    data['weight'] = weight;
    return data;
  }
}

class Sprites {
  Sprites({
    required this.other,
  });
  late final Other? other;

  Sprites.fromJson(Map<String, dynamic> json) {
    other = Other.fromJson(Map<String, dynamic>.from(json['other']));
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['other'] = other?.toJson();
    return _data;
  }
}

class Other {
  Other({
    required this.home,
  });
  late final Home? home;

  Other.fromJson(Map<String, dynamic> json) {
    home = Home.fromJson(Map<String, dynamic>.from(json['home']));
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['official-artwork'] = home?.toJson();
    return data;
  }
}

class Home {
  Home({
    required this.frontDefault,
  });
  late final String? frontDefault;

  Home.fromJson(Map<String, dynamic> json) {
    frontDefault = json['front_default'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['front_default'] = frontDefault;
    return data;
  }
}

class Stats {
  Stats({
    required this.baseStat,
    required this.effort,
    required this.stat,
  });
  late final int? baseStat;
  late final int? effort;
  late final Stat? stat;

  Stats.fromJson(Map<String, dynamic> json) {
    baseStat = json['base_stat'];
    effort = json['effort'];
    stat = Stat.fromJson(Map<String, dynamic>.from(json['stat']));
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['base_stat'] = baseStat;
    _data['effort'] = effort;
    _data['stat'] = stat?.toJson();
    return _data;
  }
}

class Stat {
  Stat({
    required this.name,
    required this.url,
  });
  late final String? name;
  late final String? url;

  Stat.fromJson(Map<String, dynamic> json) {
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

class Types {
  Types({
    required this.slot,
    required this.type,
  });
  late final int? slot;
  late final Type? type;

  Types.fromJson(Map<String, dynamic> json) {
    slot = json['slot'];
    type = Type.fromJson(Map<String, dynamic>.from(json['type']));
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['slot'] = slot;
    _data['type'] = type?.toJson();
    return _data;
  }
}

class Type {
  Type({
    required this.name,
    required this.url,
  });

  late final String? name;
  late final String? url;

  Type.fromJson(Map<String, dynamic> json) {
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
