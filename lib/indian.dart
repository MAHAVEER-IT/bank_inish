import 'dart:convert';
import 'dart:math';
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

class india extends StatelessWidget {
  final List<GridItem> gridItems;

  india() : gridItems = [] {
    _initializeGridItems();
  }

  void _initializeGridItems() {
    gridItems.addAll(
      [
        GridItem(
          imagePath: 'images/balance.png',
          buttonText: 'Balance Check',
          onPressed: (content) {
            _launchDialer('09289592895');
          },
          iconData: Icons.phone,
        ),
        GridItem(
          imagePath: 'images/mini.png',
          buttonText: 'Mini Statement',
          onPressed: (content) {
            _launchDialer('09289592895');
          },
          iconData: Icons.phone,
        ),
        GridItem(
          imagePath: 'images/blockatm.png',
          buttonText: 'Block ATM',
          onPressed: (context) {
            _launchDialer('1800 425 00000');
          },
          iconData: Icons.phone,
        ),
        GridItem(
          imagePath: 'images/custem.png',
          buttonText: 'Custemor Care',
          onPressed: (context) {
            _launchDialer('1800 425 4422');
          },
          iconData: Icons.phone,
        ),
        GridItem(
              imagePath: 'images/nearbylocation.png',
              buttonText: 'Indian ATM',
              onPressed: (context) {
                _launchGoogleMaps(destination: 'Indian bank ATM');
              },
              iconData: Icons.location_pin,
            ),
            GridItem(
              imagePath: 'images/banknear.png',
              buttonText: 'Indian Bank',
              onPressed: (context) {
                _launchGoogleMaps(destination: 'Indian Bank');
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
                builder: (context) => LoanCalculatorPage(),
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
                'WELCOME TO Indian Bank !',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Image.asset(
                'images/indian.png',
                scale: 45,
              )
            ],
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: const Color.fromARGB(255, 209, 228, 237),
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
                            backgroundColor:
                                const Color.fromARGB(255, 11, 11, 11),
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

  void _launchGoogleMaps({required String destination}) async {
    // Construct the URL for directions
    String url =
        'https://www.google.com/maps/dir/?api=1&destination=$destination&travelmode=driving';
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

class HolidayGridItem {
  final String buttonText;
  final Function(BuildContext) onPressed;
  final IconData iconData;

  HolidayGridItem({
    required this.buttonText,
    required this.onPressed,
    required this.iconData,
  });
}

class holiday extends StatefulWidget {
  @override
  State<holiday> createState() => _holidayState();
}

class _holidayState extends State<holiday> {
  final List<HolidayGridItem> gridItems;

  _holidayState() : gridItems = [] {
    _initializeGridItems();
  }

  void _initializeGridItems() {
    gridItems.addAll(
      [
        HolidayGridItem(
          buttonText: 'January',
          onPressed: (context) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => HolidayScreen()));
          },
          iconData: Icons.date_range_outlined,
        ),
        HolidayGridItem(
          buttonText: 'February',
          onPressed: (context) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => feb()));
          },
          iconData: Icons.date_range_outlined,
        ),
        HolidayGridItem(
          buttonText: 'March',
          onPressed: (context) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => March()));
          },
          iconData: Icons.date_range_outlined,
        ),
        HolidayGridItem(
          buttonText: 'April',
          onPressed: (context) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => April()));
          },
          iconData: Icons.date_range_outlined,
        ),
        HolidayGridItem(
          buttonText: 'May',
          onPressed: (context) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => May()));
          },
          iconData: Icons.date_range_outlined,
        ),
        HolidayGridItem(
          buttonText: 'June',
          onPressed: (context) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => JuneHolidays()));
          },
          iconData: Icons.date_range_outlined,
        ),
        HolidayGridItem(
          buttonText: 'July',
          onPressed: (context) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => JulyHolidays()));
          },
          iconData: Icons.date_range_outlined,
        ),
        HolidayGridItem(
          buttonText: 'August',
          onPressed: (context) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AugustHolidays()));
          },
          iconData: Icons.date_range_outlined,
        ),
        HolidayGridItem(
          buttonText: 'September',
          onPressed: (context) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SeptemberHolidays()));
          },
          iconData: Icons.date_range_outlined,
        ),
        HolidayGridItem(
          buttonText: 'October',
          onPressed: (context) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => OctoberHolidays()));
          },
          iconData: Icons.date_range_outlined,
        ),
        HolidayGridItem(
          buttonText: 'November',
          onPressed: (context) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => NovemberHolidays()));
          },
          iconData: Icons.date_range_outlined,
        ),
        HolidayGridItem(
          buttonText: 'December',
          onPressed: (context) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DecemberHolidays()));
          },
          iconData: Icons.date_range_outlined,
        ),
        HolidayGridItem(
          buttonText: 'WEEK-END',
          onPressed: (context) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => WeekendHolidays()));
          },
          iconData: Icons.date_range_outlined,
        ),
      ],
    );
  }

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
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.lightBlue[100],
      body: Padding(
        padding: const EdgeInsets.only(top: 100, left: 15, right: 15),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 1, // Ensure the grid items are square
          ),
          itemCount: gridItems.length,
          itemBuilder: (context, int i) {
            final item = gridItems[i];
            return InkWell(
              onTap: () async {
                await item.onPressed(context);
              },
              child: ClipOval(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(3, 3),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          item.iconData,
                          size: 40,
                          color: Colors.black,
                        ),
                        SizedBox(height: 10),
                        Text(
                          item.buttonText,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
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
        title: Text('Indian Bank Holidays - January 2024'),
        backgroundColor: Colors.lightBlue[100],
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
        title: Text('Indian Bank Holidays - February 2024'),
        backgroundColor: Colors.lightBlue[100],
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

class March extends StatelessWidget {
  final List<Holiday> marchHolidays = [
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
      states: "National except Haryana & Jharkhand",
    ),
    Holiday(
      date: "30 Mar 2024, Saturday",
      holiday: "Easter Saturday",
      states: "Nagaland",
    ),
    Holiday(
      date: "31 Mar 2024, Sunday",
      holiday: "Easter Sunday",
      states: "Kerala and Nagaland",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Indian Bank Holidays - March 2024'),
        backgroundColor: Colors.lightBlue[100],
      ),
      body: ListView.builder(
        itemCount: marchHolidays.length,
        itemBuilder: (context, index) {
          final holiday = marchHolidays[index];
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

void main() {
  runApp(MaterialApp(
    title: 'Indian Bank Holidays',
    home: March(),
  ));
}

class April extends StatelessWidget {
  final List<Holiday> aprilHolidays = [
    Holiday(
      date: "1 Apr 2024, Monday",
      holiday: "Odisha Day / Utkal Divas",
      states: "Odisha",
    ),
    Holiday(
      date: "2 Apr 2024, Tuesday",
      holiday: "Rama Navami",
      states: "National except Goa, Kerala, and Manipur",
    ),
    Holiday(
      date: "6 Apr 2024, Saturday",
      holiday: "Mahavir Jayanti",
      states: "National",
    ),
    Holiday(
      date: "10 Apr 2024, Wednesday",
      holiday: "Good Friday",
      states: "National except Haryana and Jharkhand",
    ),
    Holiday(
      date: "13 Apr 2024, Saturday",
      holiday: "Biju Festival",
      states: "Odisha",
    ),
    Holiday(
      date: "14 Apr 2024, Sunday",
      holiday: "Ambedkar Jayanti",
      states: "National",
    ),
    Holiday(
      date: "14 Apr 2024, Sunday",
      holiday: "Bengali New Year",
      states: "Tripura and West Bengal",
    ),
    Holiday(
      date: "14 Apr 2024, Sunday",
      holiday: "Bohag Bihu",
      states: "Assam",
    ),
    Holiday(
      date: "15 Apr 2024, Monday",
      holiday: "Vaisakhi",
      states: "Punjab and Haryana",
    ),
    Holiday(
      date: "15 Apr 2024, Monday",
      holiday: "Bohag Bihu Holiday",
      states: "Assam",
    ),
    Holiday(
      date: "19 Apr 2024, Friday",
      holiday: "Good Friday",
      states: "Haryana and Jharkhand",
    ),
    Holiday(
      date: "21 Apr 2024, Sunday",
      holiday: "Ram Navami",
      states:
          "Andhra Pradesh, Bihar, Chhattisgarh, Delhi, Gujarat, Haryana, Himachal Pradesh, Jammu and Kashmir, Jharkhand, Karnataka, Maharashtra, Madhya Pradesh, Odisha, Punjab, Rajasthan, Sikkim, Telangana, Tripura, Uttar Pradesh, Uttarakhand, and West Bengal",
    ),
    Holiday(
      date: "27 Apr 2024, Saturday",
      holiday: "Fourth Saturday of April",
      states: "Nagaland",
    ),
    Holiday(
      date: "30 Apr 2024, Tuesday",
      holiday: "Buddha Purnima / Vesak",
      states: "National except Goa, Kerala, Lakshadweep, and Manipur",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Indian Bank Holidays - April 2024'),
        backgroundColor: Colors.lightBlue[100],
      ),
      body: ListView.builder(
        itemCount: aprilHolidays.length,
        itemBuilder: (context, index) {
          final holiday = aprilHolidays[index];
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

class May extends StatelessWidget {
  final List<Holiday> mayHolidays = [
    Holiday(
      date: "1 May 2024, Wednesday",
      holiday: "May Day",
      states: "National",
    ),
    Holiday(
      date: "7 May 2024, Tuesday",
      holiday: "Rabindranath Tagore Jayanti",
      states: "Tripura and West Bengal",
    ),
    Holiday(
      date: "7 May 2024, Tuesday",
      holiday: "Guru Rabindranath Tagore Jayanti",
      states: "Haryana",
    ),
    Holiday(
      date: "7 May 2024, Tuesday",
      holiday: "Parshuram Jayanti",
      states: "Himachal Pradesh",
    ),
    Holiday(
      date: "18 May 2024, Saturday",
      holiday: "Buddha Purnima / Vesak",
      states: "National except Goa, Kerala, Lakshadweep, and Manipur",
    ),
    Holiday(
      date: "18 May 2024, Saturday",
      holiday: "Narada Jayanti",
      states: "Uttar Pradesh",
    ),
    Holiday(
      date: "18 May 2024, Saturday",
      holiday: "Buddha Purnima",
      states: "Bihar",
    ),
    Holiday(
      date: "18 May 2024, Saturday",
      holiday: "Fourth Saturday of May",
      states: "Nagaland",
    ),
    Holiday(
      date: "18 May 2024, Saturday",
      holiday: "Buddha Purnima / Vesak",
      states: "Arunachal Pradesh",
    ),
    Holiday(
      date: "24 May 2024, Friday",
      holiday: "Jamat Ul-Vida",
      states: "Jammu and Kashmir",
    ),
    Holiday(
      date: "24 May 2024, Friday",
      holiday: "Ramzan Id / Id-ul-Fitr",
      states:
          "National except Andaman and Nicobar Islands, Arunachal Pradesh, Assam, Bihar, Dadra and Nagar Haveli, Daman and Diu, Goa, Gujarat, Himachal Pradesh, Jammu and Kashmir, Jharkhand, Karnataka, Kerala, Lakshadweep, Madhya Pradesh, Maharashtra, Manipur, Meghalaya, Mizoram, Nagaland, Puducherry, Punjab, Rajasthan, Sikkim, Tamil Nadu, Telangana, Tripura, Uttar Pradesh, and Uttarakhand",
    ),
    Holiday(
      date: "31 May 2024, Friday",
      holiday: "Maharana Pratap Jayanti",
      states: "Haryana",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Indian Bank Holidays - May 2024'),
        backgroundColor: Colors.lightBlue[100],
      ),
      body: ListView.builder(
        itemCount: mayHolidays.length,
        itemBuilder: (context, index) {
          final holiday = mayHolidays[index];
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

class JuneHolidays extends StatelessWidget {
  final List<Holiday> apHoliday = [
    Holiday(
      date: "2 June 2024, Sunday",
      holiday: "Telangana Formation Day",
      states: "Telangana",
    ),
    Holiday(
      date: "4 June 2024, Tuesday",
      holiday: "Sant Guru Kabir Jayanti",
      states: "Himachal Pradesh, Chandigarh, Haryana, and Punjab",
    ),
    Holiday(
      date: "10 June 2024, Monday",
      holiday: "Sri Guru Arjun Dev Ji's Martyrdom Day",
      states: "Punjab",
    ),
    Holiday(
      date: "14 June 2024, Friday",
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
        title: Text('Indian Bank Holidays - June 2024'),
        backgroundColor: Colors.lightBlue[100],
      ),
      body: ListView.builder(
        itemCount: apHoliday.length,
        itemBuilder: (context, index) {
          final holiday = apHoliday[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
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
            ),
          );
        },
      ),
    );
  }
}

class JulyHolidays extends StatelessWidget {
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
        title: Text('Indian Bank Holidays - July 2024'),
        backgroundColor: Colors.lightBlue[100],
      ),
      body: ListView.builder(
        itemCount: juHoliday.length,
        itemBuilder: (context, index) {
          final holiday = juHoliday[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
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
            ),
          );
        },
      ),
    );
  }
}

class AugustHolidays extends StatelessWidget {
  final List<Holiday> augHoliday = [
    Holiday(
      date: "8 August 2024, Thursday",
      holiday: "Tendong Lho Rum Faat",
      states: "Sikkim",
    ),
    Holiday(
      date: "12 August 2024, Monday",
      holiday: "Eid al-Adha",
      states: "Many states",
    ),
    Holiday(
      date: "12 August 2024, Monday",
      holiday: "Haryali Teej",
      states: "Haryana, Punjab",
    ),
    Holiday(
      date: "15 August 2024, Thursday",
      holiday: "Independence Day",
      states: "National",
    ),
    Holiday(
      date: "15 August 2024, Thursday",
      holiday: "Raksha Bandhan",
      states: "Many states",
    ),
    Holiday(
      date: "16 August 2024, Friday",
      holiday: "De Jure Transfer Day",
      states: "Puducherry",
    ),
    Holiday(
      date: "17 August 2024, Saturday",
      holiday: "Parsi New Year",
      states: "Maharashtra",
    ),
    Holiday(
      date: "24 August 2024, Saturday",
      holiday: "Janmashtami",
      states: "Many states",
    ),
    Holiday(
      date: "25 August 2024, Sunday",
      holiday: "Thiruvonam",
      states: "Kerala",
    ),
    Holiday(
      date: "26 August 2024, Monday",
      holiday: "Fourth Saturday",
      states: "Many states",
    ),
    Holiday(
      date: "29 August 2024, Thursday",
      holiday: "Parkash Utsav Sri Guru Granth Sahib Ji",
      states: "Punjab",
    ),
    Holiday(
      date: "30 August 2024, Friday",
      holiday: "Jumat-ul-Wida",
      states: "Jammu and Kashmir",
    ),
    Holiday(
      date: "31 August 2024, Saturday",
      holiday: "Onam",
      states: "Kerala",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Indian Bank Holidays - August 2024'),
        backgroundColor: Colors.lightBlue[100],
      ),
      body: ListView.builder(
        itemCount: augHoliday.length,
        itemBuilder: (context, index) {
          final holiday = augHoliday[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
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
            ),
          );
        },
      ),
    );
  }
}

class SeptemberHolidays extends StatelessWidget {
  final List<Holiday> sepHoliday = [
    Holiday(
      date: "1 September 2024, Sunday",
      holiday: "Parkash Utsav Sri Guru Granth Sahib Ji",
      states: "Punjab",
    ),
    Holiday(
      date: "2 September 2024, Monday",
      holiday: "Ganesh Chaturthi",
      states: "Many states",
    ),
    Holiday(
      date: "3 September 2024, Tuesday",
      holiday: "Nuakhai",
      states: "Odisha",
    ),
    Holiday(
      date: "6 September 2024, Friday",
      holiday: "Jamat Ul Vida",
      states: "Jammu and Kashmir",
    ),
    Holiday(
      date: "10 September 2024, Tuesday",
      holiday: "Muharram",
      states: "Many states",
    ),
    Holiday(
      date: "10 September 2024, Tuesday",
      holiday: "First Onam",
      states: "Kerala",
    ),
    Holiday(
      date: "11 September 2024, Wednesday",
      holiday: "Thiruvonam",
      states: "Kerala",
    ),
    Holiday(
      date: "12 September 2024, Thursday",
      holiday: "Sree Narayana Guru Jayanti",
      states: "Kerala",
    ),
    Holiday(
      date: "17 September 2024, Tuesday",
      holiday: "Mahalaya Amavasya",
      states: "West Bengal, Odisha, Tripura",
    ),
    Holiday(
      date: "23 September 2024, Monday",
      holiday: "Fourth Saturday",
      states: "Many states",
    ),
    Holiday(
      date: "28 September 2024, Saturday",
      holiday: "Maha Saptami",
      states: "West Bengal, Odisha",
    ),
    Holiday(
      date: "29 September 2024, Sunday",
      holiday: "Maha Ashtami",
      states: "Many states",
    ),
    Holiday(
      date: "30 September 2024, Monday",
      holiday: "Vijaya Dashami",
      states: "Many states",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Indian Bank Holidays - September 2024'),
        backgroundColor: Colors.lightBlue[100],
      ),
      body: ListView.builder(
        itemCount: sepHoliday.length,
        itemBuilder: (context, index) {
          final holiday = sepHoliday[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
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
            ),
          );
        },
      ),
    );
  }
}

class OctoberHolidays extends StatelessWidget {
  final List<Holiday> octHoliday = [
    Holiday(
      date: "2 October 2024, Wednesday",
      holiday: "Gandhi Jayanti",
      states: "National",
    ),
    Holiday(
      date: "5 October 2024, Saturday",
      holiday: "Maharaja Agrasen Jayanti",
      states: "Haryana, Punjab",
    ),
    Holiday(
      date: "7 October 2024, Monday",
      holiday: "Navaratri",
      states:
          "Gujarat, Himachal Pradesh, Kerala, Maharashtra, Punjab, Rajasthan, West Bengal",
    ),
    Holiday(
      date: "8 October 2024, Tuesday",
      holiday: "Mahanavami",
      states:
          "Himachal Pradesh, Kerala, Odisha, Sikkim, Tamil Nadu, West Bengal",
    ),
    Holiday(
      date: "8 October 2024, Tuesday",
      holiday: "Dussehra",
      states: "Many states",
    ),
    Holiday(
      date: "8 October 2024, Tuesday",
      holiday: "Vijaya Dashami",
      states: "Karnataka",
    ),
    Holiday(
      date: "9 October 2024, Wednesday",
      holiday: "Ayutha Pooja",
      states: "Karnataka, Tamil Nadu",
    ),
    Holiday(
      date: "9 October 2024, Wednesday",
      holiday: "Navami of Durga Puja",
      states: "Tripura",
    ),
    Holiday(
      date: "9 October 2024, Wednesday",
      holiday: "Maharishi Valmiki Jayanti",
      states: "Many states",
    ),
    Holiday(
      date: "13 October 2024, Sunday",
      holiday: "Kati Bihu",
      states: "Assam",
    ),
    Holiday(
      date: "17 October 2024, Thursday",
      holiday: "Karva Chauth",
      states: "Many states",
    ),
    Holiday(
      date: "20 October 2024, Sunday",
      holiday: "Laxmi Puja",
      states: "Odisha, Tripura, West Bengal",
    ),
    Holiday(
      date: "27 October 2024, Sunday",
      holiday: "Diwali",
      states: "Many states",
    ),
    Holiday(
      date: "28 October 2024, Monday",
      holiday: "Govardhan Puja",
      states: "Haryana, Punjab",
    ),
    Holiday(
      date: "29 October 2024, Tuesday",
      holiday: "Bhai Dooj",
      states: "Many states",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Indian Bank Holidays - October 2024'),
        backgroundColor: Colors.lightBlue[100],
      ),
      body: ListView.builder(
        itemCount: octHoliday.length,
        itemBuilder: (context, index) {
          final holiday = octHoliday[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
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
            ),
          );
        },
      ),
    );
  }
}

class NovemberHolidays extends StatelessWidget {
  final List<Holiday> novHoliday = [
    Holiday(
      date: "1 November 2024, Friday",
      holiday: "Kut Festival",
      states: "Manipur",
    ),
    Holiday(
      date: "2 November 2024, Saturday",
      holiday: "Ningol Chakkouba",
      states: "Manipur",
    ),
    Holiday(
      date: "6 November 2024, Wednesday",
      holiday: "Deepavali",
      states: "Many states",
    ),
    Holiday(
      date: "7 November 2024, Thursday",
      holiday: "Deepavali Holiday",
      states: "Many states",
    ),
    Holiday(
      date: "9 November 2024, Saturday",
      holiday: "Chhath Puja",
      states: "Bihar, Uttar Pradesh",
    ),
    Holiday(
      date: "10 November 2024, Sunday",
      holiday: "Chhath Puja Holiday",
      states: "Bihar, Uttar Pradesh",
    ),
    Holiday(
      date: "11 November 2024, Monday",
      holiday: "Wangala Festival",
      states: "Meghalaya",
    ),
    Holiday(
      date: "12 November 2024, Tuesday",
      holiday: "Guru Nanak's Birthday",
      states: "National except Goa, Odisha",
    ),
    Holiday(
      date: "13 November 2024, Wednesday",
      holiday: "Kanakadasa Jayanthi",
      states: "Karnataka",
    ),
    Holiday(
      date: "14 November 2024, Thursday",
      holiday: "Karthika Purnima",
      states: "Many states",
    ),
    Holiday(
      date: "14 November 2024, Thursday",
      holiday: "Kalam Narayana Guru Jayanthi",
      states: "Kerala",
    ),
    Holiday(
      date: "23 November 2024, Saturday",
      holiday: "Seng Kut Snem",
      states: "Meghalaya",
    ),
    Holiday(
      date: "24 November 2024, Sunday",
      holiday: "Lachit Divas",
      states: "Assam",
    ),
    Holiday(
      date: "24 November 2024, Sunday",
      holiday: "Guru Teg Bahadur's Martyrdom Day",
      states: "Jammu and Kashmir",
    ),
    Holiday(
      date: "25 November 2024, Monday",
      holiday: "Rasa Purnima",
      states: "Odisha",
    ),
    Holiday(
      date: "26 November 2024, Tuesday",
      holiday: "Kanakadasa Jayanti",
      states: "Karnataka",
    ),
    Holiday(
      date: "26 November 2024, Tuesday",
      holiday: "Seng Kutsnem",
      states: "Meghalaya",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Indian Bank Holidays - November 2024'),
        backgroundColor: Colors.lightBlue[100],
      ),
      body: ListView.builder(
        itemCount: novHoliday.length,
        itemBuilder: (context, index) {
          final holiday = novHoliday[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
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
            ),
          );
        },
      ),
    );
  }
}

