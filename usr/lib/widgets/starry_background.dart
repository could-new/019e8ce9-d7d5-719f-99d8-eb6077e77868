import 'dart:math';
import 'package:flutter/material.dart';

class StarryBackground extends StatefulWidget {
  final Widget child;

  const StarryBackground({Key? key, required this.child}) : super(key: key);

  @override
  _StarryBackgroundState createState() => _StarryBackgroundState();
}

class _StarryBackgroundState extends State<StarryBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final int _starCount = 100;
  final List<Star> _stars = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    for (int i = 0; i < _starCount; i++) {
      _stars.add(Star(
        x: _random.nextDouble(),
        y: _random.nextDouble(),
        size: _random.nextDouble() * 2 + 1,
        speed: _random.nextDouble() * 0.05 + 0.01,
        brightness: _random.nextDouble(),
      ));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF0D0221),
                Color(0xFF1E103C),
                Color(0xFF261A4E),
              ],
            ),
          ),
        ),
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              painter: StarPainter(stars: _stars, animationValue: _controller.value),
              size: Size.infinite,
            );
          },
        ),
        SafeArea(child: widget.child),
      ],
    );
  }
}

class Star {
  final double x;
  final double y;
  final double size;
  final double speed;
  final double brightness;

  Star({required this.x, required this.y, required this.size, required this.speed, required this.brightness});
}

class StarPainter extends CustomPainter {
  final List<Star> stars;
  final double animationValue;

  StarPainter({required this.stars, required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;

    for (var star in stars) {
      final double twinkle = (sin((animationValue + star.brightness) * 2 * pi * 5) + 1) / 2;
      paint.color = Colors.white.withOpacity(0.3 + (twinkle * 0.7));

      final double currentY = (star.y + (animationValue * star.speed)) % 1.0;

      canvas.drawCircle(
        Offset(star.x * size.width, currentY * size.height),
        star.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant StarPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
