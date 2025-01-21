import 'package:flutter/material.dart';

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

  // Month names and values
  final List<Map<String, dynamic>> months = [
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

  @override
  void initState() {
    super.initState();

    // Initialize the scroll controller
    scrollController = ScrollController();

    // Get current date
    DateTime now = DateTime.now();

    // Initialize default selected month, year, and current day
    selectedMonth = months[now.month - 1]["name"];
    selectedYear = now.year;
    currentDay = now.day;

    // Generate the year list (current year ± 5 years)
    years = List.generate(11, (index) => now.year - 5 + index);

    // Scroll to the current day after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        (currentDay - 1) * 308.0, // Each item has a height of 300 + padding
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    });
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
                // Month Dropdown
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
                const SizedBox(width: 16), // Space between the two dropdowns
                // Year Dropdown
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
              itemCount: 31, // Assuming a maximum of 31 days in a month
              itemBuilder: (context, index) {
                int day = index + 1;
                bool isToday = (day == currentDay);

                return Container(
                  height: 300,
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: isToday ? Colors.green : Colors.grey,
                    ),
                    boxShadow: isToday ? [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.5),
                        offset: Offset(0, 2),
                        blurRadius: 4,
                      )
                    ] : [],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            "Day $day",
                            style: TextStyle(
                              color: isToday ? Colors.green : Colors.black,
                              fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
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