class DecemberHolidays extends StatelessWidget {
  final List<Holiday> decHoliday = [
    Holiday(
      date: "2 December 2024, Monday",
      holiday: "Rashtriya Bhim Rao Ambedkar's Mahaparinirvan Diwas",
      states:
          "National except Goa, Manipur, Mizoram, Nagaland, Sikkim, Telangana",
    ),
    Holiday(
      date: "3 December 2024, Tuesday",
      holiday: "Feast of St. Francis Xavier",
      states: "Goa",
    ),
    Holiday(
      date: "6 December 2024, Friday",
      holiday: "Kanakadasa Jayanthi",
      states: "Karnataka",
    ),
    Holiday(
      date: "12 December 2024, Thursday",
      holiday: "Pa Togan Nengminza Sangma",
      states: "Meghalaya",
    ),
    Holiday(
      date: "12 December 2024, Thursday",
      holiday: "Teer Chapa",
      states: "Mizoram",
    ),
    Holiday(
      date: "13 December 2024, Friday",
      holiday: "Armed Forces Flag Day",
      states: "Nagaland",
    ),
    Holiday(
      date: "18 December 2024, Wednesday",
      holiday: "Death Anniversary of U SoSo Tham",
      states: "Meghalaya",
    ),
    Holiday(
      date: "19 December 2024, Thursday",
      holiday: "Goa Liberation Day",
      states: "Goa",
    ),
    Holiday(
      date: "25 December 2024, Wednesday",
      holiday: "Christmas Day",
      states: "Many states",
    ),
    Holiday(
      date: "27 December 2024, Friday",
      holiday: "Losoong/Namsoong",
      states: "Sikkim",
    ),
    Holiday(
      date: "30 December 2024, Monday",
      holiday: "U Kiang Nangbah",
      states: "Meghalaya",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Indian Bank Holidays - December 2024'),
        backgroundColor: Colors.lightBlue[100],
      ),
      body: ListView.builder(
        itemCount: decHoliday.length,
        itemBuilder: (context, index) {
          final holiday = decHoliday[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
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
            ),
          );
        },
      ),
    );
  }
}

