import 'package:camera/camera.dart';
import 'package:omr_scanner/app/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class CameraControlBottomNavBar extends StatelessWidget {
  const CameraControlBottomNavBar(
      {super.key,
      this.onChangeCameraPressed,
      this.onImageCapturePressed,
      this.onVideoRecordPressed});

  final VoidCallback? onImageCapturePressed;
  final VoidCallback? onChangeCameraPressed;
  final VoidCallback? onVideoRecordPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        /* CircleAvatar(
          child: IconButton(
              onPressed: onImageCapturePressed,
              icon: const Icon(
                Icons.camera,
                color: white,
              )),
        ), */
        MaterialButton(
          color: white,
          minWidth: 60,
          height: 60,
          shape: const CircleBorder(),
          onPressed: onImageCapturePressed,
          onLongPress: onVideoRecordPressed,
        ),
        /* Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: white,
          ),
          child: Row(
            children: [
              IconButton(
                  onPressed: onVideoRecordPressed,
                  icon: const Icon(
                    Icons.circle,
                    color: Colors.red,
                  ))
            ],
          ),
        ), */
        /*  CircleAvatar(
          child: IconButton(
              onPressed: onChangeCameraPressed,
              icon: const Icon(
                Icons.repeat,
                color: white,
              )),
        ), */
      ],
    );
  }
}
