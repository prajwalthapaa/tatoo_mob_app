// import 'package:flutter/material.dart';
// import 'package:all_sensors2/all_sensors2.dart';
// import 'dart:async';
// import 'dart:math';
//
// class ShakeDetector extends StatefulWidget {
//   final Widget child;
//   final VoidCallback onShake;
//
//   const ShakeDetector({required this.child, required this.onShake, Key? key}) : super(key: key);
//
//   @override
//   State<ShakeDetector> createState() => _ShakeDetectorState();
// }
//
// class _ShakeDetectorState extends State<ShakeDetector> {
//   List<double> _accelerometerValues = [];
//   final List<StreamSubscription<dynamic>> _streamSubscriptions = [];
//
//   // Shake detection variables
//   static const double shakeThresholdGravity = 2.7;
//   static const int shakeSlopTimeMs = 500;
//   static const int shakeCountResetTimeMs = 3000;
//
//   int shakeTimestamp = 0;
//   int shakeCount = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _streamSubscriptions.add(accelerometerEvents!.listen((event) {
//       setState(() {
//         _accelerometerValues = [event.x, event.y, event.z];
//         _detectShake(event);
//       });
//     }));
//   }
//
//   void _detectShake(AccelerometerEvent event) {
//     double gX = event.x / 9.8;
//     double gY = event.y / 9.8;
//     double gZ = event.z / 9.8;
//
//     double gForce = sqrt(gX * gX + gY * gY + gZ * gZ);
//
//     if (gForce > shakeThresholdGravity) {
//       final now = DateTime.now().millisecondsSinceEpoch;
//       if (shakeTimestamp + shakeSlopTimeMs > now) {
//         return;
//       }
//
//       if (shakeTimestamp + shakeCountResetTimeMs < now) {
//         shakeCount = 0;
//       }
//
//       shakeTimestamp = now;
//       shakeCount++;
//
//       if (shakeCount >= 3) {
//         shakeCount = 0;
//         widget.onShake();
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return widget.child;
//   }
//
//   @override
//   void dispose() {
//     for (final subscription in _streamSubscriptions) {
//       subscription.cancel();
//     }
//     super.dispose();
//   }
// }
