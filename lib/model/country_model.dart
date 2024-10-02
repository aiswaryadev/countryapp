class Country {
  final String commonName;
  final String officialName;
  final String currencyCode;
  final String currencyName;
  final String flagUrl;
  final String region;
  
  Country({
    required this.commonName,
    required this.officialName,
    required this.currencyCode,
    required this.currencyName,
    required this.flagUrl,
    required this.region,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    var currencies = json['currencies'];
    var currencyCode = currencies.keys.first;
    var currency = currencies[currencyCode];

    return Country(
      commonName: json['name']['common'],
      officialName: json['name']['official'],
      currencyCode: currencyCode,
      currencyName: currency['name'],
      flagUrl: json['flags']['png'],
      region: json['region'],
    );
  }
}
