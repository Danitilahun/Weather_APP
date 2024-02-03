const CountryData = require("./weatherDataSchema");

const getCountryData = async (req, res) => {
  console.log("here i am");
  const { latitude, longitude } = req.params;

  try {
    const countryData = await CountryData.find({
      latitude: { $eq: latitude },
      longitude: { $eq: longitude },
    });

    if (countryData.length === 0) {
      const similarData = await CountryData.find({
        latitude: { $regex: `${latitude.substring(0, 3)}` },
        longitude: { $regex: `${longitude.substring(0, 3)}` },
      });

      if (similarData.length === 0) {
        return res.status(404).json({ message: "No country data found." });
      } else {
        return res.status(200).json(similarData[0]);
      }
    }

    return res.status(200).json(countryData[0]);
  } catch (error) {
    console.error("Failed to get country data:", error);
    return res.status(500).json({ message: "Failed to get country data." });
  }
};

module.exports = {
  getCountryData,
};
