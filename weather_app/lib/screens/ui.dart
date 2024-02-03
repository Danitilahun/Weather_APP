import 'package:flutter/material.dart';
import 'package:weather_app/datas/capitals.dart' as capitals;
import 'package:weather_app/datas/flag.dart' as flags;
import 'package:weather_app/datas/ALL_Countries.dart' as coordinates;
import 'package:weather_app/screens/detail.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CityListScreen extends StatefulWidget {
  @override
  _CityListScreenState createState() => _CityListScreenState();
}

class _CityListScreenState extends State<CityListScreen> {
  List<String> filteredCountries = capitals.countryCapitals.keys.toList();

  void filterCountries(String query) {
    setState(() {
      if (query.isNotEmpty) {
        filteredCountries = capitals.countryCapitals.keys
            .where((country) =>
                country.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else {
        filteredCountries = capitals.countryCapitals.keys.toList();
      }
    });
  }

  void navigateToCountryDetails(BuildContext context, String country,
      String capital, double? latitude, double? longitude, String flagUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CountryDetailsScreen(
          country: country,
          capital: capital,
          latitude: latitude,
          longitude: longitude,
          flagUrl: flagUrl,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('City List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              onChanged: filterCountries,
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredCountries.length,
              itemBuilder: (context, index) {
                final country = filteredCountries[index];
                final capital = capitals.countryCapitals[country];
                final countryCoordinate =
                    coordinates.countryCoordinates[country];
                final countryCode = flags.countryCodes[country];
                final flagUrl =
                    'https://media-3.api-sports.io/flags/${countryCode!.toLowerCase()}.svg';
                print(flagUrl);
                return ListTile(
                  leading: CircleAvatar(
                    child: SvgPicture.network(
                      flagUrl ?? '',
                      placeholderBuilder: (context) =>
                          CircularProgressIndicator(),
                      // errorBuilder: (context, error, stackTrace) =>
                      //     Icon(Icons.error),
                    ),
                  ),
                  title: Text(country ?? ''),
                  onTap: () {
                    final latitude = countryCoordinate?[0];
                    final longitude = countryCoordinate?[1];
                    navigateToCountryDetails(context, country ?? '',
                        capital ?? '', latitude, longitude, flagUrl);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
