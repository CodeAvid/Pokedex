# Pokedex

A Pokemon Flutter app

Getting Started

```dart
pub get
flutter run
```
# Interface

![gif-pokedex](https://user-images.githubusercontent.com/51957344/168691252-9d296e89-7028-4741-82dd-8e2ab9c0446e.gif)


# Implementation
I implemented using the latest Flutter version null safety support it fetches Pokemons from https://pokeapi.co/docs/v2 and allows users save their favorite ones on their device in an efficient manner such that reading and writing isn't a hassle and it is readily available

it also has an intuitive UI that is designed to fit different screen sizes

# Libraries Used

**[Cached Network Image](https://pub.dev/packages/cached_network_image)**: This package helps with caching images on the devices of the user and saves them memory as they do not need to fetch if it has already been cached

**[Dio](https://pub.dev/packages/dio)**: This package helps with making HTTP requests and makes error handling for requests a breeze

**[Equatable](https://pub.dev/packages/equatable)**: Equatable overrides == and hashCode for you so you don't have to waste your time writing lots of boilerplate code.

**[get_it](https://pub.dev/packages/get_it)**: Get_it is a simple Service Locator for Dart and Flutter projects with some additional goodies highly inspired by Splat. It can be used instead of InheritedWidget or Provider to access objects e.g. from your UI.

**[Flutter Bloc](https://pub.dev/packages/flutter_bloc)**: Flutter Bloc is a State management package that helps build fast and reactive applications

**[Flutter Lints](https://pub.dev/packages/flutter_lints)**: Flutter Lints is a linting package that contains all the flutter-recommended best practices to ensure quality coding practices

**[Shimmer](https://pub.dev/packages/shimmer)**: Shimmer is a skeleton loader package that helps make Intuitive loaders

**[carousel_slider](https://pub.dev/packages/carousel_slider)**: A flutter carousel widget, that supports infinite scroll, and a custom child widget.

**[Palette Generator](https://pub.dev/packages/palette_generator)**: This package helps with extracting colors from images this package helped with determining the background color for Pokemons

# Do a critique:
The current implementation isn't perfect. How could it be improved?

Currently getting the Pokemon isn't quite as efficient as performing heavy operations(like getting the image's dominant colors), loops, and getting the individual Pokemon's details.

This could be resolved by individually fetching Pokemon's data and displaying available pieces of information while the remaining information is been fetched in the background so that the users don't wait too long to see the result and if a request fails it is easy to retry that particular request
