import 'package:angiz/provider/doctor/doctor_view_model.dart';
import 'package:angiz/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/routes/routes.dart';

class BookView extends StatelessWidget {
  const BookView({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => NavigationService.pop(),
                      child: Row(
                        children: [
                          const Icon(Icons.arrow_back),
                          Image.asset(
                            "assets/app_logo.png",
                            width: w * 0.13,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(360),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.share,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: h * 0.005),
              Container(
                height: 1.5,
                color: Colors.red,
              ),
              SizedBox(height: h * 0.05),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.1),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    ".. من فضلك قم بإدخال بيانات المريض",
                    style: TextStyle(
                      fontSize: h * 0.025,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ),
              ),
              SizedBox(height: h * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.1),
                child: const Align(
                  alignment: Alignment.centerRight,
                  child: Text("اسم المريض"),
                ),
              ),
              SizedBox(height: h * 0.01),
              Container(
                width: w * 0.8,
                height: h * 0.05,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Consumer<DoctorViewModel>(
                  builder: (_, doc, __) => TextField(
                    controller: doc.nameCtrl,
                    textDirection: TextDirection.rtl,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      fillColor: Colors.transparent,
                    ),
                  ),
                ),
              ),
              SizedBox(height: h * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.1),
                child: const Align(
                  alignment: Alignment.centerRight,
                  child: Text("رقم المريض"),
                ),
              ),
              SizedBox(height: h * 0.01),
              Container(
                width: w * 0.8,
                height: h * 0.05,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Consumer<DoctorViewModel>(
                  builder: (_, doc, __) => TextField(
                    keyboardType: TextInputType.phone,
                    controller: doc.phoneCtrl,
                    textDirection: TextDirection.rtl,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      fillColor: Colors.transparent,
                    ),
                  ),
                ),
              ),
              SizedBox(height: h * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.1),
                child: const Align(
                  alignment: Alignment.centerRight,
                  child: Text("تاريخ الحجز"),
                ),
              ),
              GestureDetector(
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2023),
                    lastDate: DateTime(2050),
                    locale: const Locale('en'),
                    builder: (_, child) => Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: Colors.black,
                            onPrimary: Colors.white,
                            onSurface: Colors.black,
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.black,
                            ),
                          ),
                        ),
                        child: child!),
                  ).then(
                    (date) =>
                        context.read<DoctorViewModel>().setBookingDate(date),
                  );
                },
                child: Container(
                  width: w * 0.8,
                  height: h * 0.05,
                  padding: EdgeInsets.symmetric(horizontal: w * 0.02),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Icons.date_range_rounded,
                        color: Colors.grey,
                      ),
                      Consumer<DoctorViewModel>(
                        builder: (_, doc, __) => Text(
                          doc.bookingDate ?? "اختر التاريخ",
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: h * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.1),
                child: const Align(
                  alignment: Alignment.centerRight,
                  child: Text("اختر التخصص"),
                ),
              ),
              Consumer<DoctorViewModel>(
                builder: (_, doc, __) => DropdownButton(
                  items: doc.specItem(context),
                  value: doc.currentSpec,
                  onChanged: (value) => doc.serCurrentSpec(value),
                ),
              ),
              SizedBox(height: h * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.1),
                child: const Align(
                  alignment: Alignment.centerRight,
                  child: Text("اختر الطبيب"),
                ),
              ),
              Consumer<DoctorViewModel>(
                builder: (_, doc, __) => DropdownButton<String>(
                  items: doc.docItems(context),
                  value: doc.currentDoc,
                  hint: SizedBox(
                    width: w * 0.76,
                    child: const Text(
                      "اختر الطبيب",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  onChanged: (value) => doc.serCurrentDoc(value ?? ""),
                ),
              ),
              SizedBox(height: h * 0.03),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.1),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "رسوم الخدمة 1000 جنيه، هل ترغب في الدفع الان"
                    " أو عند مسجل الطبيب بعد الوصول الى العيادة ؟",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: h * 0.02),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text("ادفع الآن"),
                    Consumer<DoctorViewModel>(
                      builder: (_, doc, __) => Checkbox(
                        value: doc.paymentMethod == PaymentMethod.now,
                        onChanged: (v) {
                          if (v != null && v) {
                            doc.setPaymentMethod(PaymentMethod.now);
                          }
                        },
                        fillColor:
                            const MaterialStatePropertyAll<Color>(Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text("ادفع لاحقاََ"),
                    Consumer<DoctorViewModel>(
                      builder: (_, doc, __) => Checkbox(
                        value: doc.paymentMethod == PaymentMethod.later,
                        onChanged: (v) {
                          if (v != null && v) {
                            doc.setPaymentMethod(PaymentMethod.later);
                          }
                        },
                        fillColor:
                            const MaterialStatePropertyAll<Color>(Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: h * 0.05),
              GestureDetector(
                onTap: () {
                  final doc = context.read<DoctorViewModel>();
                  if (doc.checkFields()) {
                    if (doc.paymentMethod == PaymentMethod.now) {
                      NavigationService.push(Routes.paymentRoute);
                    } else {
                      doc.launchWhatsapp();
                    }
                  }
                },
                child: Container(
                  width: w * 0.8,
                  height: h * 0.05,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[200]!,
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "استمرار",
                      style:
                          TextStyle(color: Colors.white, fontSize: h * 0.023),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
