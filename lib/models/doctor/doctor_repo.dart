import 'package:angiz/services/firebase_service.dart';

import 'doctor_model.dart';

class DoctorRepo {
  final _fb = FirebaseService(collectionPath: 'doctors');

  Future<List<Doctor>?> getDoctorsData() async {
    final list = <Doctor>[];

    final res = await _fb.getCollectionDocs();
    for (final json in res) {
      list.add(Doctor.fromJson(json));
    }

    return list;
  }

  Future<List<String>?> getSpecs() async {
    final list = <String>[];

    final fb = FirebaseService(collectionPath: "specs");
    final res = await fb.getCollectionDocs();

    for (final json in res) {
      list.add(json?['spec']);
    }

    return list;
  }
}
