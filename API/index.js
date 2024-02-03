const express = require("express");
const app = express();
require("dotenv").config();
const fetchWeatherDataForCountries = require("./request");
const countryRoutes = require("./countryRoutes");
// Call the function
const db = require("./db");
const bodyParser = require("body-parser");

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.get("/", (req, res) => {
  res.status(200).send("Working");
});
app.use("/country", countryRoutes);
app.use((err, req, res, next) => {
  res.status(err.status || 500).json({
    error: {
      message: err.message || "Internal Server Error",
    },
  });
});

app.listen(process.env.PORT, console.log("listening on port 3000"));
// fetchWeatherDataForCountries();
