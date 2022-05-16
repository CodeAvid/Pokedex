import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:pokedex/models/models.dart';
import 'package:pokedex/presentation/screens/error_message_screen.dart';
import 'package:pokedex/presentation/screens/pokemon_detail_screen.dart';
import 'package:pokedex/service_locator.dart';
import '../../bloc/bloc.dart';
import '../../shared/shared.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late FetchPokemonBloc _fetchPokemonBloc;
  int _currentShownPokemonIndex = 0;

  final List<String> _pokemonCategories = <String>[
    'All',
    'Pokemon',
    'Moves',
    'Items',
    'Location',
    'Ability',
    'Type Charts',
  ];

  late List<String> _pokemonImages;
  late List<PaletteColor> _bgColors;

  @override
  void initState() {
    //initial flutter bloc
    _fetchPokemonBloc = FetchPokemonBloc(sl());
    _fetchPokemonBloc.add(FetchPokemon());
    _pokemonImages = [];
    _bgColors = [];
    super.initState();
  }

  @override
  void dispose() {
    //dispose flutter bloc
    _fetchPokemonBloc.close();
    super.dispose();
  }

  _updatePalette(List<String> pokemonImage) async {
    for (String image in pokemonImage) {
      PaletteGenerator palette = await PaletteGenerator.fromImageProvider(
        CachedNetworkImageProvider(image),
        size: const Size(200, 100),
      );

      palette.darkMutedColor != null
          ? _bgColors.add(
              palette.darkVibrantColor ?? PaletteColor(kMartinique, 3),
            )
          : _bgColors.add(
              PaletteColor(kMartinique, 3),
            );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FetchPokemonBloc, FetchPokemonState>(
      bloc: _fetchPokemonBloc,
      listener: (context, state) {
        if (state.status == FetchPokemonStatus.success &&
            state.pokemonList.isNotEmpty) {
          _handleBackgroundChange(state.pokemonList);
        }
      },
      builder: (context, state) {
        switch (state.status) {
          case FetchPokemonStatus.failure:
            return ErrorMessageScreen(
              errorMessage: state.errorMessage,
            );
          case FetchPokemonStatus.success:
            if (state.pokemonList.isEmpty) {
              return const Center(child: Text('No Pokemon Found'));
            } else {
              return _buildPokemonList(state.pokemonList);
            }
          default:
            return PokemonLoader(
              isLoading: state.status == FetchPokemonStatus.initial,
            );
        }
      },
    );
  }

  DesignScaffold _buildPokemonList(List<PokemonDetailResponse> pokemonList) {
    kNavBarBackgroundColor.value = _bgColors.isNotEmpty
        ? _bgColors[_currentShownPokemonIndex].color
        : kMartinique;
    return DesignScaffold(
      backgroundColor: _bgColors.isNotEmpty
          ? _bgColors[_currentShownPokemonIndex].color
          : kMartinique,
      body: Column(
        children: [
          _buildHeaderRow(),
          _buildTitleBar(),
          _buildCategory(_pokemonCategories),
          _buildPokemonListCarousel(pokemonList),
        ],
      ),
    );
  }

  Row _buildHeaderRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
          ProfileAvatar(
            borderColor: _bgColors.isNotEmpty
                ? _bgColors[_currentShownPokemonIndex].bodyTextColor
                : kMartinique,
          ),
          const RelativeXBox(width: 0.02),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Benjamin',
                style: TextStyle(
                  color: _bgColors.isNotEmpty
                      ? _bgColors[_currentShownPokemonIndex].bodyTextColor
                      : kMartinique,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const RelativeYBox(height: 0.002),
              Text(
                'lvl 04',
                style: TextStyle(
                  color: _bgColors.isNotEmpty
                      ? _bgColors[_currentShownPokemonIndex].titleTextColor
                      : kMartinique,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ]),
        GestureDetector(
          onTap: () {},
          child: Icon(
            Icons.location_searching_outlined,
            color: _bgColors.isNotEmpty
                ? _bgColors[_currentShownPokemonIndex].bodyTextColor
                : kMartinique,
          ),
        )
      ],
    );
  }

  Widget _buildTitleBar() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenHeight(context) * 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Pokedex',
            style: TextStyle(
              color: _bgColors.isNotEmpty
                  ? _bgColors[_currentShownPokemonIndex].bodyTextColor
                  : kMartinique,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          SearchIcon(
            onTap: () {},
            backgroundColor: _bgColors.isNotEmpty
                ? _bgColors[_currentShownPokemonIndex].bodyTextColor
                : kMartinique,
          )
        ],
      ),
    );
  }

  Widget _buildCategory(List<String> items, [int selectedIndex = 0]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Near You',
          style: TextStyle(
            color: _bgColors.isNotEmpty
                ? _bgColors[_currentShownPokemonIndex].titleTextColor
                : kMartinique,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: screenHeight(context) * 0.08,
          child: ListView(
            padding:
                EdgeInsets.symmetric(vertical: screenHeight(context) * 0.03),
            scrollDirection: Axis.horizontal,
            children: List.generate(
              items.length,
              (index) => Padding(
                padding: EdgeInsets.only(right: screenWidth(context) * 0.06),
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    items[index],
                    style: TextStyle(
                      color: items[selectedIndex] == items[index]
                          ? _bgColors.isNotEmpty
                              ? _bgColors[_currentShownPokemonIndex]
                                  .bodyTextColor
                              : kMartinique
                          : _bgColors.isNotEmpty
                              ? _bgColors[_currentShownPokemonIndex]
                                  .titleTextColor
                              : kMartinique,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  _handleBackgroundChange(List<PokemonDetailResponse> pokemonList) {
    _pokemonImages = pokemonList.map((e) => e.imageUrl).toList();
    _updatePalette(_pokemonImages);
  }

  Widget _buildPokemonListCarousel(List<PokemonDetailResponse> pokemonList) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        height: screenHeight(context) * 0.55,
        enlargeCenterPage: true,
        viewportFraction: 0.7,
        enableInfiniteScroll: false,
        onPageChanged: (pageViewIndex, _) {
          setState(() {
            _currentShownPokemonIndex = pageViewIndex;
          });
        },
      ),
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) {
                  return PokemonDetailScreen(
                    pokemon: pokemonList[itemIndex],
                    bgColor: _bgColors.isNotEmpty
                        ? _bgColors[_currentShownPokemonIndex].color
                        : kMartinique,
                    titleColor: _bgColors.isNotEmpty
                        ? _bgColors[_currentShownPokemonIndex].bodyTextColor
                        : kMartinique,
                    bodyColor: _bgColors.isNotEmpty
                        ? _bgColors[_currentShownPokemonIndex].titleTextColor
                        : kMartinique,
                  );
                },
              ),
            );
          },
          child: Stack(
            children: [
              Positioned(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: screenHeight(context) * 0.1),
                  child: PokemonListItem(
                    pokemon: pokemonList[itemIndex],
                    titleColor: _bgColors.isNotEmpty
                        ? _bgColors[_currentShownPokemonIndex].bodyTextColor
                        : kMartinique,
                    bgColor: _bgColors.isNotEmpty
                        ? _bgColors[_currentShownPokemonIndex]
                            .bodyTextColor
                            .withOpacity(0.1)
                        : kMartinique,
                    bodyColor: _bgColors.isNotEmpty
                        ? _bgColors[_currentShownPokemonIndex].titleTextColor
                        : kMartinique,
                  ),
                ),
              ),
              _buildPokemonImage(context, pokemonList, itemIndex),
              _buildMeterButton(context),
            ],
          ),
        );
      },
      itemCount: pokemonList.length,
    );
  }

  Positioned _buildPokemonImage(BuildContext context,
      List<PokemonDetailResponse> pokemonList, int itemIndex) {
    return Positioned(
      top: -screenHeight(context) * 0.15,
      child: Hero(
        tag: pokemonList[itemIndex].imageUrl,
        child: CachedNetworkImage(
          imageUrl: pokemonList[itemIndex].imageUrl,
          height: screenHeight(context) * 0.5,
          width: screenWidth(context) * 0.5,
          fit: BoxFit.contain,
          placeholder: (context, url) => const CircularProgressIndicator(),
        ),
      ),
    );
  }

  Positioned _buildMeterButton(BuildContext context) {
    return Positioned(
      bottom: screenHeight(context) * 0.08,
      left: screenWidth(context) * 0.14,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: screenHeight(context) * 0.02,
          vertical: screenWidth(context) * 0.02,
        ),
        decoration: BoxDecoration(
          color: _bgColors.isNotEmpty
              ? _bgColors[_currentShownPokemonIndex].titleTextColor
              : kMartinique,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          '< 250 mtrs',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: _bgColors.isNotEmpty
                ? _bgColors[_currentShownPokemonIndex].bodyTextColor
                : kMartinique,
          ),
        ),
      ),
    );
  }
}

