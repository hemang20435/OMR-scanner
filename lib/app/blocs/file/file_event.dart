part of 'file_bloc.dart';

@immutable
abstract class FileEvent {}

class UploadFileEvent extends FileEvent {
  final XFile file;
  UploadFileEvent(this.file);
}
