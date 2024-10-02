import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/country_model.dart';

class CountryViewModel extends ChangeNotifier {
  List<Country> countries = [];
  List<Country> filteredCountries = [];
  bool isLoading = true;
  String errorMessage = '';
  bool isAscending = true;

  Future<void> fetchCountries() async {
    const urls = [
      'https://restcountries.com/v3.1/translation/germany',
      'https://restcountries.com/v3.1/translation/india',
      'https://restcountries.com/v3.1/translation/israel',
      'https://restcountries.com/v3.1/translation/lanka',
      'https://restcountries.com/v3.1/translation/italy',
      'https://restcountries.com/v3.1/translation/china',
      'https://restcountries.com/v3.1/translation/korea',
    ];

    try {
      List<Country> fetchedCountries = [];
      for (String url in urls) {
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body);
          var country = Country.fromJson(jsonResponse[0]);
          fetchedCountries.add(country);
        }
      }
      countries = fetchedCountries;
      filteredCountries = fetchedCountries;
      isLoading = false;
    } catch (error) {
      isLoading = false;
      errorMessage = 'Failed to load data. Please try again.';
    }
    notifyListeners();
  }

  void sortCountriesAlphabetically() {
    filteredCountries.sort((a, b) => a.commonName.compareTo(b.commonName));
    notifyListeners();
  }
}
