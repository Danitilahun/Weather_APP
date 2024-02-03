function mapResponseToSchema(response) {
  const WeatherData = require("./weatherDataSchema");

  const weatherData = new WeatherData({
    cod: response.cod,
    message: response.message,
    cnt: response.cnt,
    list: response.list.map((item) => ({
      dt: item.dt,
      main: {
        temp: item.main.temp,
        feels_like: item.main.feels_like,
        temp_min: item.main.temp_min,
        temp_max: item.main.temp_max,
        pressure: item.main.pressure,
        sea_level: item.main.sea_level,
        grnd_level: item.main.grnd_level,
        humidity: item.main.humidity,
        temp_kf: item.main.temp_kf,
      },
      weather: item.weather.map((weatherItem) => ({
        id: weatherItem.id,
        main: weatherItem.main,
        description: weatherItem.description,
        icon: weatherItem.icon,
      })),
      clouds: {
        all: item.clouds.all,
      },
      wind: {
        speed: item.wind.speed,
        deg: item.wind.deg,
        gust: item.wind.gust,
      },
      visibility: item.visibility,
      pop: item.pop,
      sys: {
        pod: item.sys.pod,
      },
      dt_txt: item.dt_txt,
    })),
    city: {
      id: response.city.id,
      name: response.city.name,
      coord: {
        lat: response.city.coord.lat,
        lon: response.city.coord.lon,
      },
      country: response.city.country,
      population: response.city.population,
      timezone: response.city.timezone,
      sunrise: response.city.sunrise,
      sunset: response.city.sunset,
    },
  });

  return weatherData;
}

module.exports = mapResponseToSchema;
