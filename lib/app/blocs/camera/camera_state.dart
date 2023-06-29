// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'camera_bloc.dart';

@immutable
abstract class CameraState {}

class CameraInitial extends CameraState {}

class CameraRecordingVideo extends CameraState {}

class CameraVideoRecorded extends CameraState {
  final XFile video;
  CameraVideoRecorded(
    this.video,
  );
}

class CameraImageCaptured extends CameraState {
  final XFile file;
  CameraImageCaptured(
    this.file,
  );
}

class CameraChanged extends CameraState {}

class CameraExceptionOccurred extends CameraState {}
