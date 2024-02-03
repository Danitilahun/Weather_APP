const mongoose = require('mongoose');

const weatherSchema = new mongoose.Schema({
  cod: String,
  message: Number,
  cnt: Number,
  list: [{
    dt: Number,
    main: {
      temp: Number,
      feels_like: Number,
      temp_min: Number,
      temp_max: Number,
      pressure: Number,
      sea_level: Number,
      grnd_level: Number,
      humidity: Number,
      temp_kf: Number
    },
    weather: [{
      id: Number,
      main: String,
      description: String,
      icon: String
    }],
    clouds: {
      all: Number
    },
    wind: {
      speed: Number,
      deg: Number,
      gust: Number
    },
    visibility: Number,
    pop: Number,
    sys: {
      pod: String
    },
    dt_txt: String
  }],
  city: {
    id: Number,
    name: String,
    coord: {
      lat: Number,
      lon: Number
    },
    country: String,
    population: Number,
    timezone: Number,
    sunrise: Number,
    sunset: Number
  }
});

const WeatherData = mongoose.model('WeatherData', weatherSchema);

module.exports = WeatherData;
