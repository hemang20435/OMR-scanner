part of 'file_bloc.dart';

@immutable
abstract class FileState {}

class FileInitial extends FileState {}

class FileUploaded extends FileState {
  final Result result;
  FileUploaded(this.result);
}

class FileUploadFailed extends FileState {}

class FileUploading extends FileState {}