class WeekendHolidays extends StatelessWidget {
  const WeekendHolidays({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Indian Bank Weekend Holidays - 2024'),
        backgroundColor: Colors.lightBlue[100],
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
                  DataCell(Text('8 Jan 2024')),
                  DataCell(Text('Second Saturday')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('22 Jan 2024')),
                  DataCell(Text('Fourth Saturday')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('12 Feb 2024')),
                  DataCell(Text('Second Saturday')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('26 Feb 2024')),
                  DataCell(Text('Fourth Saturday')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('11 Mar 2024')),
                  DataCell(Text('Second Saturday')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('25 Mar 2024')),
                  DataCell(Text('Fourth Saturday')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('8 Apr 2024')),
                  DataCell(Text('Second Saturday')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('22 Apr 2024')),
                  DataCell(Text('Fourth Saturday')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('13 May 2024')),
                  DataCell(Text('Second Saturday')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('27 May 2024')),
                  DataCell(Text('Fourth Saturday')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('10 Jun 2024')),
                  DataCell(Text('Second Saturday')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('24 Jun 2024')),
                  DataCell(Text('Fourth Saturday')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('8 Jul 2024')),
                  DataCell(Text('Second Saturday')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('22 Jul 2024')),
                  DataCell(Text('Fourth Saturday')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('12 Aug 2024')),
                  DataCell(Text('Second Saturday')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('26 Aug 2024')),
                  DataCell(Text('Fourth Saturday')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('9 Sep 2024')),
                  DataCell(Text('Second Saturday')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('23 Sep 2024')),
                  DataCell(Text('Fourth Saturday')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('14 Oct 2024')),
                  DataCell(Text('Second Saturday')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('28 Oct 2024')),
                  DataCell(Text('Fourth Saturday')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('11 Nov 2024')),
                  DataCell(Text('Second Saturday')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('25 Nov 2024')),
                  DataCell(Text('Fourth Saturday')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('9 Dec 2024')),
                  DataCell(Text('Second Saturday')),
                ]),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('23 Dec 2024')),
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

