import 'package:camera/camera.dart';
import 'package:omr_scanner/main.dart';

class CameraActions {
  Future<void> startRecording(CameraController? controller) async {
    if (controller == null || !controller.value.isInitialized) {
      return;
    }

    if (controller.value.isRecordingVideo) {
      return;
    }

    try {
      await controller.startVideoRecording();
    } on CameraException catch (e) {
      print(e.description);
    }
  }

  Future<XFile?> takePicture(CameraController? controller) async {
    try {
      if (controller != null || !controller!.value.isTakingPicture) {
        return await controller.takePicture();
      }
      return null;
    } on CameraException catch (e) {
      print(e.description);
    }
    return null;
  }

  Future<XFile?> stopRecording(CameraController controller) async {
    try {
      return await controller.stopVideoRecording();
    } on CameraException catch (e) {
      print(e.description);
    }
    return null;
  }
}
