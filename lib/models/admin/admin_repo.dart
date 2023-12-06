import 'package:angiz/models/admin/booking_model.dart';
import 'package:angiz/services/firebase_service.dart';

import '../doctor/doctor_model.dart';

class AdminRepo {
  Future<String?> addDoctor(Doctor doc) async {
    final fb = FirebaseService(collectionPath: "doctors");
    final id = await fb.addDoc(doc.toJson());

    await fb.updateDocData(id, {'id': id});

    return id;
  }

  Future addBooking(Booking booking) async {
    final fb = FirebaseService(collectionPath: "bookings");
    await fb.addDoc(booking.toJson());
  }

  Future<List<Booking>?> getbookings() async {
    final list = <Booking>[];

    final fb = FirebaseService(collectionPath: "bookings");
    final bookingsData = await fb.getCollectionDocs();

    for (final json in bookingsData) {
      list.add(Booking.fromJson(json));
    }

    return list;
  }
}
