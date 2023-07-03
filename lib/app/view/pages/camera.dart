import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:omr_scanner/app/blocs/camera/camera_bloc.dart';
import 'package:omr_scanner/app/blocs/file/file_bloc.dart';
import 'package:omr_scanner/app/utils/constants/colors.dart';
import 'package:omr_scanner/app/view/pages/preview.dart';
import 'package:omr_scanner/app/view/widgets/bottom_nav_bar.dart';
import 'package:omr_scanner/app/view/widgets/video_recording_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key, required this.camera});

  final CameraDescription camera;

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _controller;
  late Future<void> _initControllerFuture;
  bool isRecording = false;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.camera, ResolutionPreset.max);
    _initControllerFuture = _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        elevation: 0,
        title: const Text("OMR Scanner"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['jpeg', 'jpg', 'png'],
                );
                if (result != null) {
                  XFile file = XFile(result.files.first.path!);

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          CameraOutputPreviewPage(file: file)));
                }
              },
              icon: const Icon(Icons.file_upload))
        ],
      ),
      body: BlocConsumer<CameraBloc, CameraState>(
        listener: (context, state) {
          if (state is CameraImageCaptured) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    CameraOutputPreviewPage(file: state.file)));
          } else if (state is CameraVideoRecorded) {
            isRecording = !isRecording;
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Video recorded")));
          } else if (state is CameraRecordingVideo) {
            isRecording = !isRecording;
          } else if (state is CameraChanged) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Camera Changed")));
          }
        },
        builder: (context, state) {
          return FutureBuilder<void>(
            future: _initControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return LayoutBuilder(
                  builder: (context, box) {
                    return SizedBox(
                      height: box.maxHeight,
                      width: box.maxWidth,
                      child: InkResponse(
                        onTap: () => {},
                        child: Hero(
                            tag: "preview",
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(24),
                                  bottomRight: Radius.circular(24)),
                              child: CameraPreview(_controller,
                                  child: UnconstrainedBox(
                                    child: Container(
                                      width: size.width * .9,
                                      height: size.height * .7,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                                width: 4, color: Colors.red),
                                            borderRadius:
                                            BorderRadius.circular(24)),
                                      ),
                                    ),
                                  )),
                            )),
                      ),
                    );
                  },
                );
              } else {
                return const SizedBox();
              }
            },
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24),
        child: CameraControlBottomNavBar(
          onImageCapturePressed: () => BlocProvider.of<CameraBloc>(context)
              .add(CaptureImageEvent(_controller)),
          onChangeCameraPressed: () => BlocProvider.of<CameraBloc>(context)
              .add(RearCameraEvent(_controller)),
          onVideoRecordPressed: () => BlocProvider.of<CameraBloc>(context)
              .add(StartVideoRecordingEvent(_controller)),
        ),
      ),
    );
  }
}
