import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:servian_assignment/Screens/InfoScreen.dart';
import 'WeatherMockup.dart';

class WeatherCell extends StatefulWidget {
  String cityName;

  WeatherCell({required this.cityName});

  @override
  State<WeatherCell> createState() => _WeatherCellState();
}

class _WeatherCellState extends State<WeatherCell> {
  late String cityTemp;
  WeatherMockup theData = WeatherMockup(
      cityName: "", cityHumidity: "", cityTemp: "", maxTemp: '', minTemp: '');

  Future<WeatherMockup> _getWeather() async {
    var data = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=${widget.cityName}&units=metric&appid=3e07b2a040094ad02ce7ea3d9a826e00"));

    if (data.statusCode == 200) {
      var jsonData = json.decode(data.body);
      // print(jsonData);
      if (!jsonData.toString().contains("Response: False")) {
        setState(() {
          theData = WeatherMockup(
              cityName: (jsonData['name']).toString(),
              cityTemp: (jsonData['main']['temp']).toString(),
              minTemp: (jsonData['main']['temp_min']).toString(),
              maxTemp: (jsonData['main']['temp_max']).toString(),
              cityHumidity: (jsonData['main']['humidity']).toString());
        });
      } else {
        print("Response: False");
      }
    } else {
      print("FAILED");
    }

    return theData;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        print(theData.cityHumidity);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => InfoScreen(
                      weatherData: theData,
                    )));
      },
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 6),
              blurRadius: 5,
              // spreadRadius: 20,
              color: Color(0xff049867).withOpacity(0.2),
            )
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                '${theData.cityName}',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              ),
            ),
            // ? Can use this one to auto let update data realtime, will consume high memory.
            // FutureBuilder(
            //   future: _getWeather(),
            //   builder: (BuildContext context,
            //       AsyncSnapshot<WeatherMockup> snapshot) {
            //     if (snapshot.data == null) {
            //       return CircularProgressIndicator.adaptive();
            //     } else {
            //       return Text(
            //         snapshot.data!.cityTemp.toString(),
            //         style: TextStyle(fontSize: 30),
            //       );
            //     }
            //   },
            // ),
            theData.cityTemp == ""
                ? CircularProgressIndicator.adaptive()
                : Text(
                    "${theData.cityTemp.toString()} °C",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
                  ),
          ],
        ),
      ),
    );
  }
}
