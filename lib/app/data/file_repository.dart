import 'dart:io';

import 'package:camera/camera.dart';
import 'package:omr_scanner/app/services/network.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class FirebaseStorageRepository {
  final APINetworkService _apiNetworkService = APINetworkService();
  String bucketNameUrl = "bmi-calculator-6b86e.appspot.com";
  Future<bool> uploadFile(XFile file) async {
    final storageRef = FirebaseStorage.instanceFor(
            bucket: bucketNameUrl)
        .ref();

    final rootDir = await getApplicationDocumentsDirectory();

    try {
      final fileRef = storageRef.child("storage/${file.name}");
      await fileRef.putFile(File(file.path));
      return true;
    } on FirebaseException catch (e) {
      return false;
    }
  }

  Future<dynamic> prediction(XFile file) async {
    final result = await uploadFile(file);
    if (result) {
      final data = _apiNetworkService.getPredictedResult(file.name);
      return data;
    } 
  }
}
