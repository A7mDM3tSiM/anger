import 'package:angiz/components/routes/routes.dart';
import 'package:angiz/provider/admin/admin_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/navigation_service.dart';

class AdminView extends StatelessWidget {
  const AdminView({super.key});

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
            GestureDetector(
              onTap: () {
                context.read<AdminViewModel>().resetValues();
                NavigationService.push(Routes.addDoctorRoute);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: w * 0.02),
                height: h * 0.06,
                width: w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      color: Colors.grey,
                      size: h * 0.017,
                    ),
                    Text(
                      "إضافة طبيب",
                      style: TextStyle(fontSize: h * 0.02),
                    ),
                  ],
                ),
              ),
            ),
            Container(height: 2, width: w, color: Colors.grey),
            Container(
              padding: EdgeInsets.symmetric(horizontal: w * 0.02),
              height: h * 0.06,
              width: w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    color: Colors.grey,
                    size: h * 0.017,
                  ),
                  Text(
                    "عرض الحجوزات",
                    style: TextStyle(fontSize: h * 0.02),
                  ),
                ],
              ),
            ),
            Container(height: 2, width: w, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
