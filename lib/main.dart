import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String activity = '';
  final Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();

  bool isButtonPressed = false;
  String message = ''; // Custom message

  @override
  void initState() {
    super.initState();
    // Load the activity from local storage when the app starts.
    _loadActivityFromStorage();
  }

  Future<void> _loadActivityFromStorage() async {
    final sharedPreferences = await _sharedPreferences;
    final storedActivity = sharedPreferences.getString('activity');
    if (storedActivity != null) {
      setState(() {
        activity = storedActivity;
      });
    }
  }

  Future<void> _getActivity() async {
    setState(() {
      isButtonPressed = true;
      message = ''; // Clear any previous message.
    });
    try {
      final response =
          await http.get(Uri.parse('https://www.boredapi.com/api/activity/'));
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final newActivity = jsonResponse['activity'];

        final sharedPreferences = await _sharedPreferences;
        sharedPreferences.setString('activity', newActivity);

        // Simulate a delay for the message to be visible.
        await Future.delayed(const Duration(seconds: 1));

        setState(() {
          activity = newActivity;
          isButtonPressed = false;
        });
      } else {
        print('HTTP request failed with status ${response.statusCode}');
        setState(() {
          message = 'An error occurred while fetching the activity.';
          isButtonPressed = false;
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        message = 'An error occurred while fetching the activity.';
        isButtonPressed = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: Colors.blue,
              height: 1.0,
            ),
          ),
          title: Center(
            child: Text(
              'Random Activity',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'ProfessionalFont',
                fontSize: 24,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 10,
                  ),
                ],
              ),
            ),
          ), // Centered title with custom font and larger size
          backgroundColor: Colors.blue, // App bar background color
          elevation: 0, // Remove app bar elevation
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.grey.shade200, Colors.grey.shade100],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isButtonPressed)
                  const Text(
                    'Loading...',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ), // Custom loading message with larger font and white color
                  )
                else
                  // Apply a fade-in animation to the Text widget.
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: isButtonPressed ? 0.0 : 1.0,
                    child: Text(
                      activity,
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                      ), // Larger font for text and white color
                    ),
                  ),
                const SizedBox(height: 20),
                // Apply a scale animation to the ElevatedButton.
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  transform: Matrix4.identity()
                    ..scale(isButtonPressed ? 0.9 : 1.0),
                  child: ElevatedButton(
                    onPressed: _getActivity,
                    // Apply a color animation to the button when it's pressed.
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.blueAccent;
                          }
                          return Colors.blue;
                        },
                      ),
                      elevation: MaterialStateProperty.all(10), // Add elevation
                      shadowColor: MaterialStateProperty.all(Colors.blue),
                    ),
                    child: const Text(
                      'GET',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ), // Larger font and bold text for button
                    ),
                  ),
                ),
                if (message.isNotEmpty)
                  Text(
                    message,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                    ), // Larger font and red color for error message
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
