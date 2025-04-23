import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mumin/app/components/tasbih/tasbih_bottom_sheet.dart';
import 'package:mumin/app/services/shared_data.dart';
import 'package:mumin/app/utils/convert_to_bangla_number.dart';
import 'package:vibration/vibration.dart';

class TasbihScreen extends StatefulWidget {
  const TasbihScreen({super.key});

  @override
  State<TasbihScreen> createState() => _TasbihScreenState();
}

class _TasbihScreenState extends State<TasbihScreen>
    with SingleTickerProviderStateMixin {
  int _counter = 0;
  int _targetCounter = 100;
  String _mode = "volume_off";
  TextEditingController _tragetEditingController = TextEditingController();
  late AnimationController _animationController;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 0.5,
      upperBound: 0.7,
    );
    _preloadSound();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _preloadSound() async {
    await _audioPlayer.setSource(AssetSource('audio/tasbih_click_sound.mp3'));
  }

  void _incrementCounter() async {
    setState(() {
      _counter++;
    });
    SharedData.setInt('counter', _counter);
    if (_mode == 'volume_off') {
      return;
    } else if (_mode == 'volume_up') {
      await _audioPlayer.play(AssetSource('audio/tasbih_click_sound.mp3'));
    } else {
      if (await Vibration.hasVibrator()) {
        Vibration.vibrate(duration: 100);
      }
    }
    _animationController.forward(from: 0.2);
  }

  void _setTargetCounter() {
    int value = int.parse(_tragetEditingController.text);
    if (value < 0) {
      return;
    } else {
      SharedData.setInt('tasbih_target_value', value);
      setState(() {
        _targetCounter = int.parse(_tragetEditingController.text);
      });
      Navigator.pop(context);
    }
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  void _modeChange(String mode) {
    setState(() {
      _mode = mode;
    });
  }

  void _openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
          ),
          child: DraggableScrollableSheet(
            initialChildSize: 0.66,
            minChildSize: 0.66,
            maxChildSize: 0.95,
            builder: (BuildContext context, ScrollController scrollController) {
              return TasbihBottomSheet(scrollController: scrollController);
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "তাসবিহ গণনা",
        ),
        elevation: 1,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
                // border: Border(
                //   bottom: BorderSide(
                //     color: Colors.grey,
                //     width: 1.0,
                //   ),
                // ),
                ),
            child: Row(
              children: [
                Icon(Icons.info),
                SizedBox(width: 32),
                Expanded(
                  child: Center(
                      child: TextButton.icon(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    0), // Set your desired radius
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('বাতিল'),
                                ),
                                TextButton(
                                  onPressed: _setTargetCounter,
                                  child: Text('সেট করুন'),
                                ),
                              ],
                              title: Text(
                                'আপনার টার্গেট লিখুন',
                                style: TextStyle(fontSize: 16),
                              ),
                              content: Container(
                                height: 50,
                                child: TextField(
                                  expands: false,
                                  controller: _tragetEditingController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    // contentPadding: EdgeInsets.symmetric(vertical: 24)// Border style
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                    icon: Icon(
                      Icons.border_color,
                      size: 16,
                      color: Colors.black,
                    ),
                    iconAlignment: IconAlignment.end,
                    label: Text(
                        convertToBanglaNumbers(_targetCounter.toString()),
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  )),
                ),
                InkWell(onTap: _resetCounter, child: Icon(Icons.refresh)),
                SizedBox(width: 8),
                _mode == 'volume_off'
                    ? InkWell(
                        onTap: () => _modeChange('volume_up'),
                        child: Icon(Icons.volume_off, color: Colors.teal))
                    : _mode == 'vibration'
                        ? InkWell(
                            onTap: () => _modeChange('volume_off'),
                            child: Icon(Icons.vibration, color: Colors.teal))
                        : InkWell(
                            onTap: () => _modeChange('vibration'),
                            child: Icon(Icons.volume_up, color: Colors.teal))
              ],
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: _incrementCounter,
              child: Container(
                color: Colors.transparent,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 150,
                          height: 150,
                          child: CircularProgressIndicator(
                            value: 1.0, // Always full for the target
                            strokeWidth: 10,
                            backgroundColor: Colors.grey[300], // Static border
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.grey.shade200),
                          ),
                        ),
                        // Inner Circle - Represents the current counter progress
                        SizedBox(
                          width: 150,
                          height: 150,
                          child: CircularProgressIndicator(
                            value: _counter /
                                _targetCounter.clamp(1, _targetCounter),
                            strokeWidth: 10,
                            backgroundColor: Colors.transparent,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.teal),
                          ),
                        ),
                        // Counter Text (without animation)
                        Text(
                          convertToBanglaNumbers('$_counter'),
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text('যেকোনো জায়গায় ট্যাপ করুন',
                        style: TextStyle(color: Colors.grey.shade500)),
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              _openBottomSheet(context); // Open the bottom sheet
            },
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(16)),
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Center(child: Text('জিকির সমূহ')),
            ),
          ),
        ],
      ),
    );
  }
}
