import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:omr_scanner/app/data/camera.dart';
import 'package:meta/meta.dart';

part 'camera_event.dart';
part 'camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  final List<CameraDescription> cameras;
  final _cameraAction = CameraActions();
  CameraBloc(this.cameras) : super(CameraInitial()) {
    on<CameraEvent>((event, emit) async {
      final controller = event.cameraController;
      if (event is CaptureImageEvent) {
        final file = await _cameraAction.takePicture(controller);

        if (file == null) {
          emit(CameraExceptionOccurred());
        } else {
          emit(CameraImageCaptured(file));
        }
      } else if (event is RearCameraEvent) {
        emit(CameraChanged());
      } else if (event is StartVideoRecordingEvent) {
        emit(CameraRecordingVideo());
        _cameraAction.startRecording(controller);
        await Future.delayed(const Duration(seconds: 5)).whenComplete(() async {
          final videoFile = await _cameraAction.stopRecording(controller!);
          if (videoFile == null) {
            emit(CameraExceptionOccurred());
          } else {
            emit(CameraVideoRecorded(videoFile));
          }
        });
      } else {
        emit(CameraExceptionOccurred());
      }
    });
  }
}
