import 'package:bank/sbi.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Urbanist',
      ),
      home: App(),
    );
  }
}

class App extends StatefulWidget {
  const App({Key? key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Select Your Bank',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Image.asset(
              'images/bank.png',
              scale: 15,
            ),
          ],
        ),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SBIPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrangeAccent[100],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/sbi.png',
                      height: 35,
                      width: 35,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('STATE BANK OF INDIA'),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => IndianBankPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrangeAccent[100],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/indian.png',
                      height: 50,
                      width: 50,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text('INDIAN BANK'),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 250,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UnionBankPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrangeAccent[100],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/union.png',
                    height: 25,
                    width: 25,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('UNION BANK OF INDIA'),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 250,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => KarurVysyaBankPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrangeAccent[100],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/kvb.png',
                    height: 35,
                    width: 35,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('KARUR VYSYA BANK'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SBIPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: sbi(),
    );
  }
}

class IndianBankPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Indian Bank Page'),
      ),
      body: Center(
        child: Text('This is the Indian Bank page'),
      ),
    );
  }
}

class UnionBankPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Union Bank Page'),
      ),
      body: Center(
        child: Text('This is the Union Bank page'),
      ),
    );
  }
}

class KarurVysyaBankPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Karur Vysya Bank Page'),
      ),
      body: Center(
        child: Text('This is the Karur Vysya Bank page'),
      ),
    );
  }
}
