import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:omr_scanner/app/data/file_repository.dart';
import 'package:meta/meta.dart';
import 'package:omr_scanner/app/model/result.dart';

part 'file_event.dart';
part 'file_state.dart';

class FileBloc extends Bloc<FileEvent, FileState> {
  final repository = FirebaseStorageRepository();
  FileBloc() : super(FileInitial()) {
    on<FileEvent>((event, emit) async {
      if (event is UploadFileEvent) {
        emit(FileUploading());
        final uploaded = await repository.prediction(event.file);

        if (uploaded != null && uploaded["status"] == true) {
          emit(FileUploaded(Result.fromJson(uploaded)));
        } else {
          emit(FileUploadFailed());
        }
      }
    });
  }
}
