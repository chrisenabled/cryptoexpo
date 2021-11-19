

import 'package:country_codes/country_codes.dart';

class CountryModel {

  final String? nameInNativeLanguage;

  final CountryDetails countryDetails;

  String get asset => 'icons/flags/png/${countryDetails.alpha2Code!.toLowerCase()}.png';

  const CountryModel({
    this.nameInNativeLanguage,
    required this.countryDetails,
  });
}