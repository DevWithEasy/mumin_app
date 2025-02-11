import 'package:flutter/material.dart';
import 'package:mumin/app/models/PrayerTimes.dart';
import 'package:mumin/app/services/prayer_service.dart';
import 'package:mumin/app/utils/convert_to_bangla_number.dart';

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
  List<PrayerTimes> _monthlyPrayerTimes = []; // Store fetched prayer times

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    DateTime now = DateTime.now();
    selectedMonth = months[now.month - 1]["name"];
    selectedYear = now.year;
    currentDay = now.day;
    years = List.generate(11, (index) => now.year - 5 + index);

    _loadData(now.month, now.year);
  }

  Future<void> _loadData(int month, int year) async {
    try {
      final data = await PrayerService.getMonthlyTimes(month, year);
      setState(() {
        _monthlyPrayerTimes = data;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollController.animateTo(
          (currentDay - 1) * 358.0,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      });
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
                          int selectedMonthValue = months.firstWhere(
                              (month) => month["name"] == newValue)["value"];
                          _loadData(selectedMonthValue, selectedYear);
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
                          int selectedMonthValue = months.firstWhere((month) =>
                              month["name"] == selectedMonth)["value"];
                          _loadData(selectedMonthValue, selectedYear);
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
            child: _monthlyPrayerTimes.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    controller: scrollController,
                    itemCount: _monthlyPrayerTimes.length,
                    padding: EdgeInsets.only(top: 5),
                    itemBuilder: (context, index) {
                      int day = index + 1;
                      bool isToday = (day == currentDay);
                      PrayerTimes prayerTimes = _monthlyPrayerTimes[index];

                      return Container(
                        height: 350,
                        margin: const EdgeInsets.only(
                            left: 8, right: 8, bottom: 12),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: isToday
                                ? Border.all(
                                    color: Colors.green,
                                    width: 1.5,
                                  )
                                : null,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                spreadRadius: 0.5,
                                blurRadius: 1,
                              )
                            ]),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      color: Colors.yellow.shade50,
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            prayerTimes.dayNumber(),
                                            style: TextStyle(
                                                fontSize: 30,
                                                color: Colors.blueGrey),
                                          ),
                                          Text(
                                              '${prayerTimes.engMonth()}, ${prayerTimes.engYear()}',
                                              style: TextStyle(
                                                  color: Colors.blueGrey)),
                                          Text(prayerTimes.dayName(),
                                              style: TextStyle(
                                                  color: Colors.blueGrey)),
                                          Text(
                                              '${prayerTimes.hijriDayNumber()} ${prayerTimes.hijriMonth()}, ${prayerTimes.hijriYear()}'),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    color: Colors.green.shade100,
                                    height: 90,
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            'সাহরি শেষঃ ${convertToBanglaNumbers(prayerTimes.sahri())}'),
                                        Text(
                                            'সাহরি শেষঃ ${convertToBanglaNumbers(prayerTimes.ifter())}'),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                color: Colors.green.shade50,
                                height: double.infinity,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: GridView.builder(
                                              itemCount: prayerTimes.calenderWaktTimes().length,
                                              physics: NeverScrollableScrollPhysics(),
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 3,
                                                  mainAxisSpacing: 8,
                                                  crossAxisSpacing: 8,
                                                  childAspectRatio: 1.5,
                                                ),
                                                itemBuilder:
                                                    (context, int index) {
                                                      var wakt = prayerTimes.calenderWaktTimes()[index];
                                                  return Column(
                                                    children: [
                                                      Text(
                                                        wakt['name']!
                                                      ),
                                                      Text(
                                                        wakt['start']!,
                                                        style: TextStyle(
                                                          color: Colors.blueGrey),
                                                      ),
                                                      Text(
                                                        wakt['end']!,
                                                        style: TextStyle(
                                                          color: Colors.blueGrey),
                                                      ),
                                                    ],
                                                  );
                                                }),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 90,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'সালাতের নিষিদ্ধ সময়',
                                            style: TextStyle(
                                              color: Colors.red,
                                            ),
                                          ),
                                          ...prayerTimes
                                              .restrictedTimes()
                                              .map((restrictedWakt) {
                                            return Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      restrictedWakt['name']!,
                                                    ),
                                                    SizedBox(width: 8),
                                                    Text(
                                                      restrictedWakt['time']!,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 2),
                                              ],
                                            );
                                          }).toList(),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
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
