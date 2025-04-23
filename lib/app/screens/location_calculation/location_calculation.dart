import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mumin/app/services/shared_data.dart';

class LocationCalculation extends StatefulWidget {
  const LocationCalculation({super.key});

  @override
  State<LocationCalculation> createState() => _LocationCalculationState();
}

class _LocationCalculationState extends State<LocationCalculation> {
  List<dynamic> _methods = [];
  int _method = 1;
  int _school = 1;

  Future<void> _loadData() async {
    try {
      final String jsonString =
      await rootBundle.loadString('assets/data/calculation_methods.json');
      final List<dynamic> jsonData = jsonDecode(jsonString);

      final savedMethod = await SharedData.getInt('method') ?? 1;
      final savedSchool = await SharedData.getInt('school') ?? 1;
      setState(() {
        _methods = jsonData;
        _method = savedMethod;
        _school = savedSchool;
      });
    } catch (e) {
      print('Error loading or parsing JSON: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('ক্যালকুলেশন ম্যাথড'),
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('ম্যাথড সিলেক্ট করুন'),
            DropdownButtonFormField<int>(
              isExpanded: true,
              value: _method,
              decoration: InputDecoration(
                labelText: "আপনার ম্যাথড",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                  const BorderSide(color: Colors.blue, width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                  const BorderSide(color: Colors.grey, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                  const BorderSide(color: Colors.blue, width: 2),
                ),
              ),
              hint: const Text('আপনার ম্যাথড'),
              items: _methods.map((method) {
                return DropdownMenuItem<int>(
                  value: method['id'],
                  child: Text(method['name']),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _method = value!;
                });
              },
            ),
            SizedBox(height: 8),
            Text('মাজহাব সিলেক্ট করুন'),
            SizedBox(height: 8),
            DropdownButtonFormField<int>(
              isExpanded: true,
              value: _method,
              decoration: InputDecoration(
                labelText: "আপনার মাজহাব",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                  const BorderSide(color: Colors.blue, width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                  const BorderSide(color: Colors.grey, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                  const BorderSide(color: Colors.blue, width: 2),
                ),
              ),
              hint: const Text('আপনার মাজহাব'),
              items: [
            DropdownMenuItem<int>(
            value: 0,
              child: Text('Shafi, Maliki, Hanbali'),
            ),
                DropdownMenuItem<int>(
                  value: 1,
                  child: Text('Hanafi'),
                )
              ],
              onChanged: (value) {
                setState(() {
                  _method = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
