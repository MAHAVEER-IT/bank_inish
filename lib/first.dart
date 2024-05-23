import 'package:bank/Utils/colors.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class first extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              primaryColor,
              backgroundColor2,
              Colors.deepOrangeAccent.shade100,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'CHOOSE ANY ONE',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      backgroundColor: Colors
                          .transparent, // Set background color to transparent
                      elevation: 5, // Add elevation for a shadow effect
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      padding: EdgeInsets.all(30),
                    ),
                    onPressed: () {
                      // Define the action when the button is pressed
                      print('Circular button pressed');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => App(),
                        ),
                      );
                    },
                    child: Image.asset(
                      'images/bank.png',
                      scale:
                          10, // Adjust the scale as needed to fit the image inside the button
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      backgroundColor: Colors
                          .transparent, // Set background color to transparent
                      elevation: 5, // Add elevation for a shadow effect
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      padding: EdgeInsets.all(30),
                    ),
                    onPressed: () {
                      // Define the action when the button is pressed
                      print('Circular button pressed');
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyApp(),
                        ),
                      );*/
                    },
                    child: Image.asset(
                      'images/expance.png',
                      scale:
                          10, // Adjust the scale as needed to fit the image inside the button
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
