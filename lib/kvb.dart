import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class GridItem {
  final String imagePath;
  final String buttonText;
  final Function(BuildContext) onPressed;
  final IconData iconData;

  GridItem({
    required this.imagePath,
    required this.buttonText,
    required this.onPressed,
    required this.iconData,
  });
}

class kvb extends StatelessWidget {
  final List<GridItem> gridItems;

  kvb() : gridItems = [] {
    _initializeGridItems();
  }

  void _initializeGridItems() {
    gridItems.addAll(
      [
        GridItem(
          imagePath: 'images/balance.png',
          buttonText: 'Balance Check',
          onPressed: (content) {
            _launchDialer('09223766666');
          },
          iconData: Icons.phone,
        ),
        GridItem(
          imagePath: 'images/mini.jpg',
          buttonText: 'Mini Statement',
          onPressed: (content) {
            _launchDialer('09223866666');
          },
          iconData: Icons.phone,
        ),
        GridItem(
          imagePath: 'images/blockatm.png',
          buttonText: 'Block ATM',
          onPressed: (context) {
            _launchDialer('1800 112 211');
          },
          iconData: Icons.phone,
        ),
        GridItem(
          imagePath: 'images/nearbylocation.png',
          buttonText: 'Near KVB ATM',
          onPressed: (context) {
            _launchGoogleMaps(
                query:
                    'near+kvb+atm'); // Call the function with 'sbi+atm' query
          },
          iconData: Icons.location_pin,
        ),
        GridItem(
          imagePath: 'images/calculator.png',
          buttonText: 'Calculator',
          onPressed: (context) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BankInterestCalculator(),
              ),
            );
          },
          iconData: Icons.calculate,
        ),
        GridItem(
          imagePath: 'images/holiday.png',
          buttonText: 'Holiday Check',
          onPressed: (context) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => holiday()),
            );
          },
          iconData: Icons.date_range,
        ),
        GridItem(
          imagePath: 'images/banknear.png',
          buttonText: 'Near KVB bank',
          onPressed: (context) {
            _launchGoogleMaps(
                query:
                    'KARURVYSYA+bank'); // Call the function with 'sbi+bank' query
          },
          iconData: Icons.location_pin,
        ),
        GridItem(
          imagePath: 'images/custem.png',
          buttonText: 'Customer Care',
          onPressed: (context) {
            _launchDialer('1800 425 3800');
          },
          iconData: Icons.phone,
        ),
        GridItem(
          imagePath: 'images/expance.png',
          buttonText: 'Add Expenses',
          onPressed: (context) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ExpenseTrackerAppKVB(),
              ),
            );
          },
          iconData: Icons.add,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double itemWidth = (screenWidth - 40) / 2; // Adjust spacing as needed
    final double imageWidth = itemWidth * 0.8;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'WELCOME TO KVB !  ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Image.asset(
                'images/kvb.png',
                scale: 15,
              )
            ],
          ),
        ),
        backgroundColor: Colors.lime,
      ),
      backgroundColor: const Color.fromARGB(255, 234, 237, 211),
      body: Padding(
        padding: const EdgeInsets.only(top: 35, left: 15, right: 15),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 9 / 10,
          ),
          itemCount: gridItems.length,
          itemBuilder: (context, int i) {
            final item = gridItems[i];
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(3, 3),
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Image.asset(
                        item.imagePath,
                        height: imageWidth,
                        width: imageWidth,
                        scale: 6,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: SizedBox(
                        height: 40,
                        width: itemWidth,
                        child: ElevatedButton(
                          onPressed: () {
                            item.onPressed(context);
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: const Color.fromARGB(255, 13, 13, 13),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                item.buttonText,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(item.iconData),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _launchDialer(String phoneNumber) async {
    final Uri _phoneLaunchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(_phoneLaunchUri)) {
      await launchUrl(_phoneLaunchUri);
    } else {
      throw 'Could not launch $_phoneLaunchUri';
    }
  }

  void _launchGoogleMaps({String query = ''}) async {
    // Construct the URL with the search query
    String url = 'https://www.google.com/maps/search/?api=1&query=$query';
    final Uri mapUri = Uri.parse(url);

    // Check if the URL can be launched
    if (await canLaunchUrl(mapUri)) {
      // Launch the URL
      await launchUrl(mapUri);
    } else {
      // Handle error if the URL can't be launched
      throw 'Could not launch $url';
    }
  }
}

class holiday extends StatefulWidget {
  const holiday({super.key});

  @override
  State<holiday> createState() => _holidayState();
}

class _holidayState extends State<holiday> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'SELECT MONTH',
            ),
            SizedBox(
              width: 10,
            ),
            Icon(Icons.calendar_month),
          ],
        ),
        backgroundColor: Colors.lime,
      ),
      backgroundColor: Colors.lime[100],
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SizedBox(
                    width: 380,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HolidayScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lime,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Set this to 0.0 for a square shape
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('1.JANUARY'),
                          SizedBox(
                            width: 30,
                          ),
                          Icon(Icons.calendar_month),
                          Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SizedBox(
                    width: 380,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => feb(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lime,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Set this to 0.0 for a square shape
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('2.February'),
                          SizedBox(
                            width: 30,
                          ),
                          Icon(Icons.calendar_month),
                          Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SizedBox(
                    width: 380,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => march(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lime,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Set this to 0.0 for a square shape
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('3.MARCH'),
                          SizedBox(
                            width: 30,
                          ),
                          Icon(Icons.calendar_month),
                          Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SizedBox(
                    width: 380,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => april(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lime,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Set this to 0.0 for a square shape
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('4.APRIL'),
                          SizedBox(
                            width: 38,
                          ),
                          Icon(Icons.calendar_month),
                          Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SizedBox(
                    width: 380,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => may(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lime,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Set this to 0.0 for a square shape
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('5.MAY'),
                          SizedBox(
                            width: 48,
                          ),
                          Icon(Icons.calendar_month),
                          Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SizedBox(
                    width: 380,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => june(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lime,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Set this to 0.0 for a square shape
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('6.JUNE'),
                          SizedBox(
                            width: 48,
                          ),
                          Icon(Icons.calendar_month),
                          Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SizedBox(
                    width: 380,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => july(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lime,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Set this to 0.0 for a square shape
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('7.JULY'),
                          SizedBox(
                            width: 48,
                          ),
                          Icon(Icons.calendar_month),
                          Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SizedBox(
                    width: 380,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => augest(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lime,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Set this to 0.0 for a square shape
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('8.AUGUST'),
                          SizedBox(
                            width: 26,
                          ),
                          Icon(Icons.calendar_month),
                          Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SizedBox(
                    width: 380,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => september(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lime,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Set this to 0.0 for a square shape
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('9.SEPTEMBER'),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(Icons.calendar_month),
                          Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SizedBox(
                    width: 380,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => october(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lime,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Set this to 0.0 for a square shape
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('10.OCTOBER'),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(Icons.calendar_month),
                          Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SizedBox(
                    width: 380,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => november(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lime,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Set this to 0.0 for a square shape
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('11.NOVEMBER'),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(Icons.calendar_month),
                          Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SizedBox(
                    width: 380,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => december(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lime,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Set this to 0.0 for a square shape
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('12.DECEMBER'),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(Icons.calendar_month),
                          Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SizedBox(
                    width: 380,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => week(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lime,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Set this to 0.0 for a square shape
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('WEEK-END'),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(Icons.calendar_month),
                          Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Holiday {
  final String date;
  final String holiday;
  final String states;

  Holiday({
    required this.date,
    required this.holiday,
    required this.states,
  });
}

class HolidayScreen extends StatelessWidget {
  final List<Holiday> januaryHolidays = [
    Holiday(
      date: "1st Jan 2024, Monday",
      holiday: "New Year’s Day",
      states:
          "Rajasthan, Mizoram, Sikkim, Tamil Nadu, Puducherry, Nagaland, Telangana, Arunachal Pradesh, Manipur and Meghalaya.",
    ),
    Holiday(
      date: "1st Jan 2024, Monday",
      holiday: "New Year Holiday",
      states: "Mizoram",
    ),
    Holiday(
      date: "11 Jan 2024, Thursday",
      holiday: "Missionary Day",
      states: "Mizoram",
    ),
    Holiday(
      date: "12 Jan 2024, Friday",
      holiday: "Swami Vivekananda Jayanti",
      states: "West Bengal",
    ),
    Holiday(
      date: "14 Jan 2024, Friday",
      holiday: "Boghi",
      states:
          "Karnataka, Tamil Nadu, Andhra Pradesh, Telangana, and Maharashtra",
    ),
    Holiday(
      date: "15 Jan 2024, Monday",
      holiday: "Makara Sankranti",
      states: "Sikkim, Gujarat, Telangana, Karnataka, and Tamil Nadu",
    ),
    Holiday(
      date: "15 Jan 2024, Monday",
      holiday: "Magh Bihu",
      states: "Assam",
    ),
    Holiday(
      date: "16 Jan 2024, Tuesday",
      holiday: "Mattu Pongal",
      states: "Tamil Nadu",
    ),
    Holiday(
      date: "17 Jan 2024, Wednesday",
      holiday: "Uzhavar Thirunal",
      states: "Tamil Nadu and Puducherry",
    ),
    Holiday(
      date: "17 Jan 2024, Wednesday",
      holiday: "Guru Gobind Singh Jayanti",
      states: "Haryana and Chandigarh",
    ),
    Holiday(
      date: "17 Jan 2024, Wednesday",
      holiday: "Parkash Utsav Sri Guru Granth Sahib Ji",
      states: "Punjab",
    ),
    Holiday(
      date: "17 Jan 2024, Wednesday",
      holiday: "Kaanum Pongal",
      states: "Tamil Nadu",
    ),
    Holiday(
      date: "23 Jan 2024, Tuesday",
      holiday: "Netaji Subhas Chandra Bose Jayanti",
      states: "Tripura, Odisha and West Bengal",
    ),
    Holiday(
      date: "25 Jan 2024, Thursday",
      holiday: "State Day",
      states: "Himachal Pradesh",
    ),
    Holiday(
      date: "25 Jan 2024, Thursday",
      holiday: "Hazrat Ali Jayanti",
      states: "Uttar Pradesh",
    ),
    Holiday(
      date: "26 Jan 2024, Friday",
      holiday: "Republic Day",
      states: "National",
    ),
    Holiday(
      date: "31 Jan 2024, Wednesday",
      holiday: "Me-Dum-Me-Phi",
      states: "Assam",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KARUR VYSYA Bank Holidays - January 2024'),
        backgroundColor: Colors.lime,
      ),
      body: ListView.builder(
        itemCount: januaryHolidays.length,
        itemBuilder: (context, index) {
          final holiday = januaryHolidays[index];
          return ListTile(
            title: Text(
              holiday.date,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(holiday.holiday),
                Text(
                  holiday.states,
                  style: TextStyle(color: Colors.grey),
                ),
                Divider(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class feb extends StatelessWidget {
  final List<Holiday> FevHolidays = [
    Holiday(
      date: "10 Feb 2024, Saturday",
      holiday: "Sonam Losar",
      states: "Sikkim",
    ),
    Holiday(
      date: "12 Feb 2024, Monday",
      holiday: "Losar",
      states: "Sikkim",
    ),
    Holiday(
      date: "14 Feb 2024, Wednesday",
      holiday: "Vasant Panchami",
      states: "Odisha, Haryana, Tripura, Punjab and West Bengal",
    ),
    Holiday(
      date: "19 Feb 2024, Monday",
      holiday: "Chhatrapati Shivaji Jayanti",
      states: "Maharashtra",
    ),
    Holiday(
      date: "20 Feb 2024, Tuesday",
      holiday: "State Day",
      states: "Arunachal Pradesh and Mizoram",
    ),
    Holiday(
      date: "24 Feb 2024, Saturday",
      holiday: "Guru Ravidas Jayanti",
      states: "Himachal Pradesh, Haryana, and Punjab",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KARUR VYSYA Bank Holidays - February 2024'),
        backgroundColor: Colors.lime,
      ),
      body: ListView.builder(
        itemCount: FevHolidays.length,
        itemBuilder: (context, index) {
          final holiday = FevHolidays[index];
          return ListTile(
            title: Text(
              holiday.date,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(holiday.holiday),
                Text(
                  holiday.states,
                  style: TextStyle(color: Colors.grey),
                ),
                Divider(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class march extends StatelessWidget {
  final List<Holiday> marchHoliday = [
    Holiday(
      date: "5 Mar 2024, Tuesday",
      holiday: "Panchayatiraj Divas",
      states: "Odisha",
    ),
    Holiday(
      date: "8 Mar 2024, Friday",
      holiday: "Maha Shivaratri",
      states:
          "National except for Arunachal Pradesh, Sikkim, Meghalaya, Puducherry, Nagaland, Lakshadweep, Tamil Nadu, Assam, Bihar, Madhya Pradesh, Goa, Mizoram, Andaman and Nicobar Islands, Manipur and West Bengal",
    ),
    Holiday(
      date: "22 Mar 2024, Friday",
      holiday: "Bihar Day",
      states: "Bihar",
    ),
    Holiday(
      date: "23 Mar 2024, Saturday",
      holiday: "S. Bhagat Singh’s Martyrdom Day",
      states: "Haryana",
    ),
    Holiday(
      date: "25 Mar 2024, Monday",
      holiday: "Holi",
      states:
          "National holidays other than Tamil Nadu, Lakshadweep, Kerala, Karnataka, Delhi, Puducherry, Manipur, and West Bengal",
    ),
    Holiday(
      date: "25 Mar 2024, Monday",
      holiday: "Doljatra",
      states: "West Bengal",
    ),
    Holiday(
      date: "29 Mar 2024, Friday",
      holiday: "Good Friday",
      states: "National except Haryana &amp; Jharkhand",
    ),
    Holiday(
      date: "30 Mar, 2024, Saturday",
      holiday: "Easter Saturday",
      states: "Nagaland",
    ),
    Holiday(
      date: "31 Mar, 2024, Sunday",
      holiday: "Easter Sunday",
      states: "Kerala and Nagaland",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KARUR VYSYA Bank Holidays - March 2024'),
        backgroundColor: Colors.lime[100],
      ),
      body: ListView.builder(
        itemCount: marchHoliday.length,
        itemBuilder: (context, index) {
          final holiday = marchHoliday[index];
          return ListTile(
            title: Text(
              holiday.date,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(holiday.holiday),
                Text(
                  holiday.states,
                  style: TextStyle(color: Colors.grey),
                ),
                Divider(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class april extends StatelessWidget {
  final List<Holiday> aprilHoliday = [
    Holiday(
      date: "1 Apr 2024, Monday",
      holiday: "Odisha Day",
      states: "Odisha",
    ),
    Holiday(
      date: "5 Apr 2024, Friday",
      holiday: "Babu Jagjivan Ram Jayanti",
      states: "Andhra Pradesh and Telangana",
    ),
    Holiday(
      date: "5 Apr 2024, Friday",
      holiday: "Jumat-ul-Wida",
      states: "Jharkhand",
    ),
    Holiday(
      date: "6 Apr 2024, Saturday",
      holiday: "Shab-i-Qadr",
      states: "Jharkhand",
    ),
    Holiday(
      date: "8 Apr 2024, Monday",
      holiday: "Idul Fitr",
      states: "National",
    ),
    Holiday(
      date: "9 Apr 2024, Tuesday",
      holiday: "Gudi Padwa",
      states: "Dadra and Nagar Haveli, Daman and Diu, and Maharashtra",
    ),
    Holiday(
      date: "9 Apr 2024, Tuesday",
      holiday: "Ugadi",
      states:
          "Rajasthan, Gujarat, Goa, Karnataka, Andhra Pradesh, Jharkhand, and Telangana",
    ),
    Holiday(
      date: "11 Apr 2024, Thursday",
      holiday: "Sarhul",
      states: "Jharkhand",
    ),
    Holiday(
      date: "13 Apr 2024, Saturday",
      holiday: "Tamil New Year",
      states: "Tamil Nadu",
    ),
    Holiday(
      date: "14 Apr 2024, Sunday",
      holiday: "Maha Vishuba Sankranti",
      states: "Odisha",
    ),
    Holiday(
      date: "14 Apr 2024, Sunday",
      holiday: "Bohag Bihu Holiday",
      states: "Assam, Arunachal Pradesh and Assam",
    ),
    Holiday(
      date: "14 Apr 2024, Sunday",
      holiday: "Vaisakh",
      states: "Jharkhand & Punjab",
    ),
    Holiday(
      date: "14 Apr 2024, Sunday",
      holiday: "Dr Ambedkar Jayanti",
      states:
          "Chhattisgarh, Tamil Nadu, Haryana, Himachal Pradesh, Arunachal Pradesh, Jammu and Kashmir, Odisha, Uttar Pradesh, Gujarat, Punjab, Rajasthan, Karnataka, Sikkim, Goa, Madhya Pradesh, Telangana, West Bengal, Andhra Pradesh, Jharkhand, Kerala, Bihar, and Uttarakhand",
    ),
    Holiday(
      date: "14 Apr 2024, Sunday",
      holiday: "Cheiraoba",
      states: "Manipur",
    ),
    Holiday(
      date: "14 Apr 2024, Sunday",
      holiday: "Vishu",
      states: "Kerala",
    ),
    Holiday(
      date: "15 Apr 2024, Monday",
      holiday: "Bengali New Year",
      states: "Tripura and West Bengal",
    ),
    Holiday(
      date: "15 Apr 2024, Monday",
      holiday: "Himachal Day",
      states: "Himachal Pradesh",
    ),
    Holiday(
      date: "17 Apr 2024, Wednesday",
      holiday: "Ram Navami",
      states:
          "Sikkim, Odisha, Himachal Pradesh, Rajasthan, Haryana, Maharashtra, Daman and Diu, Gujarat, Chandigarh, Punjab, Uttarakhand, Madhya Pradesh, Bihar, Andaman and Nicobar Islands, Telangana, Uttar Pradesh, Andhra Pradesh and Dadra Nagar Haveli",
    ),
    Holiday(
      date: "21 Apr 2024, Sunday",
      holiday: "Garia Puja",
      states: "Tripura",
    ),
    Holiday(
      date: "21 Apr 2024, Sunday",
      holiday: "Mahavir Jayanti",
      states:
          "Punjab, Daman and Diu, Chandigarh, Uttar Pradesh, Karnataka, Rajasthan, Tamil Nadu, Gujarat, Haryana, Madhya Pradesh, DN, Delhi, Jharkhand, Maharashtra, and Lakshadweep",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KARUR VYSYA Bank Holidays - April 2024'),
        backgroundColor: Colors.lime[100],
      ),
      body: ListView.builder(
        itemCount: aprilHoliday.length,
        itemBuilder: (context, index) {
          final holiday = aprilHoliday[index];
          return ListTile(
            title: Text(
              holiday.date,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(holiday.holiday),
                Text(
                  holiday.states,
                  style: TextStyle(color: Colors.grey),
                ),
                Divider(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class may extends StatelessWidget {
  final List<Holiday> mayHoliday = [
    Holiday(
      date: "1 May 2024, Wednesday",
      holiday: "Maharashtra Day",
      states: "Maharashtra",
    ),
    Holiday(
      date: "1 May 2024, Wednesday",
      holiday: "May Day",
      states: "All states",
    ),
    Holiday(
      date: "9 May 2024, Friday",
      holiday: "Guru Rabindranath Jayanti",
      states: "Tripura and West Bengal",
    ),
    Holiday(
      date: "9 May 2024, Friday",
      holiday: "Maharana Pratap Jayanti",
      states: "Himachal Pradesh, Haryana and Rajasthan",
    ),
    Holiday(
      date: "10 May 2024, Friday",
      holiday: "Maharshi Parasuram Jayanti",
      states:
          "Haryana, Gujarat, Himachal Pradesh, Madhya Pradesh, and Rajasthan",
    ),
    Holiday(
      date: "10 May 2024, Friday",
      holiday: "Basava Jayanti",
      states: "Karnataka",
    ),
    Holiday(
      date: "16 May 2024, Thursday",
      holiday: "State Day",
      states: "Sikkim",
    ),
    Holiday(
      date: "23 May 2024, Thursday",
      holiday: "Buddha Purnima",
      states:
          "Uttar Pradesh, Mizoram, Haryana, Jharkhand, Madhya Pradesh, Delhi, Maharashtra, Tripura, Himachal Pradesh, Arunachal Pradesh, Chandigarh, Andaman and Nicobar Islands, West Bengal, and Uttarakhand",
    ),
    Holiday(
      date: "24 May 2024, Friday",
      holiday: "Kazi Nazrul Islam Jayanti",
      states: "Tripura",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KARUR VYSYA Bank Holidays - May 2024'),
        backgroundColor: Colors.lime[100],
      ),
      body: ListView.builder(
        itemCount: mayHoliday.length,
        itemBuilder: (context, index) {
          final holiday = mayHoliday[index];
          return ListTile(
            title: Text(
              holiday.date,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(holiday.holiday),
                Text(
                  holiday.states,
                  style: TextStyle(color: Colors.grey),
                ),
                Divider(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class june extends StatelessWidget {
  final List<Holiday> apHoliday = [
    Holiday(
      date: "2 June 2024, Sunday",
      holiday: "Telangana Formation Day",
      states: "Telangana",
    ),
    Holiday(
      date: "4 June 2023, Tuesday",
      holiday: "Sant Guru Kabir Jayanti",
      states: "Himachal Pradesh, Chandigarh, Haryana, and Punjab",
    ),
    Holiday(
      date: "10 June 2024, Monday",
      holiday: "Sri Guru Arjun Dev Ji's Martyrdom Day",
      states: "Punjab",
    ),
    Holiday(
      date: "14 June 2023, Friday",
      holiday: "Pahili Raja",
      states: "Odisha",
    ),
    Holiday(
      date: "15 June 2024, Saturday",
      holiday: "Raja Sankranti",
      states: "Odisha",
    ),
    Holiday(
      date: "15 June 2024, Saturday",
      holiday: "YMA Day",
      states: "Mizoram",
    ),
    Holiday(
      date: "16 June 2024, Sunday",
      holiday: "Bakrid / Eid al Adha",
      states:
          "Chandigarh, West Bengal, Telangana, Karnataka, Nagaland, Uttarakhand, Assam, Jharkhand, Gujarat, Arunachal Pradesh, Mizoram, Manipur, Delhi, Madhya Pradesh, Haryana, Bihar, Himachal Pradesh, Kerala, Goa, Punjab, Odisha, Rajasthan, Jammu & Kashmir, Andaman and Nicobar Islands, Lakshadweep, Tamil Nadu, Meghalaya, Uttar Pradesh, Tripura, and Andhra Pradesh",
    ),
    Holiday(
      date: "30 June 2024, Sunday",
      holiday: "Remna Ni",
      states: "Mizoram",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KARUR VYSYA Bank Holidays - JULY 2024'),
        backgroundColor: Colors.lime[100],
      ),
      body: ListView.builder(
        itemCount: apHoliday.length,
        itemBuilder: (context, index) {
          final holiday = apHoliday[index];
          return ListTile(
            title: Text(
              holiday.date,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(holiday.holiday),
                Text(
                  holiday.states,
                  style: TextStyle(color: Colors.grey),
                ),
                Divider(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class july extends StatelessWidget {
  final List<Holiday> juHoliday = [
    Holiday(
      date: "5 July 2024, Friday",
      holiday: "Guru Hargobind Ji's Birthday",
      states: "Jharkhand",
    ),
    Holiday(
      date: "6 July 2024, Saturday",
      holiday: "MHIP Day",
      states: "Mizoram",
    ),
    Holiday(
      date: "7 July 2024, Sunday",
      holiday: "Ratha Yatra",
      states: "Odisha",
    ),
    Holiday(
      date: "7 July 2024, Sunday",
      holiday: "Bonalu",
      states: "Telangana",
    ),
    Holiday(
      date: "13 July 2024, Saturday",
      holiday: "Martyrs’ Day",
      states: "Jharkhand",
    ),
    Holiday(
      date: "13 July 2024, Saturday",
      holiday: "Bhanu Jayanti",
      states: "Sikkim",
    ),
    Holiday(
      date: "14 July 2024, Sunday",
      holiday: "Kharchi Puja",
      states: "Tripura",
    ),
    Holiday(
      date: "17 July 2024, Wednesday",
      holiday: "U Tirot Sing Day",
      states: "Meghalaya",
    ),
    Holiday(
      date: "17 July 2024, Wednesday",
      holiday: "Muharram",
      states:
          "Lakshadweep, Odisha, Delhi, Gujarat, Bihar, Haryana, Jharkhand, Rajasthan, Himachal Pradesh, Jammu & Kashmir, Karnataka, Madhya Pradesh, Chandigarh, Andhra Pradesh, Telangana, Uttar Pradesh, Chhattisgarh, Maharashtra, Tamil Nadu, Andaman and Nicobar, and Tripura",
    ),
    Holiday(
      date: "31 July 2024, Wednesday",
      holiday: "Shaheed Udham Singh’s Martyrdom Day",
      states: "Haryana",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KARUR VYSYA Bank Holidays - JULY 2024'),
        backgroundColor: Colors.lime[100],
      ),
      body: ListView.builder(
        itemCount: juHoliday.length,
        itemBuilder: (context, index) {
          final holiday = juHoliday[index];
          return ListTile(
            title: Text(
              holiday.date,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(holiday.holiday),
                Text(
                  holiday.states,
                  style: TextStyle(color: Colors.grey),
                ),
                Divider(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class augest extends StatelessWidget {
  final List<Holiday> auHOliday = [
    Holiday(
      date: "7 Aug 2024, Wednesday",
      holiday: "Hariyali Teej",
      states: "Haryana",
    ),
    Holiday(
      date: "8 Aug 2024, Thursday",
      holiday: "Tendong Lho Rum Faat",
      states: "Sikkim",
    ),
    Holiday(
      date: "13 Aug 2023, Tuesday",
      holiday: "Patriots Day",
      states: "Manipur",
    ),
    Holiday(
      date: "15 Aug 2024, Thursday",
      holiday: "Independence Day",
      states: "National",
    ),
    Holiday(
      date: "15 Aug 2024, Thursday",
      holiday: "Parsi New Year",
      states: "Maharashtra, Daman and Diu, Dadra and Nagar Haveli, and Gujarat",
    ),
    Holiday(
      date: "16 Aug 2024, Friday",
      holiday: "De Jure Transfer Day",
      states: "Puducherry",
    ),
    Holiday(
      date: "19 Aug 2024, Monday",
      holiday: "Jhulan Purnima",
      states: "Odisha",
    ),
    Holiday(
      date: "19 Aug 2024, Monday",
      holiday: "Raksha Bandhan",
      states:
          "Uttar Pradesh, Haryana, Rajasthan, Gujarat, Madhya Pradesh, Chandigarh, Daman and Diu, Uttarakhand",
    ),
    Holiday(
      date: "26 Aug 2024, Monday",
      holiday: "Janmashtami",
      states:
          "Bihar, Himachal Pradesh, Tamil Nadu, Telangana, Punjab, Jammu & Kashmir, Daman and Diu, Haryana, Jharkhand, Sikkim, Rajasthan, Gujarat, Uttarakhand, Chandigarh, Uttar Pradesh, Delhi, Meghalaya, Odisha, Chhattisgarh, Madhya Pradesh, Nagaland, Andhra Pradesh, Tripura, Andaman and Nicobar and Himachal Pradesh",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KVB Bank Holidays - AUGUST 2024'),
        backgroundColor: Colors.lime,
      ),
      body: ListView.builder(
        itemCount: auHOliday.length,
        itemBuilder: (context, index) {
          final holiday = auHOliday[index];
          return ListTile(
            title: Text(
              holiday.date,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(holiday.holiday),
                Text(
                  holiday.states,
                  style: TextStyle(color: Colors.grey),
                ),
                Divider(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class september extends StatelessWidget {
  final List<Holiday> sepHoliday = [
    Holiday(
      date: "6 Sep 2024, Friday",
      holiday: "Ganesh Chaturthi Holiday",
      states: "Goa",
    ),
    Holiday(
      date: "6 Sep 2024, Friday",
      holiday: "Hartalika Teej",
      states: "Chandigarh and Sikkim",
    ),
    Holiday(
      date: "7 Sep 2024, Saturday",
      holiday: "Ganesh Chaturthi",
      states:
          "Telangana, Maharashtra, Daman and Diu, Dadra and Nagar Haveli, Gujarat, Andhra Pradesh, Karnataka, Odisha, Puducherry, Goa, and Tamil Nadu",
    ),
    Holiday(
      date: "13 Sep 2024, Friday",
      holiday: "Ramdev Jayanti",
      states: "Rajasthan",
    ),
    Holiday(
      date: "13 Sep 2024, Friday",
      holiday: "Teja Dashmi",
      states: "Rajasthan",
    ),
    Holiday(
      date: "14 Sep 2024, Saturday",
      holiday: "First Onam",
      states: "Kerala",
    ),
    Holiday(
      date: "17 Sep 2024, Tuesday",
      holiday: "Indra Jatra",
      states: "Sikkim",
    ),
    Holiday(
      date: "18 Sep 2024, Wednesday",
      holiday: "Sree Narayana Guru Jayanti",
      states: "Kerala",
    ),
    Holiday(
      date: "20 Sep 2024, Friday",
      holiday: "Friday Following Eid e Milad",
      states: "Jharkhand",
    ),
    Holiday(
      date: "21 Sep 2024, Saturday",
      holiday: "Sree Narayana Guru Samadhi",
      states: "Kerala",
    ),
    Holiday(
      date: "23 Sep 2024, Monday",
      holiday: "Heroes’ Martyrdom Day",
      states: "Haryana",
    ),
    Holiday(
      date: "28 Sep 2024, Saturday",
      holiday: "S. Bhagat Singh Ji Jayanti",
      states: "Punjab",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KARUR VYASYA Bank Holidays - SEPTEMBER 2024'),
        backgroundColor: Colors.lime[100],
      ),
      body: ListView.builder(
        itemCount: sepHoliday.length,
        itemBuilder: (context, index) {
          final holiday = sepHoliday[index];
          return ListTile(
            title: Text(
              holiday.date,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(holiday.holiday),
                Text(
                  holiday.states,
                  style: TextStyle(color: Colors.grey),
                ),
                Divider(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class october extends StatelessWidget {
  final List<Holiday> ocHoliday = [
    Holiday(
      date: "2 Oct 2024, Wednesday",
      holiday: "Gandhi Jayanti",
      states: "National",
    ),
    Holiday(
      date: "2 Oct 2024, Wednesday",
      holiday: "Mahalaya Amavasye",
      states: "Tripura, Karnataka, Odisha, and West Bengal",
    ),
    Holiday(
      date: "3 Oct 2024, Thursday",
      holiday: "First Day of Bathukamma",
      states: "Telangana",
    ),
    Holiday(
      date: "3 Oct 2024, Thursday",
      holiday: "Maharaja Agrasen Jayanti",
      states: "Haryana",
    ),
    Holiday(
      date: "3 Oct 2024, Thursday",
      holiday: "Ghatasthapana",
      states: "Rajasthan",
    ),
    Holiday(
      date: "10 Oct 2024, Thursday",
      holiday: "Maha Saptami",
      states: "Tripura, Sikkim, Odisha and West Bengal",
    ),
    Holiday(
      date: "12 Oct 2024, Saturday",
      holiday: "Vijaya Dashami",
      states:
          "Uttar Pradesh, Daman and Diu, West Bengal, Chhattisgarh, Telangana, Himachal Pradesh, Arunachal Pradesh, Delhi, Andaman and Nicobar, Gujarat, Odisha, Nagaland, Andhra Pradesh, Punjab, Goa, Rajasthan, Meghalaya, Madhya Pradesh, Tamil Nadu, Jharkhand, Haryana, Uttarakhand, Tripura, Bihar, Jammu & Kashmir, Assam, Sikkim, and Chandigarh",
    ),
    Holiday(
      date: "16 Oct 2024, Wednesday",
      holiday: "Lakshmi Puja",
      states: "Tripura, Odisha, and West Bengal",
    ),
    Holiday(
      date: "17 Oct 2024, Thursday",
      holiday: "Maharishi Valmiki Jayanti",
      states:
          "Karnataka, Haryana, Madhya Pradesh, Himachal Pradesh,  Chattisgarh, and Punjab",
    ),
    Holiday(
      date: "31 Oct 2024, Thursday",
      holiday: "Deepavali Holiday",
      states:
          "Karnataka, Daman and Diu, Haryana, Rajasthan, Uttarakhand, Maharashtra, and Uttar Pradesh",
    ),
    Holiday(
      date: "31 Oct 2024, Thursday",
      holiday: "Sardar Vallabhbhai Patel Jayanti",
      states: "Gujarat",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KARUR VYSYA Bank Holidays - OCTOBER 2024'),
        backgroundColor: Colors.lime[100],
      ),
      body: ListView.builder(
        itemCount: ocHoliday.length,
        itemBuilder: (context, index) {
          final holiday = ocHoliday[index];
          return ListTile(
            title: Text(
              holiday.date,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(holiday.holiday),
                Text(
                  holiday.states,
                  style: TextStyle(color: Colors.grey),
                ),
                Divider(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class november extends StatelessWidget {
  final List<Holiday> noHoliday = [
    Holiday(
      date: "1 Nov 2024, Friday",
      holiday: "Kut",
      states: "Manipur",
    ),
    Holiday(
      date: "1 Nov 2024, Friday",
      holiday: "Haryana Day",
      states: "Haryana",
    ),
    Holiday(
      date: "1 Nov 2024, Friday",
      holiday: "Puducherry Liberation Day",
      states: "Puducherry",
    ),
    Holiday(
      date: "1 Nov 2024, Friday",
      holiday: "Kannada Rajyotsava",
      states: "Karnataka",
    ),
    Holiday(
      date: "1 Nov 2024, Friday",
      holiday: "Diwali",
      states:
          "Odisha, Manipur, Dadra and Nagar Haveli, Daman and Diu, Bihar, Telangana, Mizoram, Meghalaya, Tripura, Sikkim, Assam, Arunachal Pradesh, Uttarakhand, West Bengal, Nagaland, Madhya Pradesh, Rajasthan, Punjab, Gujarat, Jammu & Kashmir, Haryana, Jharkhand, Himachal Pradesh, Chandigarh, Andaman and Nicobar, and Uttar Pradesh",
    ),
    Holiday(
      date: "2 Nov 2024, Saturday",
      holiday: "Vikram Samvat New Year",
      states: "Gujarat",
    ),
    Holiday(
      date: "3 Nov 2024, Sunday",
      holiday: "Bhai Dooj",
      states: "Across India",
    ),
    Holiday(
      date: "7 Nov 2024, Thursday",
      holiday: "Chhath Puja",
      states: "Bihar, Chandigarh & Jharkhand",
    ),
    Holiday(
      date: "8 Nov 2024, Friday",
      holiday: "Chhath Puja Holiday",
      states: "Bihar",
    ),
    Holiday(
      date: "15 Nov 2024, Friday",
      holiday: "Karthika Purnima",
      states: "Odisha and Telangana",
    ),
    Holiday(
      date: "15 Nov 2024, Friday",
      holiday: "Guru Nanak Jayanti",
      states:
          "Assam, Jharkhand, Uttarakhand, Gujarat, Himachal Pradesh, Chhattisgarh, Telangana, Madhya Pradesh, Delhi, Jammu & Kashmir, Chandigarh, Haryana, Punjab, Arunachal Pradesh, West Bengal, Uttar Pradesh, Rajasthan, Nagaland, Andaman and Nicobar",
    ),
    Holiday(
      date: "18 Nov 2024, Monday",
      holiday: "Kanakadasa Jayanti",
      states: "Karnataka",
    ),
    Holiday(
      date: "22 Nov 2024, Friday",
      holiday: "Lhabab Duchen",
      states: "Sikkim",
    ),
    Holiday(
      date: "23 Nov 2024, Saturday",
      holiday: "Seng Kut Snem",
      states: "Meghalaya",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KVB Bank Holidays - NOVEMBER 2024'),
        backgroundColor: Colors.lime[100],
      ),
      body: ListView.builder(
        itemCount: noHoliday.length,
        itemBuilder: (context, index) {
          final holiday = noHoliday[index];
          return ListTile(
            title: Text(
              holiday.date,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(holiday.holiday),
                Text(
                  holiday.states,
                  style: TextStyle(color: Colors.grey),
                ),
                Divider(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class december extends StatelessWidget {
  final List<Holiday> deHoliday = [
    Holiday(
      date: "3 Dec 2024, Tuesday",
      holiday: "Feast of St Francis Xavier",
      states: "Goa",
    ),
    Holiday(
      date: "5 Dec 2024, Thursday",
      holiday: "Sheikh Muhammad Abdullah Jayanti",
      states: "Jharkhand",
    ),
    Holiday(
      date: "12 Dec 2024, Thursday",
      holiday: "Pa Togan Nengminza Sangma",
      states: "Meghalaya",
    ),
    Holiday(
      date: "17 Dec 2024, Tuesday",
      holiday: "Guru Gobind Singh Jayanti",
      states: "Haryana and Meghalaya",
    ),
    Holiday(
      date: "18 Dec 2024, Wednesday",
      holiday: "Death Anniversary of U SoSo Tham",
      states: "Meghalaya",
    ),
    Holiday(
      date: "18 Dec 2024, Wednesday",
      holiday: "Guru Ghasidas Jayanti",
      states: "Chandigarh",
    ),
    Holiday(
      date: "19 Dec 2024, Thursday",
      holiday: "Liberation Day",
      states: "Daman and Diu, Goa",
    ),
    Holiday(
      date: "25 Dec 2024, Wednesday",
      holiday: "Christmas Day",
      states: "National",
    ),
    Holiday(
      date: "26 Dec 2024, Thursday",
      holiday: "Shaheed Udham Singh Jayanti",
      states: "Haryana",
    ),
    Holiday(
      date: "26 Dec 2024, Thursday",
      holiday: "Christmas Holiday",
      states: "Telangana, Mizoram and Meghalaya",
    ),
    Holiday(
      date: "30 Dec 2024, Monday",
      holiday: "U Kiang Nangbah",
      states: "Meghalaya",
    ),
    Holiday(
      date: "30 Dec 2024, Monday",
      holiday: "Tamu Losar",
      states: "Sikkim",
    ),
    Holiday(
      date: "31 Dec 2024, Tuesday",
      holiday: "New Year's Eve",
      states: "Manipur",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KVB Bank Holidays - DECEMBER 2024'),
        backgroundColor: Colors.lime[100],
      ),
      body: ListView.builder(
        itemCount: deHoliday.length,
        itemBuilder: (context, index) {
          final holiday = deHoliday[index];
          return ListTile(
            title: Text(
              holiday.date,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(holiday.holiday),
                Text(
                  holiday.states,
                  style: TextStyle(color: Colors.grey),
                ),
                Divider(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class week extends StatelessWidget {
  const week({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KVB Bank Holidays - WEEK-END 2024'),
        backgroundColor: Colors.lime[100],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DataTable(
              columns: <DataColumn>[
                DataColumn(label: Text('Date')),
                DataColumn(label: Text('Saturday Type')),
              ],
              rows: <DataRow>[
                DataRow(cells: <DataCell>[
                  DataCell(Text('13 Jan 2024')),
                  DataCell(Text('Second Saturday')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('27 Jan 2024')),
                  DataCell(Text('Fourth Saturday')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('10 Feb 2024')),
                  DataCell(Text('Second Saturday')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('24 Feb 2024')),
                  DataCell(Text('Fourth Saturday')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('9 Mar 2024')),
                  DataCell(Text('Second Saturday')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('23 Mar 2024')),
                  DataCell(Text('Fourth Saturday')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('13 Apr 2024')),
                  DataCell(Text('Second Saturday')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('27 Apr 2024')),
                  DataCell(Text('Fourth Saturday')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('11 May 2024')),
                  DataCell(Text('Second Saturday')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('25 May 2024')),
                  DataCell(Text('Fourth Saturday')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('8 June 2024')),
                  DataCell(Text('Second Saturday')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('22 June 2024')),
                  DataCell(Text('Fourth Saturday')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('13 July 2024')),
                  DataCell(Text('Second Saturday')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('27 July 2024')),
                  DataCell(Text('Fourth Saturday')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('10 Aug 2024')),
                  DataCell(Text('Second Saturday')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('24 Aug 2024')),
                  DataCell(Text('Fourth Saturday')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('14 Sep 2024')),
                  DataCell(Text('Second Saturday')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('28 Sep 2024')),
                  DataCell(Text('Fourth Saturday')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('12 Oct 2024')),
                  DataCell(Text('Second Saturday')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('26 Oct 2024')),
                  DataCell(Text('Fourth Saturday')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('9 Nov 2024')),
                  DataCell(Text('Second Saturday')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('23 Nov 2024')),
                  DataCell(Text('Fourth Saturday')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('14 Dec 2024')),
                  DataCell(Text('Second Saturday')),
                ]),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('28 Dec 2024')),
                    DataCell(Text('Fourth Saturday')),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BankInterestCalculator extends StatefulWidget {
  @override
  _BankInterestCalculatorState createState() => _BankInterestCalculatorState();
}

class _BankInterestCalculatorState extends State<BankInterestCalculator> {
  double principal = 0.0;
  double rate = 0.0;
  int years = 0;
  double interest = 0.0;
  double totalAmount = 0.0;

  void calculateInterest() {
    setState(() {
      interest = (principal * rate * years) / 100;
      totalAmount = principal + interest;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Bank Interest Calculator',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
                width: 30,
                child: Icon(Icons.calculate_outlined),
              ),
            ],
          ),
          backgroundColor: Colors.lime[100],
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Principal'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    principal = double.parse(value);
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Interest Rate (%)'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    rate = double.parse(value);
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Years'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    years = int.parse(value);
                  });
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: calculateInterest,
                child: Text('Calculate'),
              ),
              SizedBox(height: 20.0),
              Text(
                'Interest: $interest',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                'Total Amount: $totalAmount',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExpenseTrackerAppKVB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        hintColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: ExpenseTrackerHomePageKVB(),
    );
  }
}

class ExpenseTrackerHomePageKVB extends StatefulWidget {
  @override
  _ExpenseTrackerHomePageState createState() => _ExpenseTrackerHomePageState();
}

class _ExpenseTrackerHomePageState extends State<ExpenseTrackerHomePageKVB> {
  List<Map<String, dynamic>> _expenses = [];
  String _selectedType = 'Outgoing';

  final _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadExpenses();
  }

  void _addExpense() {
    final enteredAmount = double.tryParse(_amountController.text);

    if (enteredAmount == null) {
      return;
    }

    final newExpense = {
      'amount': enteredAmount,
      'type': _selectedType,
      'date': DateTime.now().toString(),
    };

    setState(() {
      _expenses.add(newExpense);
    });

    _saveExpenses();

    _amountController.clear();
    Navigator.of(context).pop();
  }

  void _startAddNewExpense(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: 'Amount'),
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                ),
                DropdownButton<String>(
                  value: _selectedType,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedType = newValue!;
                    });
                  },
                  items: <String>['Income', 'Outgoing']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('Add Expense'),
                  onPressed: _addExpense,
                ),
              ],
            ),
          ),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  Future<void> _loadExpenses() async {
    final prefs = await SharedPreferences.getInstance();
    final expensesData = prefs.getString('expenses');
    if (expensesData != null) {
      setState(() {
        _expenses = List<Map<String, dynamic>>.from(json.decode(expensesData));
      });
    }
  }

  Future<void> _saveExpenses() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('expenses', json.encode(_expenses));
  }

  void _deleteExpense(int index) {
    setState(() {
      _expenses.removeAt(index);
    });
    _saveExpenses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'Add Your Expense',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 10,
          ),
          Image.asset(
            'images/expance.png',
            scale: 15,
          )
        ]),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewExpense(context),
          ),
        ],
        backgroundColor: Colors.grey[300],
      ),
      body: _expenses.isEmpty
          ? Center(
              child: Text(
                'No expenses added yet!',
                style: TextStyle(fontSize: 20),
              ),
            )
          : ListView.builder(
              itemCount: _expenses.length,
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: _expenses[index]['type'] == 'Income'
                          ? Colors.green
                          : Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text(
                            '₹${_expenses[index]['amount']}',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      _expenses[index]['type'],
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd()
                          .format(DateTime.parse(_expenses[index]['date'])),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () => _deleteExpense(index),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewExpense(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
