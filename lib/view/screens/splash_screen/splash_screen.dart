import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../routes/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _rippleController;
  late AnimationController _circleController;

  @override
  void initState() {
    super.initState();

    // Ripple controller (rings expand and loop)
    _rippleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();

    // Top/bottom background circle motion
    _circleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(reverse: true);

    // Navigate after a short delay (keep your desired timing)
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, Routes.bottomNavigationBar);
    });
  }

  @override
  void dispose() {
    _rippleController.dispose();
    _circleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF78520),
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Background big animated circles (unchanged)
          AnimatedBuilder(
            animation: _circleController,
            builder: (context, child) {
              final progress = _circleController.value;
              return Stack(
                children: [
                  Positioned(
                    top: -size.height * 0.35,
                    left: lerpDouble(
                      -size.width * 0.8,
                      -size.width * 0.1,
                      progress,
                    )!,
                    child: _buildCircle(
                      size.width * 1.35,
                      const Color(0xFFFF9A3E),
                    ),
                  ),
                  Positioned(
                    bottom: -size.height * 0.35,
                    right: lerpDouble(
                      -size.width * 0.8,
                      -size.width * 0.1,
                      progress,
                    )!,
                    child: _buildCircle(
                      size.width * 1.35,
                      const Color(0xFFFFB85A),
                    ),
                  ),
                ],
              );
            },
          ),

          // Ripple bands (soft filled rings) - ON TOP of background
          AnimatedBuilder(
            animation: _rippleController,
            builder: (context, child) {
              return CustomPaint(
                size: Size(size.width, size.height),
                painter: RingRipplePainter(_rippleController.value),
              );
            },
          ),

          // Center white circle with logo
          Container(
            width: size.width * 0.5,
            height: size.width * 0.5,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Image.asset(
              "asset/images/loginscreen/om_har_bhole_logo.png",
              width: size.width * 0.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

/// Painter that draws thick soft ripple bands (not single stroke lines)
class RingRipplePainter extends CustomPainter {
  final double progress;
  RingRipplePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // These parameters control appearance; tweak if needed
    const int bands = 4; // how many rings visible at once
    final maxRadius = size.width * 0.45; // how far rings expand
    final baseWidth = maxRadius * 0.22; // maximum band thickness
    final blur = 12.0; // softness

    for (int i = 0; i < bands; i++) {
      // distribute rings across the animation cycle
      double bandProgress = (progress + i / bands) % 1.0;

      // radius grows from small to maxRadius
      final radius = 20 + bandProgress * maxRadius;

      // band thickness shrinks slightly as it expands
      final thickness = baseWidth * (1.0 - bandProgress * 0.8).clamp(0.25, 1.0);

      // opacity fades out as it expands
      final opacity = (1.0 - bandProgress).clamp(0.0, 1.0);
      final color = Colors.white.withOpacity(opacity * 0.75);

      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = thickness
        ..color = color
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, blur);

      // Draw ring (stroke with large strokeWidth -> looks like a filled band)
      canvas.drawCircle(center, radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant RingRipplePainter oldDelegate) => true;
}
