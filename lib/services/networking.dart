import 'dart:async';

import 'package:http/http.dart ' as http;
import 'dart:convert';
import 'location.dart';

const apiKey = 'db9bbb52d2ee087fa15b222f79827965';

class NetworkHelper {
  Future searchedCityData(String searchedCityName) async {
    try {
      var response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$searchedCityName&appid=$apiKey&units=metric'));
      if (response.statusCode == 200) {
        String dataFromResponse = response.body;
        var decodedData =
            jsonDecode(dataFromResponse); //part of the dart:convert library

        return decodedData;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  Future getData() async {
    Location location = Location();
    await location.getCrrentLocation();
    //${location.latitudeGeo}

    var response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitudeGeo}&lon=${location.longitudeGeo}1&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      String dataFromResponse = response.body;
      var decodedData =
          jsonDecode(dataFromResponse); //part of the dart:convert library
      return decodedData;
    } else {
      print(response.statusCode);
    }
  }
}
