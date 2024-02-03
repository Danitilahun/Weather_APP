const express = require("express");
const countryController = require("./weatherController");
const router = express.Router();
console.log("router started");
router.get("/", countryController.getCountryData);
module.exports = router;
