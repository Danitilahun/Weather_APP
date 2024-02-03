import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/model.dart';

class WeatherDataProvider {
  final String baseUrl = 'http://10.0.2.2:3000';

  Future<WeatherModel> fetchWeatherData(
      double latitude, double longitude) async {
    final String url =
        '$baseUrl/country/?latitude=$latitude&longitude=$longitude';

    final response = await http.get(Uri.parse(url));
    print("Here is the weather data:");
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      // print(json);
      WeatherModel weatherData = WeatherModel.fromJson(json);
      // print(weatherData);
      return weatherData;
    } else {
      throw Exception(
          'Failed to fetch weather data. Status code: ${response.statusCode}');
    }
  }
}
