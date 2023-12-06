import 'package:angiz/models/admin/admin_repo.dart';
import 'package:angiz/models/admin/booking_model.dart';
import 'package:angiz/models/doctor/doctor_model.dart';
import 'package:angiz/provider/doctor/doctor_view_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class AdminViewModel extends ChangeNotifier {
  final _adminRepo = AdminRepo();
  final nameCtrl = TextEditingController();
  final locationCtrl = TextEditingController();

  final _bookings = <Booking>[];
  List<Booking> get bookings => _bookings;

  var _isLoading = false;
  bool get isLoading => _isLoading;

  String? currentSpec = "باطنية";

  void _startLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void _stopLoading() {
    _isLoading = false;
    notifyListeners();
  }

  void serCurrentSpec(String newSpec) {
    currentSpec = newSpec;
    notifyListeners();
  }

  List<DropdownMenuItem> specItem(BuildContext context) {
    final specs = context.read<DoctorViewModel>().specs;
    final w = MediaQuery.of(context).size.width;
    final list = <DropdownMenuItem>[];

    for (final item in specs) {
      list.add(
        DropdownMenuItem(
          value: item,
          child: SizedBox(width: w * 0.76, child: Text(item)),
        ),
      );
    }

    return list;
  }

  bool checkFields() {
    if (nameCtrl.text.trim().isEmpty) {
      Fluttertoast.showToast(
        msg: 'أدخل اسم الطبيب أولاً',
        backgroundColor: Colors.red,
        fontSize: 17,
      );
      return false;
    }
    if (locationCtrl.text.trim().isEmpty) {
      Fluttertoast.showToast(
        msg: 'أخل موقع الظبيب أولاً',
        backgroundColor: Colors.red,
        fontSize: 17,
      );
      return false;
    }

    return true;
  }

  void addDoctor() async {
    _startLoading();

    // craete doctor instance
    final doc = Doctor(
      name: nameCtrl.text.trim(),
      spec: currentSpec,
      location: locationCtrl.text.trim(),
    );

    // send to firestore
    final res = await _adminRepo.addDoctor(doc);

    // handle response to notify the user
    if (res != null) {
      resetValues();
      Fluttertoast.showToast(
        msg: 'تم إضافة الطبيب ينجاح',
        backgroundColor: Colors.green,
        fontSize: 17,
      );
    } else {
      Fluttertoast.showToast(
        msg: 'حدث خطأ، حاول مجدداََ',
        backgroundColor: Colors.red,
        fontSize: 17,
      );
    }

    _stopLoading();
  }

  void fectchBookings() async {
    _startLoading();
    _bookings.clear();
    final result = await _adminRepo.getbookings();

    if (result != null) {
      _bookings.addAll(result);
    }

    _stopLoading();
  }

  resetValues() {
    nameCtrl.clear();
    locationCtrl.clear();
    currentSpec = "باطنية";
  }
}
