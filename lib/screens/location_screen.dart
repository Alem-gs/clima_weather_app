import 'package:clima_weather_app/screens/city_screen.dart';
import 'package:clima_weather_app/services/networking.dart';
import 'package:flutter/material.dart';
////The ../ means "go up one level from screens," which brings you back to the lib directory.
import '../utilities/constants.dart';
import '../services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  late int temp;
  late String weatherMessage;
  late String weatherIcon;
  late String cityName;
  late int ID;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(widget
        .locationWeather); //widget is like the obj name of the locationScreen class
  }

  void updateUI(dynamic weatherDataa) {
    setState(() {
      //it was also working with out setState method

      //the if in below is for safety internet, location disabled, ...
      //to prevent the app from crash

      if (weatherDataa == null) {
        temp = 0;
        cityName = 'no city';
        weatherMessage = 'unable to get weather data';
        weatherIcon = 'error';
        return; // this empty return will make the app not to continue to the below values inside the void
      }
      double temperature = weatherDataa['main']['temp'];
      temp = temperature.toInt();
      //to make the temp value in int without decimal place
      var condition = weatherDataa['weather'][0]['id'];
      cityName = weatherDataa['name'];
      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = weather.getMessage(temp);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //The line in below applies decoration to a widget, typically a container. BoxDecoration is a class that allows you to customize the appearance of the container, such as its background, border, shadow, etc.
        decoration: BoxDecoration(
          //DecorationImage is used to display an image as part of the decoration.
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit
                .cover, //tells the image to cover the entire area of the container
            //If the aspect ratio of the image differs from that of the container, the image will be clipped to fit the container's dimensions.
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      updateUI(widget.locationWeather);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      if (typedName != null) {
                        NetworkHelper networkHelper = NetworkHelper();

                        var weather =
                            await networkHelper.searchedCityData(typedName);

                        updateUI(weather);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temp°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$weatherMessage in $cityName!',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
