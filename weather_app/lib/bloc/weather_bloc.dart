import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:weather_app/dataProvider/weatherDataProvider.dart';
import 'package:weather_app/model/model.dart';
import 'package:weather_app/repositaries/weatherRepo.dart';

import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository = WeatherRepository();

  WeatherBloc() : super(WeatherInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherLoading());
      try {
        final Either<Exception, WeatherModel> weatherEither =
            await weatherRepository.fetchWeatherData(
                event.latitude, event.longitude);
        weatherEither.fold(
          (exception) =>
              emit(WeatherError('Failed to fetch weather data: $exception')),
          (weatherData) => emit(WeatherLoaded(weatherData)),
        );
      } catch (e) {
        emit(WeatherError('Failed to fetch weather data: $e'));
      }
    });
  }
}
