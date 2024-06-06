import 'dart:convert';
import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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

class Sbi extends StatelessWidget {
  final List<GridItem> gridItems;

  Sbi() : gridItems = [] {
    _initializeGridItems();
  }

  void _initializeGridItems() {
    gridItems.addAll(
      [
        GridItem(
          imagePath: 'images/balance.png',
          buttonText: 'Balance Check',
          onPressed: (context) async {
            await _launchDialer('09223766666');
          },
          iconData: Icons.phone,
        ),
        GridItem(
          imagePath: 'images/mini.png',
          buttonText: 'Mini Statement',
          onPressed: (context) async {
            await _launchDialer('09223866666');
          },
          iconData: Icons.phone,
        ),
        GridItem(
          imagePath: 'images/blockatm.png',
          buttonText: 'Block ATM',
          onPressed: (context) async {
            await _launchDialer('1800112211');
          },
          iconData: Icons.phone,
        ),
        GridItem(
          imagePath: 'images/custem.png',
          buttonText: 'Customer Care',
          onPressed: (context) async {
            await _launchDialer('18004253800');
          },
          iconData: Icons.phone,
        ),
        GridItem(
          imagePath: 'images/nearbylocation.png',
          buttonText: 'SBI ATM',
          onPressed: (context) {
            _launchGoogleMaps(destination: 'near sbi ATM');
          },
          iconData: Icons.location_pin,
        ),
        GridItem(
          imagePath: 'images/banknear.png',
          buttonText: 'SBI Bank',
          onPressed: (context) {
            _launchGoogleMaps(destination: 'near sbi bank');
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
                builder: (context) => LoanCalculator(),
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
                'WELCOME TO SBI !',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Image.asset(
                'images/sbi.png',
                scale: 45,
              ),
            ],
          ),
        ),
        backgroundColor: Colors.lightBlue[100],
      ),
      backgroundColor: const Color.fromARGB(255, 217, 234, 242),
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
                          onPressed: () async {
                            await item.onPressed(context);
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
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

  Future<void> _launchDialer(String phoneNumber) async {
    final Uri phoneLaunchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await Permission.phone.request().isGranted) {
      if (await canLaunchUrl(phoneLaunchUri)) {
        await launchUrl(phoneLaunchUri);
      } else {
        throw 'Could not launch $phoneLaunchUri';
      }
    } else {
      throw 'Phone permission not granted';
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
                context, MaterialPageRoute(builder: (context) => march()));
          },
          iconData: Icons.date_range_outlined,
        ),
        HolidayGridItem(
          buttonText: 'April',
          onPressed: (context) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => april()));
          },
          iconData: Icons.date_range_outlined,
        ),
        HolidayGridItem(
          buttonText: 'May',
          onPressed: (context) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => may()));
          },
          iconData: Icons.date_range_outlined,
        ),
        HolidayGridItem(
          buttonText: 'June',
          onPressed: (context) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => june()));
          },
          iconData: Icons.date_range_outlined,
        ),
        HolidayGridItem(
          buttonText: 'July',
          onPressed: (context) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => july()));
          },
          iconData: Icons.date_range_outlined,
        ),
        HolidayGridItem(
          buttonText: 'August',
          onPressed: (context) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => augest()));
          },
          iconData: Icons.date_range_outlined,
        ),
        HolidayGridItem(
          buttonText: 'September',
          onPressed: (context) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => september()));
          },
          iconData: Icons.date_range_outlined,
        ),
        HolidayGridItem(
          buttonText: 'October',
          onPressed: (context) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => october()));
          },
          iconData: Icons.date_range_outlined,
        ),
        HolidayGridItem(
          buttonText: 'November',
          onPressed: (context) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => november()));
          },
          iconData: Icons.date_range_outlined,
        ),
        HolidayGridItem(
          buttonText: 'December',
          onPressed: (context) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => december()));
          },
          iconData: Icons.date_range_outlined,
        ),
        HolidayGridItem(
          buttonText: 'WEEK-END',
          onPressed: (context) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => week()));
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
        backgroundColor: Colors.lightBlue[200],
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
        title: Text('State Bank holiday - January 2024'),
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
        title: Text('State Bank holiday - February 2024'),
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
        title: Text('State Bank holiday - March 2024'),
        backgroundColor: Colors.lightBlue[100],
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
        title: Text('State Bank holiday - April 2024'),
        backgroundColor: Colors.lightBlue[100],
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
        title: Text('State Bank holiday - May 2024'),
        backgroundColor: Colors.lightBlue[100],
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
        title: Text('State Bank holiday - JUNE 2024'),
        backgroundColor: Colors.lightBlue[100],
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
        title: Text('State Bank holiday - JULY 2024'),
        backgroundColor: Colors.lightBlue[100],
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
        title: Text('State Bank holiday - AUGUST 2024'),
        backgroundColor: Colors.lightBlue[100],
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
        title: Text('State Bank holiday - SEPTEMBER 2024'),
        backgroundColor: Colors.lightBlue[100],
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
        title: Text('State Bank holiday - OCTOBER 2024'),
        backgroundColor: Colors.lightBlue[100],
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
        title: Text('State Bank holiday - NOVEMBER 2024'),
        backgroundColor: Colors.lightBlue[100],
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
        title: Text('State Bank holiday - DECEMER 2024'),
        backgroundColor: Colors.lightBlue[100],
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
        title: Text('State Bank holiday - WEEEK-END 2024'),
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

