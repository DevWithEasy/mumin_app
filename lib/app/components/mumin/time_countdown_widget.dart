import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';

class CountdownTimer extends StatefulWidget {
  final String startTime; // Start time in HH:mm format
  final String endTime;   // End time in HH:mm format

  const CountdownTimer({
    Key? key,
    required this.startTime,
    required this.endTime,
  }) : super(key: key);

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Duration duration;
  late Duration remainingTime;

  @override
  void initState() {
    super.initState();
    duration = _calculateDuration(widget.startTime, widget.endTime);
    remainingTime = duration;
    _controller = AnimationController(
      vsync: this,
      duration: duration,
    )..addListener(() {
        setState(() {
          remainingTime = _calculateRemainingTime();
        });
      });
    _controller.forward();
  }

  Duration _calculateDuration(String startTime, String endTime) {
    final format = DateFormat("HH:mm");
    final start = format.parse(startTime);
    final end = format.parse(endTime);

    return end.difference(start);
  }

  Duration _calculateRemainingTime() {
    return duration * (1 - _controller.value);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hours = remainingTime.inHours;
    final minutes = remainingTime.inMinutes % 60;
    final seconds = remainingTime.inSeconds % 60;

    return SizedBox(
      width: 100, // Compact widget size
      height: 100,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(90, 90), // Adjust circle size
            painter: CountdownPainter(
              animation: _controller,
              strokeWidth: 5,
              backgroundColor: Colors.grey.shade300,
              foregroundColor: Colors.green,
            ),
          ),
          Text(
            '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class CountdownPainter extends CustomPainter {
  final Animation<double> animation;
  final double strokeWidth;
  final Color backgroundColor;
  final Color foregroundColor;

  CountdownPainter({
    required this.animation,
    required this.strokeWidth,
    required this.backgroundColor,
    required this.foregroundColor,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    double progress = animation.value;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Draw the grey background circle
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, backgroundPaint);

    // Draw the green progress circle
    final foregroundPaint = Paint()
      ..color = foregroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    double startAngle = -pi / 2; // Start at the top
    double sweepAngle = 2 * pi * (1 - progress); // Decreasing animation
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}


// import 'package:flutter/material.dart';
// import 'dart:math';
// import 'package:intl/intl.dart';

// class CountdownTimer extends StatefulWidget {
//   final String startTime; // Start time in HH:mm format
//   final String endTime;   // End time in HH:mm format
//   final double strokeWidth; // Stroke width for the circle

//   const CountdownTimer({
//     Key? key,
//     required this.startTime,
//     required this.endTime,
//     this.strokeWidth = 8, // Default stroke width is 8
//   }) : super(key: key);

//   @override
//   _CountdownTimerState createState() => _CountdownTimerState();
// }

// class _CountdownTimerState extends State<CountdownTimer>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Duration duration;
//   late Duration remainingTime;

//   @override
//   void initState() {
//     super.initState();
//     _initializeTimer();
//   }

//   // Reinitialize the timer whenever the widget updates
//   @override
//   void didUpdateWidget(covariant CountdownTimer oldWidget) {
//     super.didUpdateWidget(oldWidget);

//     if (widget.startTime != oldWidget.startTime || widget.endTime != oldWidget.endTime) {
//       _initializeTimer(); // Reinitialize when the start or end time changes
//     }
//   }

//   void _initializeTimer() {
//     duration = _calculateDuration(widget.startTime, widget.endTime);
//     remainingTime = duration;
//     _controller = AnimationController(
//       vsync: this,
//       duration: duration,
//     )..addListener(() {
//         setState(() {
//           remainingTime = _calculateRemainingTime();
//         });
//       });
//     _controller.forward();
//   }

//   Duration _calculateDuration(String startTime, String endTime) {
//     final format = DateFormat("HH:mm");
//     final start = format.parse(startTime);
//     final end = format.parse(endTime);

//     return end.difference(start);
//   }

//   Duration _calculateRemainingTime() {
//     return duration * (1 - _controller.value);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final hours = remainingTime.inHours;
//     final minutes = remainingTime.inMinutes % 60;
//     final seconds = remainingTime.inSeconds % 60;

//     return SizedBox(
//       width: 100, // Compact widget size
//       height: 100,
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           CustomPaint(
//             size: Size(100, 100), // Adjust circle size
//             painter: CountdownPainter(
//               animation: _controller,
//               strokeWidth: widget.strokeWidth, // Use the strokeWidth passed in the widget
//               backgroundColor: Colors.grey.shade300,
//               foregroundColor: Colors.green,
//             ),
//           ),
//           Text(
//             '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CountdownPainter extends CustomPainter {
//   final Animation<double> animation;
//   final double strokeWidth;
//   final Color backgroundColor;
//   final Color foregroundColor;

//   CountdownPainter({
//     required this.animation,
//     required this.strokeWidth,
//     required this.backgroundColor,
//     required this.foregroundColor,
//   }) : super(repaint: animation);

//   @override
//   void paint(Canvas canvas, Size size) {
//     double progress = animation.value;

//     final center = Offset(size.width / 2, size.height / 2);
//     final radius = (size.width - strokeWidth) / 2;

//     // Draw the grey background circle
//     final backgroundPaint = Paint()
//       ..color = backgroundColor
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = strokeWidth;
//     canvas.drawCircle(center, radius, backgroundPaint);

//     // Draw the green progress circle
//     final foregroundPaint = Paint()
//       ..color = foregroundColor
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = strokeWidth
//       ..strokeCap = StrokeCap.round;
//     double startAngle = -pi / 2; // Start at the top
//     double sweepAngle = 2 * pi * (1 - progress); // Decreasing animation
//     canvas.drawArc(
//       Rect.fromCircle(center: center, radius: radius),
//       startAngle,
//       sweepAngle,
//       false,
//       foregroundPaint,
//     );
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }
