import 'package:flutter/material.dart';
//import 'package:http/http.dart';
import '../services/location.dart';
import '../services/networking.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  //the initState is to display the location while the page loads
  void initState() {
    super.initState();
    getPermission();
    getLocationData();
  }

  void getPermission() async {
    Location location = Location();
    await location.requestPermission();
  }

  void getLocationData() async {
    NetworkHelper networkHelper = NetworkHelper();
    var weatherData = await networkHelper.getData();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LocationScreen(locationWeather: weatherData);
        },
      ),
    );

    //getData();
    // print('latitude= $latitude');
    // print('longitude= $longitude');
  }

  // void getData() async {
  //   //The Uri.parse() method in Dart is used to convert a string representation of a URL into a Uri object, which is the format that many HTTP-related methods in Dart, like http.get(), expect.
  //   //http.Response and http.get the http is to show that the Response obj and get method comes from the http pkg

  //   //print(response.body); //this will print the whole thing lat, long...
  //   //print(response.statusCode); //this will print the status of the request like 404-not found, 200-success

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SpinKitRotatingCircle(
        color: Colors.white,
        size: 50.0,
      )),

      // body: Center(
      //   child: ElevatedButton(
      //     onPressed: () {
      //       getPermission();
      //       getLocation();
      //     },
      //     child: Text('Get Location'),
      //   ),
      // ),
    );
  }
}
