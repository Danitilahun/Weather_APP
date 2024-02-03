import 'package:weather_app/dataProvider/weatherDataProvider.dart';
import 'package:weather_app/model/model.dart';
import 'package:dartz/dartz.dart';

class WeatherRepository {
  final WeatherDataProvider dataProvider = WeatherDataProvider();

  WeatherRepository();

  Future<Either<Exception, WeatherModel>> fetchWeatherData(
      double latitude, double longitude) async {
    try {
      final weatherData =
          await dataProvider.fetchWeatherData(latitude, longitude);
      return Right(weatherData);
    } catch (e) {
      return Left(Exception('Failed to fetch weather data: $e'));
    }
  }
}
