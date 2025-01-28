import 'package:flutter/material.dart';
import 'package:mumin/app/models/Istighfer.dart';

class IsteghferDetailsScreen extends StatefulWidget {
  final List<Istighfer> isteghfers;
  final int currentIndex;

  const IsteghferDetailsScreen({
    super.key,
    required this.isteghfers,
    required this.currentIndex,
  });

  @override
  State<IsteghferDetailsScreen> createState() => _IsteghferDetailsScreenState();
}

class _IsteghferDetailsScreenState extends State<IsteghferDetailsScreen> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex; // Set initial index
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isteghfers[_currentIndex].name), // Dynamic AppBar title
      ),
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index; // Update index when page changes
          });
        },
        itemCount: widget.isteghfers.length,
        itemBuilder: (context, index) {
          final isteghfer = widget.isteghfers[index];
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isteghfer.name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    isteghfer.info,
                  ),
                  SizedBox(height: 8),
                  Text(
                    isteghfer.arabic,
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 8),
                                    Text(
                    isteghfer.translation
                  ),
                  SizedBox(height: 8),
                  Text(
                    isteghfer.bangla
                  ),
                  SizedBox(height: 8),
                  Text(
                    isteghfer.benifits.isNotEmpty ? isteghfer.benifits : ''
                  ),
                  SizedBox(height: 8),
                  Text(
                    "রেফারেন্সঃ ${isteghfer.reference}",
                    style: TextStyle(fontStyle: FontStyle.italic),
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