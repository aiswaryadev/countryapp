import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/country_viewmodel.dart';

class CountryView extends StatelessWidget {
  const CountryView({super.key});

  @override
  Widget build(BuildContext context) {
    final countryViewModel = Provider.of<CountryViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Country App'),
        actions: [
          DropdownButton<String>(
            value: 'Alphabetical',
            onChanged: (String? newValue) {
              countryViewModel.sortCountriesAlphabetically();
            },
            items: <String>['Alphabetical']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
      body: countryViewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : countryViewModel.errorMessage.isNotEmpty
              ? Center(child: Text(countryViewModel.errorMessage))
              : ListView.builder(
                  itemCount: countryViewModel.filteredCountries.length,
                  itemBuilder: (context, index) {
                    final country = countryViewModel.filteredCountries[index];
                    return ListTile(
                      leading: Image.network(country.flagUrl),
                      title: Text(country.commonName),
                      subtitle: Text(
                        'Official Name:${country.officialName}\nCurrency: ${country.currencyCode} (${country.currencyName})\nRegion: ${country.region}',
                      ),
                      isThreeLine: true,
                    );
                  },
                ),
    );
  }
}
