// extension to allow capitalising the first letter of every charachter
extension StringCasingExtension on String {
  String toCapitalize() =>
      isNotEmpty ? '${this[0].toUpperCase()}${substring(1)}' : '';
}
