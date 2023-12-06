import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/admin/admin_view_model.dart';
import '../../services/navigation_service.dart';

class AddDoctorView extends StatelessWidget {
  const AddDoctorView({super.key});

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
                child: Text("اسم الطبيب"),
              ),
            ),
            SizedBox(height: h * 0.02),
            Container(
              width: w * 0.8,
              height: h * 0.05,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Consumer<AdminViewModel>(
                builder: (_, admin, __) => TextField(
                  controller: admin.nameCtrl,
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
                child: Text("موقع الطبيب"),
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
              child: Consumer<AdminViewModel>(
                builder: (_, admin, __) => TextField(
                  controller: admin.locationCtrl,
                  textDirection: TextDirection.rtl,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    fillColor: Colors.transparent,
                  ),
                ),
              ),
            ),
            SizedBox(height: h * 0.01),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.1),
              child: const Align(
                alignment: Alignment.centerRight,
                child: Text("اختر التخصص"),
              ),
            ),
            Consumer<AdminViewModel>(
              builder: (_, admin, __) => DropdownButton(
                items: admin.specItem(context),
                value: admin.currentSpec,
                onChanged: (value) => admin.serCurrentSpec(value),
              ),
            ),
            SizedBox(height: h * 0.05),
            Consumer<AdminViewModel>(
              builder: (_, admin, __) {
                if (admin.isLoading) {
                  return const CircularProgressIndicator(
                    color: Colors.red,
                  );
                }
                return GestureDetector(
                  onTap: () {
                    if (admin.checkFields()) {
                      admin.addDoctor();
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
                        "إضافة",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: h * 0.023,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