class LoanCalculatorPage extends StatefulWidget {
  @override
  _LoanCalculatorPageState createState() => _LoanCalculatorPageState();
}

class _LoanCalculatorPageState extends State<LoanCalculatorPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _pensionController = TextEditingController();
  final TextEditingController _tenureController = TextEditingController();
  String? _selectedLoanType;
  double _interestRate = 0.0;
  double _loanAmount = 0.0;
  double _emi = 0.0;
  int _tenureMonths = 0;
  double _processingFee = 0.0;

  void _calculateLoan() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        double principal = _loanAmount;
        double monthlyInterestRate = _interestRate / 12 / 100;
        double onePlusRPowerN =
            pow(1 + monthlyInterestRate, _tenureMonths) as double;
        _emi = principal *
            monthlyInterestRate *
            onePlusRPowerN /
            (onePlusRPowerN - 1);
      });
    }
  }

  void _setLoanDetails() {
    if (_selectedLoanType == 'Secured Loan for Salaried') {
      setState(() {
        double salary = double.tryParse(_salaryController.text) ?? 0.0;
        _loanAmount = salary * 20;
        _interestRate = 9.90;
        _tenureMonths = 7 * 12;
        _processingFee = _loanAmount * 0.01;
      });
    } else if (_selectedLoanType == 'Pension Loan') {
      setState(() {
        double pension = double.tryParse(_pensionController.text) ?? 0.0;
        _loanAmount = pension * 15;
        _interestRate = _tenureMonths <= 60 ? 10.15 : 10.40;
        _processingFee = _loanAmount * 0.01;
      });
    } else if (_selectedLoanType == 'Pre-Approved Loan') {
      setState(() {
        _loanAmount = double.tryParse(_salaryController.text) ?? 0.0;
        _interestRate = 11.40;
        _tenureMonths = int.tryParse(_tenureController.text) ?? 0;
        _processingFee = _loanAmount * 0.01;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'Indian Bank Loan Calculator',
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 250),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoanSchemeDetailPage()));
                  },
                  child: Text(
                    'Details here',
                    style: TextStyle(color: Colors.lightBlueAccent),
                  ),
                ),
              ),
              SizedBox(
                height: 150,
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Select Loan Type',
                  border: OutlineInputBorder(),
                ),
                items: [
                  DropdownMenuItem(
                    child: Text('Secured Loan for Salaried'),
                    value: 'Secured Loan for Salaried',
                  ),
                  DropdownMenuItem(
                    child: Text('Pension Loan'),
                    value: 'Pension Loan',
                  ),
                  DropdownMenuItem(
                    child: Text('Pre-Approved Loan'),
                    value: 'Pre-Approved Loan',
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedLoanType = value;
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select a loan type' : null,
              ),
              SizedBox(height: 16),
              if (_selectedLoanType == 'Secured Loan for Salaried')
                TextFormField(
                  controller: _salaryController,
                  decoration: InputDecoration(
                    labelText: 'Enter Gross Salary',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter your gross salary'
                      : null,
                ),
              if (_selectedLoanType == 'Pension Loan')
                TextFormField(
                  controller: _pensionController,
                  decoration: InputDecoration(
                    labelText: 'Enter Monthly Pension',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter your monthly pension'
                      : null,
                ),
              if (_selectedLoanType == 'Pension Loan' ||
                  _selectedLoanType == 'Pre-Approved Loan')
                TextFormField(
                  controller: _tenureController,
                  decoration: InputDecoration(
                    labelText: 'Enter Tenure (Months)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _tenureMonths = int.tryParse(value) ?? 0;
                    });
                  },
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter tenure in months'
                      : null,
                ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _setLoanDetails();
                  _calculateLoan();
                },
                child: Text('Calculate EMI'),
              ),
              SizedBox(height: 16),
              if (_emi > 0)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Loan Amount: $_loanAmount'),
                    Text('Interest Rate: $_interestRate%'),
                    Text('Tenure: $_tenureMonths months'),
                    Text(
                        'Processing Fee: ${_processingFee.toStringAsFixed(2)}'),
                    Text('EMI: ${_emi.toStringAsFixed(2)}'),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoanSchemeDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loan Schemes Details'),
      ),
      body: ListView.builder(
        itemCount: loanSchemes.length,
        itemBuilder: (context, index) {
          final scheme = loanSchemes[index];
          return Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    scheme.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Loan Amount: ${scheme.loanAmount}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Tenure: ${scheme.tenure}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Interest Rate: ${scheme.interestRate}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Special Details: ${scheme.specialDetails}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class LoanScheme {
  final String title;
  final String loanAmount;
  final String tenure;
  final String interestRate;
  final String specialDetails;

  LoanScheme({
    required this.title,
    required this.loanAmount,
    required this.tenure,
    required this.interestRate,
    required this.specialDetails,
  });
}

final List<LoanScheme> loanSchemes = [
  LoanScheme(
    title: 'Indian Bank Personal Loan for Salaried',
    loanAmount: '20x of the applicant\'s gross salary',
    tenure: 'Up to 7 years',
    interestRate: '9.90% - 10.40%',
    specialDetails: 'Processing Fee: 1% of the loan amount',
  ),
  LoanScheme(
    title: 'Indian Bank Pension Loan Scheme',
    loanAmount: 'Up to 15 times the monthly pension',
    tenure: 'Up to 10 years',
    interestRate: '10.15% - 10.40%',
    specialDetails: 'Processing Fee: Up to Rs. 25,000',
  ),
  LoanScheme(
    title: 'Pre-Approved Personal Loan',
    loanAmount: 'Varies',
    tenure: 'Varies',
    interestRate: '11.40%',
    specialDetails: 'Available for eligible customers',
  ),
];

class ExpenseTrackerAppIn extends StatelessWidget {
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
      home: ExpenseTrackerHomePageIn(),
    );
  }
}

class ExpenseTrackerHomePageIn extends StatefulWidget {
  @override
  _ExpenseTrackerHomePageState createState() => _ExpenseTrackerHomePageState();
}

class _ExpenseTrackerHomePageState extends State<ExpenseTrackerHomePageIn> {
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
