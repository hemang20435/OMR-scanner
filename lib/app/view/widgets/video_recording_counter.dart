import 'package:flutter/material.dart';

class VideoRecordingCounter extends StatelessWidget {
  const VideoRecordingCounter({super.key, this.counter});
  final int? counter;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 35,
      width: 100,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(24)),
      child: const Text(
        "00:00",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