class LoanCalculator extends StatefulWidget {
  @override
  _LoanCalculatorState createState() => _LoanCalculatorState();
}

class _LoanCalculatorState extends State<LoanCalculator> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _yearsController = TextEditingController();

  double _interestRate = 0.0;
  double _emi = 0.0;

  final List<String> _schemes = [
    'Xpress Credit - Defence/Police',
    'Xpress Credit - Govt./CPSEs',
    'Xpress Credit - Other Corporates',
    'Xpress Elite - SBI Salary Account',
    'Xpress Elite - Other Bank Salary Account',
    'Xpress Flexi',
    'Xpress Lite',
    'Quick Personal Loan',
    'Xpress Credit Insta Top-Up',
    'Pre-Approved Personal Loans',
    'Pension Loan Schemes',
  ];

  final Map<String, List<double>> _interestRates = {
    'Xpress Credit - Defence/Police': [11.15, 12.65],
    'Xpress Credit - Govt./CPSEs': [11.30, 13.80],
    'Xpress Credit - Other Corporates': [12.30, 14.30],
    'Xpress Elite - SBI Salary Account': [11.15, 11.65],
    'Xpress Elite - Other Bank Salary Account': [11.40, 11.90],
    'Xpress Flexi': [11.40, 13.80],
    'Xpress Lite': [12.15, 14.80],
    'Quick Personal Loan': [11.40, 14.80],
    'Xpress Credit Insta Top-Up': [12.40, 12.40],
    'Pre-Approved Personal Loans': [13.80, 14.30],
    'Pension Loan Schemes': [11.30, 11.80],
  };

  String _selectedScheme = 'Xpress Credit - Defence/Police';

  void _calculateEMI() {
    if (_formKey.currentState!.validate()) {
      double principal = double.parse(_amountController.text);
      int years = int.parse(_yearsController.text);
      double annualInterestRate = _interestRates[_selectedScheme]![0];
      double monthlyInterestRate = annualInterestRate / 12 / 100;
      int totalMonths = years * 12;

      double emi = principal *
          monthlyInterestRate *
          (pow(1 + monthlyInterestRate, totalMonths) /
              (pow(1 + monthlyInterestRate, totalMonths) - 1));

      setState(() {
        _emi = emi;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'SBI Loan Interest Calculator',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.lightBlue.shade100,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
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
                height: 10 * 10,
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Select Loan Scheme'),
                value: _selectedScheme,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedScheme = newValue!;
                  });
                },
                items: _schemes.map((String scheme) {
                  return DropdownMenuItem<String>(
                    value: scheme,
                    child: Text(scheme),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Loan Amount'),
                keyboardType: TextInputType.number,
                controller: _amountController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter loan amount';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Loan Tenure (Years)'),
                keyboardType: TextInputType.number,
                controller: _yearsController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter loan tenure';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 60,
                width: 10,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.lightBlue),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  onPressed: _calculateEMI,
                  child: Text(
                    'Calculate EMI',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                _emi == 0.0
                    ? 'EMI will be displayed here'
                    : 'Your EMI is: $_emi',
                style: TextStyle(fontSize: 20),
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
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Spread over 2-year MCLR: ${scheme.spreadOverMCLR}',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Effective Interest Rate with No Reset: ${scheme.effectiveInterestRate}',
                    style: TextStyle(fontSize: 14),
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
  final String spreadOverMCLR;
  final String effectiveInterestRate;

  LoanScheme({
    required this.title,
    required this.spreadOverMCLR,
    required this.effectiveInterestRate,
  });
}

final List<LoanScheme> loanSchemes = [
  LoanScheme(
    title:
        'I. XPRESS CREDIT SCHEME [including Pre-Approved Xpress Credit (PAXC)/ RTXC/ RMP Xpress Credit]',
    spreadOverMCLR:
        'Applicants of Defence/ Central Armed Police/ Indian Coast Guard: 2.40% - 3.90% \nApplicants of Central Govt./ State Govt./ Police / Railway/ Central Public Sector Enterprises (CPSEs) Considered Under ‘RATNA’ Status: 2.55% - 5.05% \nApplicants of Other Corporates: 4.55% - 5.55%',
    effectiveInterestRate:
        'Applicants of Defence/ Central Armed Police/ Indian Coast Guard: 11.15% - 12.65% \nApplicants of Central Govt./ State Govt./ Police / Railway/ Central Public Sector Enterprises (CPSEs) Considered Under ‘RATNA’ Status: 11.30% - 13.80% \nApplicants of Other Corporates: 12.30% - 14.30%',
  ),
  LoanScheme(
    title: 'II. XPRESS ELITE SCHEME (including RTXC Elite)',
    spreadOverMCLR:
        'Salary Account with SBI: 2.40% - 2.90% \nSalary Account with another Bank: 2.65% - 3.15%',
    effectiveInterestRate:
        'Salary Account with SBI: 11.15% - 11.65% \nSalary Account with another Bank: 11.40% - 11.90%',
  ),
  LoanScheme(
    title: 'III. XPRESS FLEXI SCHEME (Overdraft Facility)',
    spreadOverMCLR:
        '0.25% higher than I. Xpress Credit scheme for Diamond Salary Package customers and II. Xpress Elite scheme for Platinum Salary Package customers',
    effectiveInterestRate: 'Depends on the specific package',
  ),
  LoanScheme(
    title: 'IV. XPRESS LITE SCHEME',
    spreadOverMCLR: '1% higher than I. Xpress Credit scheme for all brackets',
    effectiveInterestRate: 'Depends on the specific bracket',
  ),
  LoanScheme(
    title:
        'V. SBI QUICK PERSONAL LOAN SCHEME THROUGH CLP PORTAL (i.e., https://www.sbiloansin59minutes.com)',
    spreadOverMCLR:
        '0.25% higher than I. Xpress Credit Scheme for all Brackets',
    effectiveInterestRate: 'Depends on the specific bracket',
  ),
  LoanScheme(
    title: 'VI. XPRESS CREDIT INSTA TOP-UP LOANS',
    spreadOverMCLR: '3.65%',
    effectiveInterestRate: '12.40%',
  ),
  LoanScheme(
    title: 'VII. PRE-APPROVED PERSONAL LOANS (PAPL) TO NON-CSP CUSTOMERS',
    spreadOverMCLR: '5.05% - 5.55%',
    effectiveInterestRate: '13.80% - 14.30%',
  ),
  LoanScheme(
    title: 'VIII. PENSION LOAN SCHEMES',
    spreadOverMCLR: 'Mean ROI for Pension Loan (Q3 FY24): 11.33%',
    effectiveInterestRate: 'Depends on the specific pension loan scheme',
  ),
];

class walletMyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Wallet',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WalletHomePage(),
    );
  }
}

