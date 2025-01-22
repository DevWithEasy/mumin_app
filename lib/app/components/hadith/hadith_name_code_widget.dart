import 'package:flutter/material.dart';

class HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    final double width = size.width;
    final double height = size.height;
    // final double sideLength = width / 2;

    path.moveTo(width / 2, 0); // Top center
    path.lineTo(width, height / 4); // Top right
    path.lineTo(width, 3 * height / 4); // Bottom right
    path.lineTo(width / 2, height); // Bottom center
    path.lineTo(0, 3 * height / 4); // Bottom left
    path.lineTo(0, height / 4); // Top left
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class HexagonAvatar extends StatelessWidget {
  final String text;
  final Color color;
  const HexagonAvatar({required this.text, super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: HexagonClipper(),
      child: Container(
        color: color,
        width: 35,
        height: 40,
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
