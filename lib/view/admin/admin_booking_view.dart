import 'package:angiz/provider/admin/admin_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/navigation_service.dart';

class AdminBookingView extends StatelessWidget {
  const AdminBookingView({super.key});

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
            SizedBox(height: h * 0.03),
            Consumer<AdminViewModel>(
              builder: (_, admin, __) {
                if (admin.isLoading) {
                  return Column(
                    children: [
                      SizedBox(height: h * 0.4),
                      const Center(
                        child: CircularProgressIndicator(color: Colors.red),
                      ),
                    ],
                  );
                }
                if (admin.bookings.isEmpty) {
                  return Column(
                    children: [
                      SizedBox(height: h * 0.4),
                      const Center(
                        child: Text("لا توجد حجوزات"),
                      ),
                    ],
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: admin.bookings.length,
                  itemBuilder: (_, index) {
                    final booking = admin.bookings[index];
                    return Container(
                      width: w * 0.85,
                      margin: EdgeInsets.symmetric(
                          vertical: h * 0.01, horizontal: w * 0.01),
                      padding: EdgeInsets.symmetric(vertical: h * 0.01),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.5, color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            booking.name ?? "",
                            style: TextStyle(
                              fontSize: h * 0.017,
                            ),
                          ),
                          Text(
                            booking.number ?? "",
                            style: TextStyle(
                              fontSize: h * 0.017,
                            ),
                          ),
                          Text(
                            booking.doctor ?? "",
                            style: TextStyle(
                              fontSize: h * 0.017,
                            ),
                          ),
                          Text(
                            booking.date ?? "",
                            style: TextStyle(
                              fontSize: h * 0.017,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
