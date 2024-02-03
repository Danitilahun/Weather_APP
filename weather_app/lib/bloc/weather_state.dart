import 'package:equatable/equatable.dart';
import 'package:weather_app/model/model.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherModel weatherData;

  const WeatherLoaded(this.weatherData);

  @override
  List<Object> get props => [weatherData];
}

class WeatherError extends WeatherState {
  final String message;

  const WeatherError(this.message);

  @override
  List<Object> get props => [message];
}
