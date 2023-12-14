import 'package:angiz/components/routes/routes.dart';
import 'package:angiz/provider/doctor/doctor_view_model.dart';
import 'package:angiz/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/app_logo.png",
                    width: w * 0.13,
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
            SizedBox(height: h * 0.015),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    NavigationService.push(Routes.contactUsRoute);
                  },
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(360),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Icon(
                          Icons.phone,
                          color: Colors.white,
                          size: h * 0.04,
                        ),
                      ),
                      Text(
                        "اتصل ينا",
                        style: TextStyle(fontSize: h * 0.02),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: w * 0.075),
                GestureDetector(
                  onTap: () {
                    context.read<DoctorViewModel>().resetValues();
                    NavigationService.push(Routes.bookRoute);
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/headphone.png",
                        height: h * 0.06,
                      ),
                      Text(
                        "احجز الآن",
                        style: TextStyle(fontSize: h * 0.02),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: h * 0.03),
            GestureDetector(
              onTap: () {
                NavigationService.push(Routes.addressBookRoute);
              },
              child: Text(
                "عرض مواقع الاطباء",
                style: TextStyle(
                  fontSize: h * 0.02,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: h * 0.1),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                "assets/doctor.png",
                fit: BoxFit.cover,
                height: h * 0.4,
              ),
            ),
            SizedBox(height: h * 0.1),
            GestureDetector(
              onTap: () {
                NavigationService.push(Routes.adminRoute);
              },
              child: Text(
                "Admin panel",
                style: TextStyle(
                  fontSize: h * 0.02,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
