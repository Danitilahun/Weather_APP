class WeatherModel {
  final City city;
  final String id;
  final String cod;
  final int message;
  final int cnt;
  final List<WeatherData> list;

  WeatherModel({
    required this.city,
    required this.id,
    required this.cod,
    required this.message,
    required this.cnt,
    required this.list,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      city: City.fromJson(json['city'] as Map<String, dynamic>),
      id: json['_id'],
      cod: json['cod'],
      message: json['message'],
      cnt: json['cnt'],
      list: List<WeatherData>.from(
          json['list'].map((x) => WeatherData.fromJson(x))),
    );
  }
}

class City {
  final Coord coord;
  final int id;
  final String name;
  final String country;
  final int population;
  final int timezone;
  final int sunrise;
  final int sunset;

  City({
    required this.coord,
    required this.id,
    required this.name,
    required this.country,
    required this.population,
    required this.timezone,
    required this.sunrise,
    required this.sunset,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      coord: Coord.fromJson(json['coord'] as Map<String, dynamic>),
      id: json['id'],
      name: json['name'],
      country: json['country'],
      population: json['population'],
      timezone: json['timezone'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
    );
  }
}

class Coord {
  final double lat;
  final double lon;

  Coord({
    required this.lat,
    required this.lon,
  });

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lat: json['lat'].toDouble(),
      lon: json['lon'].toDouble(),
    );
  }
}

class WeatherData {
  final Main main;
  final Clouds clouds;
  final Wind wind;
  final Sys sys;
  final int dt;
  final List<Weather> weather;
  final int visibility;
  final double pop;
  final String dtTxt;
  final String id;

  WeatherData({
    required this.main,
    required this.clouds,
    required this.wind,
    required this.sys,
    required this.dt,
    required this.weather,
    required this.visibility,
    required this.pop,
    required this.dtTxt,
    required this.id,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      main: Main.fromJson(json['main'] as Map<String, dynamic>),
      clouds: Clouds.fromJson(json['clouds'] as Map<String, dynamic>),
      wind: Wind.fromJson(json['wind'] as Map<String, dynamic>),
      sys: Sys.fromJson(json['sys'] as Map<String, dynamic>),
      dt: json['dt'],
      weather:
          List<Weather>.from(json['weather'].map((x) => Weather.fromJson(x))),
      visibility: json['visibility'],
      pop: json['pop'].toDouble(),
      dtTxt: json['dt_txt'],
      id: json['_id'],
    );
  }
}

class Main {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;

  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
  });

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: json['temp'].toDouble(),
      feelsLike: json['feels_like'].toDouble(),
      tempMin: json['temp_min'].toDouble(),
      tempMax: json['temp_max'].toDouble(),
      pressure: json['pressure'],
      humidity: json['humidity'],
    );
  }
}

class Clouds {
  final int all;

  Clouds({
    required this.all,
  });

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(
      all: json['all'],
    );
  }
}

class Wind {
  final double speed;
  final double deg;

  Wind({
    required this.speed,
    required this.deg,
  });

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: json['speed'].toDouble(),
      deg: json['deg'].toDouble(),
    );
  }
}

class Sys {
  final String pod;

  Sys({
    required this.pod,
  });

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(
      pod: json['pod'],
    );
  }
}

class Weather {
  final int id;
  final String main;
  final String description;
  final String icon;

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      id: json['id'],
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }
}
