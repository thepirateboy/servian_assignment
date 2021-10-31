import 'dart:convert';
import 'package:http/http.dart' as http;

Future<bool> cityValidator(var cityName) async {
  var data = await http.get(Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?q=${cityName}&units=metric&appid=3e07b2a040094ad02ce7ea3d9a826e00"));

  if (data.statusCode == 200) {
    var jsonData = json.decode(data.body);
    // print(jsonData);
    if (!jsonData.toString().contains("Response: False")) {
      return true;
    } else {
      return false;
    }
  } else {
    return false;
  }
}
