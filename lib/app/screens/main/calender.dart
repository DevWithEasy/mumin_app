import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  late String selectedMonth;
  late int selectedYear;
  late int currentDay;
  late ScrollController scrollController;

  List<Map<String, dynamic>> months = [
    {"name": "January", "value": 1},
    {"name": "February", "value": 2},
    {"name": "March", "value": 3},
    {"name": "April", "value": 4},
    {"name": "May", "value": 5},
    {"name": "June", "value": 6},
    {"name": "July", "value": 7},
    {"name": "August", "value": 8},
    {"name": "September", "value": 9},
    {"name": "October", "value": 10},
    {"name": "November", "value": 11},
    {"name": "December", "value": 12},
  ];

  late List<int> years;
  List<dynamic> prayerTimes = []; // Store fetched prayer times

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    DateTime now = DateTime.now();
    selectedMonth = months[now.month - 1]["name"];
    selectedYear = now.year;
    currentDay = now.day;
    years = List.generate(11, (index) => now.year - 5 + index);

    fetchMonthlyTimes(now.month, now.year);
  }

  Future<void> fetchMonthlyTimes(int month, int year) async {
    try {
      final String latitude = "23.8103"; // Example latitude (Dhaka)
      final String longitude = "90.4125"; // Example longitude (Dhaka)
      final String country = "Bangladesh";
      final String city = "Dhaka";

      final String apiUrl =
          'https://api.aladhan.com/v1/calendarByCity?city=$city&country=$country&method=2&month=$month&year=$year';

      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          prayerTimes = data["data"];
        });

        // Scroll to current day after data is loaded
        WidgetsBinding.instance.addPostFrameCallback((_) {
          scrollController.animateTo(
            (currentDay - 1) * 308.0, // Adjust height if necessary
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
        });
      } else {
        throw Exception("Failed to fetch prayer times.");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedMonth,
                        onChanged: (newValue) {
                          setState(() {
                            selectedMonth = newValue!;
                          });
                          int selectedMonthValue = months
                              .firstWhere((month) => month["name"] == newValue)["value"];
                          fetchMonthlyTimes(selectedMonthValue, selectedYear);
                        },
                        isExpanded: true,
                        items: months.map((month) {
                          return DropdownMenuItem<String>(
                            value: month["name"] as String,
                            child: Text(month["name"] as String),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        value: selectedYear,
                        onChanged: (newValue) {
                          setState(() {
                            selectedYear = newValue!;
                          });
                          int selectedMonthValue = months
                              .firstWhere((month) => month["name"] == selectedMonth)["value"];
                          fetchMonthlyTimes(selectedMonthValue, selectedYear);
                        },
                        isExpanded: true,
                        items: years.map((year) {
                          return DropdownMenuItem<int>(
                            value: year,
                            child: Text(year.toString()),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: prayerTimes.length,
              itemBuilder: (context, index) {
                int day = index + 1;
                bool isToday = (day == currentDay);
                Map<String, dynamic> timings = prayerTimes[index]["timings"];

                return Container(
                  height: 300,
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: isToday ? Colors.green : Colors.grey,
                    ),
                    boxShadow: isToday
                        ? [
                            BoxShadow(
                              color: Colors.green.withOpacity(0.5),
                              offset: Offset(0, 2),
                              blurRadius: 4,
                            )
                          ]
                        : [],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Day $day",
                        style: TextStyle(
                          color: isToday ? Colors.green : Colors.black,
                          fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 10),
                      prayerTimes.isNotEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Fajr: ${timings['Fajr']}"),
                                Text("Dhuhr: ${timings['Dhuhr']}"),
                                Text("Asr: ${timings['Asr']}"),
                                Text("Maghrib: ${timings['Maghrib']}"),
                                Text("Isha: ${timings['Isha']}"),
                              ],
                            )
                          : const Center(child: CircularProgressIndicator()),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
