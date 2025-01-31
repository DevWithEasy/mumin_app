import 'package:flutter/material.dart';
import 'package:mumin/app/models/dua/Dua.dart';

class DuaDetailsScreen extends StatefulWidget {
  final List<Dua> duaList;
  final int currentIndex;

  const DuaDetailsScreen({
    super.key,
    required this.currentIndex,
    required this.duaList,
  });

  @override
  State<DuaDetailsScreen> createState() => _DuaDetailsScreenState();
}

class _DuaDetailsScreenState extends State<DuaDetailsScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    // Initialize the PageController and set the initial page
    _pageController = PageController(initialPage: widget.currentIndex);
  }

  @override
  void dispose() {
    // Dispose of the PageController when the widget is removed
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        actions: [
          IconButton(
            icon: Icon(Icons.copy),
            onPressed: () {
              
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              
            },
          ),
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              
            },
          )
        ],
      ),
      body: PageView.builder(
        controller: _pageController, // Set the controller
        itemCount: widget.duaList.length,
        itemBuilder: (BuildContext context, int index) {
          final dua = widget.duaList[index];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                                  Text(
                    dua.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  if(dua.top.isNotEmpty)
                    Text(
                    dua.top,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    dua.arabic,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    dua.transliteration??"",
                    style: const TextStyle(
                      fontSize: 16
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    dua.translations,
                    style: const TextStyle(
                      fontSize: 16
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "রেফারেন্সঃ ${dua.reference.isNotEmpty ? dua.reference : 'N/A'}",
                    style: const TextStyle(fontSize: 16),
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
