import 'package:eighty7/service/world_clock.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String date = 'Enter location and Tap on Search icon';
  String newlocation = '';
  String time = '';
  String day = '';
  bool isDayTime = true;
  String error = '';
  Color? bgColor = const Color.fromARGB(255, 240, 166, 30);

  isDayTimeFunc() {
    if (isDayTime) {
      return 'https://i.pinimg.com/564x/e7/36/f3/e736f3fe5becf01a0b70d98ee97bfb0f.jpg';
    } else {
      return 'https://images.unsplash.com/photo-1590418606746-018840f9cd0f?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Ymx1ZSUyMG5pZ2h0JTIwc2t5fGVufDB8fDB8fHww';
    }
  }

  final _locationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              isDayTimeFunc(),
              fit: BoxFit.cover,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    controller: _locationController,
                    onSubmitted: (String value) {
                      getTime(value);
                      _locationController.clear();
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter location',
                      hintStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          getTime(_locationController.text);
                          _locationController.clear();
                        },
                        icon: const Icon(Icons.search, color: Colors.white),
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 60.0,
                ),
                Text(error,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                      color: Color.fromARGB(255, 175, 23, 23),
                    )),
                Text(
                  newlocation,
                  style: const TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                    color: Colors.white,
                  ),
                ),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                    color: Colors.white,
                  ),
                ),
                Text(
                  date,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                    color: Colors.white,
                  ),
                ),
                Text(
                  day,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void getTime(String location) async {
    Map timeData = await worldClock(location: location).getTime();
    setState(() {
      if (timeData.containsKey('error')) {
        // Handle the error, update UI with an error message
        error = timeData['error'];
        Timer(const Duration(seconds: 4), () {
          setState(() {
            error = '';
          });
        });
      } else {
        error = '';
        newlocation = location;
        time = timeData['time'];
        date = timeData['date'];
        day = timeData['day'];
        isDayTime = timeData['isDayTime'];
        bgColor = isDayTime ? const Color(0xFFF0A61E) : const Color(0xFF331C61);
      }
    });
  }
}
