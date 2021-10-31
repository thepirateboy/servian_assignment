import 'package:flutter/material.dart';
import '../Items/WeatherMockup.dart';

class InfoScreen extends StatelessWidget {
  WeatherMockup weatherData;

  InfoScreen({required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(weatherData.cityName),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                InfoCell(
                  label: "Current Temperature",
                  value: "${weatherData.cityTemp} °C",
                ),
                InfoCell(
                  label: "Current Humidity",
                  value: "${weatherData.cityHumidity}",
                ),
                InfoCell(
                  label: "Min Temperature",
                  value: "${weatherData.minTemp} °C",
                ),
                InfoCell(
                  label: "Min Temperature",
                  value: "${weatherData.maxTemp} °C",
                ),
              ],
            ),
          ),
        ));
  }
}

class InfoCell extends StatelessWidget {
  const InfoCell({Key? key, required this.label, required this.value})
      : super(key: key);

  final label;
  final value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      width: MediaQuery.of(context).size.height - 40,
      margin: EdgeInsets.only(top: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 6),
            blurRadius: 5,
            // spreadRadius: 20,
            color: Colors.redAccent.withOpacity(0.2),
          )
        ],
      ),
      child: Column(
        children: [
          Text(
            "$label",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          Text(
            "$value",
            style: TextStyle(fontSize: 60, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
