import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/bloc/weather_event.dart';
import 'package:weather_app/bloc/weather_state.dart';
import 'package:weather_app/model/model.dart';

class CountryDetailsScreen extends StatefulWidget {
  final String country;
  final String capital;
  final double? latitude;
  final double? longitude;
  final String flagUrl;

  const CountryDetailsScreen({
    required this.country,
    required this.capital,
    required this.latitude,
    required this.longitude,
    required this.flagUrl,
  });

  @override
  State<CountryDetailsScreen> createState() => _CountryDetailsScreenState();
}

class _CountryDetailsScreenState extends State<CountryDetailsScreen> {
  void initState() {
    super.initState();
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    weatherBloc.add(FetchWeather(widget.latitude!, widget.longitude!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Country Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CountryHeader(
            capital: widget.capital,
            country: widget.country,
            flagUrl: widget.flagUrl,
          ),
          SizedBox(height: 16.0),
          Expanded(
            child: DefaultTabController(
              length: 7,
              child: Column(
                children: [
                  Container(
                    constraints: BoxConstraints.expand(height: 50.0),
                    child: TabBar(
                      isScrollable: true,
                      labelColor: Colors
                          .black, // Set the text color of the selected tab
                      unselectedLabelColor:
                          Colors.grey, // Set the text color of unselected tabs
                      labelStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight
                              .bold), // Set the style of the selected tab text
                      unselectedLabelStyle: TextStyle(
                          fontSize: 16), // Set the style of unselected tab text
                      tabs: [
                        Tab(text: 'Sunday'),
                        Tab(text: 'Monday'),
                        Tab(text: 'Tuesday'),
                        Tab(text: 'Wednesday'),
                        Tab(text: 'Thursday'),
                        Tab(text: 'Friday'),
                        Tab(text: 'Saturday'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        buildTabContent('Sunday'),
                        buildTabContent('Monday'),
                        buildTabContent('Tuesday'),
                        buildTabContent('Wednesday'),
                        buildTabContent('Thursday'),
                        buildTabContent('Friday'),
                        buildTabContent('Saturday'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTabContent(String day) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is WeatherLoaded) {
          final weatherData = state.weatherData;
          final filteredData = weatherData.list
              .where((item) =>
                  getFormattedDate(item.dtTxt) ==
                  day) // Filter data for the selected day
              .toList();
          return ListView.builder(
            itemCount: filteredData.length,
            itemBuilder: (context, index) {
              final weather = filteredData[index];
              return buildWeatherTabContent(weather);
            },
          );
        } else if (state is WeatherError) {
          return Text('Failed to fetch weather data: ${state.message}');
        } else {
          return Text('No weather data available');
        }
      },
    );
  }

  Widget buildWeatherTabContent(WeatherData weather) {
    final dateTime = getFormattedDateTime(weather.dtTxt);
    final temperature = weather.main.temp.toInt();
    final maxTemperature = weather.main.tempMax.toInt();
    final minTemperature = weather.main.tempMin.toInt();
    final pressure = weather.main.pressure;
    final humidity = weather.main.humidity;
    final windSpeed = weather.wind.speed;
    final weatherMain = weather.weather[0].main;
    final weatherDescription = weather.weather[0].description;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dateTime,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                'Temperature: $temperature° Kelvin',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Max Temperature: $maxTemperature Kelvin',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Min Temperature: $minTemperature° Kelvin',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Pressure: $pressure hPa',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Humidity: $humidity%',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Wind Speed: $windSpeed m/s',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Weather: $weatherMain',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'weatherDescription: $weatherDescription',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getFormattedDate(String dtTxt) {
    final dateTime = DateTime.parse(dtTxt);
    final formatter = DateFormat('EEEE');
    return formatter.format(dateTime);
  }

  String getFormattedDateTime(String dtTxt) {
    final dateTime = DateTime.parse(dtTxt);
    final formatter = DateFormat('EEEE, MMMM d, y h:mm a');
    return formatter.format(dateTime);
  }
}

class CountryHeader extends StatelessWidget {
  final String capital;
  final String country;
  final String flagUrl;

  const CountryHeader({
    required this.capital,
    required this.country,
    required this.flagUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 50,
            child: SvgPicture.network(
              flagUrl ?? '',
              placeholderBuilder: (context) => CircularProgressIndicator(),
              // errorBuilder: (context, error, stackTrace) =>
              //     Icon(Icons.error),
            ),
          ),
          SizedBox(width: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                capital,
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 15.0),
              Text(
                country,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
