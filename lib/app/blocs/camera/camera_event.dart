part of 'camera_bloc.dart';

@immutable
abstract class CameraEvent {
  final CameraController? cameraController;

  const CameraEvent(this.cameraController);
}

class CaptureImageEvent extends CameraEvent {
  const CaptureImageEvent(super.cameraController);
}

class StartVideoRecordingEvent extends CameraEvent {
  const StartVideoRecordingEvent(super.cameraController);
}

class RearCameraEvent extends CameraEvent {
  const RearCameraEvent(super.cameraController);
}