class WalletHomePage extends StatefulWidget {
  @override
  _WalletHomePageState createState() => _WalletHomePageState();
}

class _WalletHomePageState extends State<WalletHomePage> {
  TextEditingController incomeController = TextEditingController();
  TextEditingController expenseController = TextEditingController();
  String calculationType = 'Weekly';
  double income = 0.0;
  double balance = 0.0;
  double totalExpenses = 0.0;
  List<Map<String, dynamic>> expenses = [];
  Timer? timer;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    final initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final initializationSettingsIOS = DarwinInitializationSettings();
    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    timer?.cancel();
    int durationInSeconds =
        calculationType == 'Weekly' ? 7 * 24 * 60 * 60 : 30 * 24 * 60 * 60;
    timer = Timer(Duration(seconds: durationInSeconds), () {
      _showNotification(
          'End of $calculationType period! Total Expenses: ₹$totalExpenses');
      resetExpenses();
    });
  }

  void resetExpenses() {
    setState(() {
      totalExpenses = 0.0;
      expenses.clear();
      balance = income;
    });
  }

  Future<void> _showNotification(String message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('your_channel_id', 'your_channel_name',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails();
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'My Wallet', message, platformChannelSpecifics);
  }

  void addExpense(double expense, DateTime date) {
    setState(() {
      totalExpenses += expense;
      balance = income - totalExpenses;
      expenses.add({
        'expense': expense,
        'date': date,
      });
    });
  }

  void calculateBalance() {
    setState(() {
      income = double.tryParse(incomeController.text) ?? 0.0;
      balance = income - totalExpenses;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Wallet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            DropdownButton<String>(
              value: calculationType,
              onChanged: (String? newValue) {
                setState(() {
                  calculationType = newValue!;
                  startTimer();
                });
              },
              items: <String>['Weekly', 'Monthly']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            TextField(
              controller: incomeController,
              decoration: InputDecoration(
                labelText: 'Enter your income',
                prefixIcon: Icon(Icons.attach_money),
                prefixText: '₹ ',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                calculateBalance();
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  final expense = expenses[index];
                  return ListTile(
                    title: Text('₹${expense['expense']}'),
                    subtitle: Text(
                      'Date: ${expense['date'].toLocal().toString().split(' ')[0]}',
                    ),
                  );
                },
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: expenseController,
                    decoration: InputDecoration(
                      labelText: 'Enter expense',
                      prefixIcon: Icon(Icons.money_off),
                      prefixText: '₹ ',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    double expense =
                        double.tryParse(expenseController.text) ?? 0.0;
                    addExpense(expense, DateTime.now());
                    expenseController.clear();
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Balance: ₹$balance',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
