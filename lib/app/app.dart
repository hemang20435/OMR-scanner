import 'package:omr_scanner/app/blocs/camera/camera_bloc.dart';
import 'package:omr_scanner/app/blocs/file/file_bloc.dart';
import 'package:omr_scanner/app/utils/constants/colors.dart';
import 'package:omr_scanner/app/view/pages/camera.dart';
import 'package:omr_scanner/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CameraBloc>(
          create: (context) => CameraBloc(cameras),
        ),
        BlocProvider<FileBloc>(create: (context) => FileBloc())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarBrightness: Brightness.light,
                    systemNavigationBarContrastEnforced: true,
                    systemNavigationBarIconBrightness: Brightness.light,
                    systemNavigationBarColor: grey)),
            primarySwatch: getMaterialColor(purple),
          ),
          home: CameraPage(camera: cameras.first)),
    );
  }
}
