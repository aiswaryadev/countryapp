import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view/country_view.dart';
import 'viewmodel/country_viewmodel.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CountryViewModel()..fetchCountries(),
      child: MaterialApp(
        title: 'Country App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const CountryView(),
      ),
    );
  }
}