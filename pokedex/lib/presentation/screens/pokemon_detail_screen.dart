import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/presentation/presentation.dart';
import 'package:pokedex/shared/shared.dart';
import '../../models/models.dart';

class PokemonDetailScreen extends StatefulWidget {
  const PokemonDetailScreen({
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
  State<PokemonDetailScreen> createState() => _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends State<PokemonDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return DesignScaffold(
      backgroundColor: widget.bgColor,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BackButton(
                color: widget.bodyColor,
              ),
              InkWell(
                onTap: () {},
                child: Icon(
                  Icons.star_border,
                  size: 30,
                  color: widget.bodyColor,
                ),
              ),
            ],
          ),
          const RelativeYBox(height: 0.02),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '${widget.pokemon.totalStats} CP',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w800,
                color: widget.titleColor,
              ),
            ),
          ),
          _buildPokemonImage(context),
          Text(
            (widget.pokemon.name ?? 'N/A').toCapitalize(),
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w700,
              color: widget.titleColor,
            ),
          ),
          _buildStatsCard(),
          const RelativeYBox(height: 0.03),
          _buildPokemonInfoCapsule(context),
          const RelativeYBox(height: 0.02),
          _buildPokemonInfoCapsule(context, 'Evolve'),
        ],
      ),
    );
  }

  Stack _buildPokemonInfoCapsule(BuildContext context,
      [String title = 'Power up',
      String energyLevel = '4,500',
      String fruit = '4']) {
    return Stack(
      children: [
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Container(
            width: screenWidth(context) * 0.7,
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth(context) * 0.06,
              vertical: screenHeight(context) * 0.014,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  energyLevel,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  fruit,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ),
        _buildPowerPill(context, title),
      ],
    );
  }

  Container _buildPowerPill(BuildContext context, [String title = 'power up']) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth(context) * 0.1,
        vertical: screenHeight(context) * 0.014,
      ),
      decoration: BoxDecoration(
        color: kFeijoa,
        borderRadius: BorderRadius.circular(padding * 2),
      ),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: widget.titleColor,
          fontSize: 15,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _buildStatsCard() {
    return Container(
      padding: const EdgeInsets.all(padding * 2),
      margin: const EdgeInsets.only(top: padding),
      decoration: BoxDecoration(
          color: widget.bodyColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(padding)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ReverseStatsItem(
                title: 'Weight'.toUpperCase(),
                value: '${widget.pokemon.weight} KG',
                titleColor: widget.titleColor,
                bodyColor: widget.bodyColor,
              ),
              _buildPokemonType(),
              ReverseStatsItem(
                title: 'height'.toUpperCase(),
                value: '${widget.pokemon.height} M',
                titleColor: widget.titleColor,
                bodyColor: widget.bodyColor,
              ),
            ],
          ),
          const RelativeYBox(height: 0.04),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ReverseStatsItem(
                title: 'StartDust'.toUpperCase(),
                value: '${widget.pokemon.weight}',
                titleColor: widget.titleColor,
                bodyColor: widget.bodyColor,
              ),
              ReverseStatsItem(
                title: '${widget.pokemon.name} candy'.toUpperCase(),
                value: '${widget.pokemon.height}',
                titleColor: widget.titleColor,
                bodyColor: widget.bodyColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Column _buildPokemonType() {
    return Column(
      children: [
        Row(
          children: const [
            CircleAvatar(
              radius: 10,
              backgroundColor: kSilverTree,
            ),
            RelativeXBox(width: 0.03),
            CircleAvatar(
              radius: 10,
              backgroundColor: kDullLavender,
            ),
          ],
        ),
        const RelativeYBox(height: 0.01),
        Text(
          "grass / poison".toUpperCase(),
          style: TextStyle(
            color: widget.bodyColor,
          ),
        ),
      ],
    );
  }

  SizedBox _buildPokemonImage(BuildContext context) {
    return SizedBox(
      height: screenHeight(context) * 0.3,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Positioned(
            top: -24,
            child: Hero(
              tag: widget.pokemon.imageUrl,
              child: Image(
                image: CachedNetworkImageProvider(
                  widget.pokemon.imageUrl,
                ),
                height: screenHeight(context) * 0.33,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
