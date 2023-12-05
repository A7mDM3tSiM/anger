import 'package:angiz/provider/doctor/doctor_view_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../services/navigation_service.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
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
                  "اختر مزود الخدمة الخاص بك",
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: h * 0.02),
                ),
              ),
            ),
            SizedBox(height: h * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    context
                        .read<DoctorViewModel>()
                        .setPaymentService(PaymnetService.mtn);
                  },
                  child: Consumer<DoctorViewModel>(
                    builder: (_, doc, __) => Container(
                      height: h * 0.1,
                      width: w * 0.3,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: doc.paymnetService == PaymnetService.mtn
                              ? Colors.red
                              : Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "MTN",
                          style: TextStyle(
                            fontSize: h * 0.023,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context
                        .read<DoctorViewModel>()
                        .setPaymentService(PaymnetService.sudani);
                  },
                  child: Consumer<DoctorViewModel>(
                    builder: (_, doc, __) => Container(
                      height: h * 0.1,
                      width: w * 0.3,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: doc.paymnetService == PaymnetService.sudani
                              ? Colors.red
                              : Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Sudani",
                          style: TextStyle(
                            fontSize: h * 0.023,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context
                        .read<DoctorViewModel>()
                        .setPaymentService(PaymnetService.zain);
                  },
                  child: Consumer<DoctorViewModel>(
                    builder: (_, doc, __) => Container(
                      height: h * 0.1,
                      width: w * 0.3,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: doc.paymnetService == PaymnetService.zain
                              ? Colors.red
                              : Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Zain",
                          style: TextStyle(
                            fontSize: h * 0.023,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: h * 0.05),
            Consumer<DoctorViewModel>(
              builder: (_, doc, __) {
                if (doc.paymnetService == PaymnetService.zain) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: w * 0.1),
                        child: const Align(
                          alignment: Alignment.centerRight,
                          child: Text("ادخل اخر اربعة أرقام في ظهر الشريحة"),
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
                            controller: doc.pinCtrl,
                            textDirection: TextDirection.rtl,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              fillColor: Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
            SizedBox(height: h * 0.05),
            GestureDetector(
              onTap: () {
                final doc = context.read<DoctorViewModel>();

                if (doc.paymnetService == null) {
                  Fluttertoast.showToast(
                    msg: 'اختر مقدم الخدمة',
                    backgroundColor: Colors.red,
                    fontSize: 17,
                  );
                  return;
                }
                if (doc.paymnetService == PaymnetService.zain &&
                    doc.pinCtrl.text.trim().isEmpty) {
                  Fluttertoast.showToast(
                    msg: 'ادخل الرمز أرلاََ',
                    backgroundColor: Colors.red,
                    fontSize: 17,
                  );
                  return;
                }

                doc.runUSSD();
              },
              child: Consumer<DoctorViewModel>(builder: (_, doc, __) {
                if (doc.isLoading) {
                  return const CircularProgressIndicator(
                    color: Colors.red,
                  );
                }
                return Container(
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
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
