import 'dart:io';

import 'package:camera/camera.dart';
import 'package:omr_scanner/app/blocs/file/file_bloc.dart';
import 'package:omr_scanner/app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omr_scanner/app/view/pages/result.dart';

class CameraOutputPreviewPage extends StatefulWidget {
  const CameraOutputPreviewPage({super.key, this.file});
  final XFile? file;
  @override
  State<CameraOutputPreviewPage> createState() =>
      _CameraOutputPreviewPageState();
}

class _CameraOutputPreviewPageState extends State<CameraOutputPreviewPage> {

  Future<File> getImageFuture() async {
    return File(widget.file!.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        title: const Text("Confirm"),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => BlocProvider.of<FileBloc>(context).add(UploadFileEvent(widget.file!)),
            icon: const Icon(Icons.check, color: white))
        ],
      ),
      body: BlocConsumer<FileBloc, FileState>(
        listener: (context, state) {
          if (state is FileUploading) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: black,
                content: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: purple,
                  ),
                )));
          } else if (state is FileUploadFailed) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.red,
                content: Center(
                  child: Text("Failed to get results. Please try again."),
                )));
          } else if (state is FileUploaded) {
            //Navigator.of(context).pop();
           Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ResultPage(result: state.result)));
          }
        },
        builder: (context, state) {
          return FutureBuilder(
              future: getImageFuture(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Hero(
                        tag: "preview",
                        child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(24),
                                bottomRight: Radius.circular(24)),
                            child: Image.file(snapshot.data!))),
                  ],
                );
              });
        },
      ),
    );
  }
}
