import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart';

class worldClock {
  String location;
  late String time;
  late bool isDayTime;

  worldClock({required this.location});

  Future<Map> getTime() async {
    Map timeData = {};
    try {
      Uri url =
          Uri.parse('https://api.api-ninjas.com/v1/worldtime?city=$location');
      Response response = await get(
        url,
        headers: {'x-api-key': 'VwA0CzGwuME4Ig3elXL1HQ==No4OTqEKy8lKlsDQ'},
      );
      Map data = jsonDecode(response.body);
      String datetime = data['datetime'];
      String date = data['date'];
      String day = data['day_of_week'];
      String newlocation = data['timezone'].split('/')[1];
      DateTime now = DateTime.parse(datetime);
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
      timeData = {
        'time': time,
        'isDayTime': isDayTime,
        'date': date,
        'day': day,
        'location': newlocation,
      };
    } catch (e) {
      print('caught error: $e');
      timeData = {'error': 'Could not get time data. Please try again.'};
    }
    return timeData;
  }
}