class PokemonListItem extends StatelessWidget {
  const PokemonListItem({
    Key? key,
    required this.pokemon,
    required this.bgColor,
    required this.titleColor,
    required this.bodyColor,
  }) : super(key: key);

  final PokemonDetailResponse pokemon;
  final Color bgColor;
  final Color titleColor;
  final Color bodyColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth(context) * 0.6,
      padding: EdgeInsets.only(top: screenWidth(context) * 0.16),
      margin: EdgeInsets.only(right: screenWidth(context) * 0.08),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(padding * 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildPokemonTitleRow(),
          const RelativeYBox(height: 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StatsItem(
                title: 'Height',
                value: pokemon.height.toString(),
                titleColor: titleColor,
                bodyColor: bodyColor,
              ),
              const RelativeXBox(width: 0.08),
              StatsItem(
                title: 'Weight',
                value: '${pokemon.weight.toString()} Ibs',
                titleColor: titleColor,
                bodyColor: bodyColor,
              ),
            ],
          ),
          const RelativeYBox(height: 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StatsItem(
                title: 'Order',
                value: pokemon.order.toString(),
                titleColor: titleColor,
                bodyColor: bodyColor,
              ),
              const RelativeXBox(width: 0.04),
              StatsItem(
                title: 'Attack',
                value: '${pokemon.stats?.length.toString()}',
                titleColor: titleColor,
                bodyColor: bodyColor,
              ),
              const RelativeXBox(width: 0.04),
              StatsItem(
                title: 'Defense',
                value: '${pokemon.types?.length.toString()}',
                titleColor: titleColor,
                bodyColor: bodyColor,
              ),
            ],
          )
        ],
      ),
    );
  }

  Row _buildPokemonTitleRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          pokemon.name ?? 'N/A',
          style: TextStyle(
            color: titleColor,
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        const RelativeXBox(width: 0.03),
        CircleAvatar(
          radius: 12,
          backgroundColor: kSilverTree,
          child: Image.asset(
            kLeaf,
            color: kPlantation,
            height: 12,
            width: 12,
          ),
        ),
        const RelativeXBox(width: 0.02),
        CircleAvatar(
          radius: 12,
          backgroundColor: kDullLavender,
          child: Image.asset(
            kAlien,
            color: kMartinique,
            height: 16,
            width: 16,
          ),
        )
      ],
    );
  }
}

class SearchIcon extends StatelessWidget {
  const SearchIcon({
    Key? key,
    required this.onTap,
    required this.backgroundColor,
  }) : super(key: key);
  final Function() onTap;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: const Icon(
          Icons.search,
          size: 24,
        ),
      ),
    );
  }
}

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    Key? key,
    this.radius = 20,
    required this.borderColor,
  }) : super(key: key);

  final double radius;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
      ),
      child: CircleAvatar(
        radius: radius,
        backgroundImage: const AssetImage(
          kProfilePicture,
        ),
      ),
    );
  }
}
