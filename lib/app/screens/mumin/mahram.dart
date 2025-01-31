import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mumin/app/models/Mahram.dart';

class MahramScreen extends StatefulWidget {
  const MahramScreen({super.key});

  @override
  State<MahramScreen> createState() => _MarhamScreenState();
}

class _MarhamScreenState extends State<MahramScreen> with TickerProviderStateMixin {
  List<Mahram> _mahrams = [];
  late TabController _tabController;

  Future<void> _loadData() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/data/mahram.json');
      final List<dynamic> jsonData = jsonDecode(jsonString);
      
      setState(() {
        _mahrams = jsonData.map((json) => Mahram.fromJson(json)).toList();
        // Dispose old controller before creating new one
        _tabController.dispose();
        _tabController = TabController(length: _mahrams.length, vsync: this);
      });
    } catch (e) {
      print('Error loading or parsing JSON: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    // Initialize with a default value
    _tabController = TabController(length: 1, vsync: this);
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('মাহরাম'),
        bottom: TabBar(
          controller: _tabController,
          tabs: _mahrams.isEmpty 
              ? [const Tab(text: 'Loading...')]
              : [
                  for (final mahram in _mahrams)
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            mahram.image,
                            width: 25,
                            height: 25,
                          ),
                          const SizedBox(width: 10),
                          Text(mahram.gender),
                        ],
                      ),
                    )
                ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _mahrams.isEmpty
            ? [const Center(child: CircularProgressIndicator())]
            : [
                for (final mahram in _mahrams)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: mahram.list.length,
                      itemBuilder: (context, index) {
                        final item = mahram.list[index];
                        return ListTile(
                          title: Text(item.name),
                          trailing: item.isMarham
                              ? const Icon(Icons.check_circle, color: Colors.green)
                              : const Icon(Icons.cancel, color: Colors.red),
                          shape: Border(bottom: BorderSide(color: Colors.grey.shade300)),
                        );
                      },
                    ),
                  )
              ],
      ),
    );
  }
}