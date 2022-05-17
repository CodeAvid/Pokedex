import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon_detail_response.dart';
import 'package:pokedex/presentation/widgets/stats_item.dart';
import 'package:pokedex/shared/shared.dart';

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
