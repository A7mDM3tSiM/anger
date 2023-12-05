import 'package:angiz/components/routes/routes.dart';
import 'package:angiz/models/doctor/doctor_model.dart';
import 'package:angiz/models/doctor/doctor_repo.dart';
import 'package:angiz/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:ussd_advanced/ussd_advanced.dart';

enum PaymentMethod { now, later }

enum PaymnetService { mtn, sudani, zain }

class DoctorViewModel extends ChangeNotifier {
  final _docRepo = DoctorRepo();
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final pinCtrl = TextEditingController();

  final _doctors = <Doctor>[];
  List<Doctor> get doctors => _doctors;

  final _specs = <String>[];
  List<String> get specs => _specs;

  var _isLoading = false;
  bool get isLoading => _isLoading;

  String? currentSpec = "باطنية";
  String? currentDoc;
  String? bookingDate;
  PaymentMethod? paymentMethod;
  PaymnetService? paymnetService;

  void _startLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void _stopLoading() {
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchSpecs() async {
    _startLoading();
    _specs.clear();

    final result = await _docRepo.getSpecs();
    if (result != null) {
      _specs.addAll(result);
    }

    _stopLoading();
  }

  Future<void> fetchDoctors() async {
    _startLoading();
    _doctors.clear();

    final result = await _docRepo.getDoctorsData();
    if (result != null) {
      _doctors.addAll(result);
    }

    _stopLoading();
  }

  void runUSSD() async {
    _startLoading();

    late final String code;

    switch (paymnetService) {
      case PaymnetService.mtn:
        code = "*121*0996837979*100000*00000#";
        break;
      case PaymnetService.sudani:
        code = "*303*0122247364*1000*0000";
        break;
      case PaymnetService.zain:
        code = "*200*${pinCtrl.text.trim()}*1000*0912145945*0912145945#";
        break;
      default:
        return;
    }

    final result =
        await UssdAdvanced.sendAdvancedUssd(code: code, subscriptionId: -1);

    _handleResponse(result ?? "");
    _stopLoading();
  }

  void _handleResponse(String message) {
    if (paymnetService == PaymnetService.mtn &&
        !message.contains("نجحت العملية")) {
      Fluttertoast.showToast(
        msg: 'فشلت العملية، تأكد من رصيدك وحاول محدداََ',
        backgroundColor: Colors.red,
        fontSize: 17,
      );
      return;
    }
    if (paymnetService == PaymnetService.sudani &&
        !message.contains("نجاح العملية")) {
      Fluttertoast.showToast(
        msg: 'فشلت العملية، تأكد من رصيدك وحاول محدداََ',
        backgroundColor: Colors.red,
        fontSize: 17,
      );
      return;
    }

    Fluttertoast.showToast(
      msg: 'تمت العملية ينجاح',
      backgroundColor: Colors.green,
      fontSize: 17,
    );
    launchWhatsapp();
  }

  void launchWhatsapp() async {
    final text = "الاسم : ${nameCtrl.text.trim()}"
        "\n"
        "الرقم : ${phoneCtrl.text.trim()}"
        "\n"
        "التاريخ : $bookingDate"
        "\n"
        "الظبيب : $currentDoc - $currentSpec";

    final link = "https://wa.me/++249907413221?text=$text";

    launchUrlString(link, mode: LaunchMode.externalApplication);
    await Future.delayed(const Duration(seconds: 3));
    NavigationService.popUntil(Routes.homeRoute);
  }

  void serCurrentSpec(String newSpec) {
    currentSpec = newSpec;
    currentDoc = null;
    notifyListeners();
  }

  void serCurrentDoc(String newDoc) {
    currentDoc = newDoc;
    notifyListeners();
  }

  void setBookingDate(DateTime? newDate) {
    bookingDate = "${newDate?.year}/${newDate?.month}/${newDate?.day}";
    notifyListeners();
  }

  void setPaymentMethod(PaymentMethod newPay) {
    paymentMethod = newPay;
    notifyListeners();
  }

  void setPaymentService(PaymnetService newPay) {
    paymnetService = newPay;
    notifyListeners();
  }

  List<Doctor> getDoctorsBySpec() {
    final list = <Doctor>[];

    for (final doc in _doctors) {
      if (doc.spec == currentSpec) {
        list.add(doc);
      }
    }

    return list;
  }

  List<DropdownMenuItem> specItem(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final list = <DropdownMenuItem>[];

    for (final item in _specs) {
      list.add(
        DropdownMenuItem(
          value: item,
          child: SizedBox(width: w * 0.76, child: Text(item)),
        ),
      );
    }

    return list;
  }

  List<DropdownMenuItem<String>> docItems(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final list = <DropdownMenuItem<String>>[];
    final docs = getDoctorsBySpec();

    for (final item in docs) {
      list.add(
        DropdownMenuItem(
          value: item.name,
          child: SizedBox(width: w * 0.76, child: Text(item.name ?? "")),
        ),
      );
    }

    return list;
  }

  bool checkFields() {
    if (nameCtrl.text.trim().isEmpty) {
      Fluttertoast.showToast(
        msg: 'أدخل اسم المريض أولاً',
        backgroundColor: Colors.red,
        fontSize: 17,
      );
      return false;
    }
    if (phoneCtrl.text.trim().isEmpty) {
      Fluttertoast.showToast(
        msg: 'أخل رقم الهاتف أولاً',
        backgroundColor: Colors.red,
        fontSize: 17,
      );
      return false;
    }
    if (bookingDate == null) {
      Fluttertoast.showToast(
        msg: 'أدخل تاريخ الحجز أولاً',
        backgroundColor: Colors.red,
        fontSize: 17,
      );
      return false;
    }
    if (currentDoc == null) {
      Fluttertoast.showToast(
        msg: 'أدخل اسم الطبيب أولاً',
        backgroundColor: Colors.red,
        fontSize: 17,
      );
      return false;
    }
    if (paymentMethod == null) {
      Fluttertoast.showToast(
        msg: 'أدخل طريقة الدفع أولاً',
        backgroundColor: Colors.red,
        fontSize: 17,
      );
      return false;
    }
    return true;
  }

  void resetValues() {
    nameCtrl.clear();
    phoneCtrl.clear();
    currentSpec = "باطنية";
    currentDoc = null;
    bookingDate = null;
    paymentMethod = null;
  }
}
