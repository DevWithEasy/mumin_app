import 'package:flutter/material.dart';

class IstighfarScreen extends StatefulWidget {
  const IstighfarScreen({super.key});

  @override
  State<IstighfarScreen> createState() => _IstighfarScreenState();
}

class _IstighfarScreenState extends State<IstighfarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Istighfar'),
      ),
      body: const Center(
        child: Text('Istighfar'),
      ),
    );
  }
}