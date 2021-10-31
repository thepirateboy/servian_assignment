import 'package:flutter/material.dart';
import 'package:servian_assignment/Items/WeatherCell.dart';
import '../Items/Validator.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<WeatherCell> theWeatherTable = [
    WeatherCell(cityName: "Sydney"),
    WeatherCell(cityName: "Melbourne"),
    WeatherCell(cityName: "Brisbane"),
  ];

  var citySearchName = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Servian Weather Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Add your city or place'),
                  content: TextField(
                    onChanged: (value) {
                      citySearchName = value;
                    },
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () async {
                        bool validation = await cityValidator(citySearchName);

                        final falseSnackbar = SnackBar(
                          content: const Text("That doesn't exist!"),
                          action: SnackBarAction(
                            label: 'Ok',
                            onPressed: () {},
                          ),
                        );
                        setState(() {
                          validation == false
                              ? ScaffoldMessenger.of(context)
                                  .showSnackBar(falseSnackbar)
                              : theWeatherTable
                                  .add(WeatherCell(cityName: citySearchName));
                        });
                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: theWeatherTable,
        ),
      ),
    );
  }
}
