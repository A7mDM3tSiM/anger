import 'package:angiz/components/args/pdf_args.dart';
import 'package:angiz/components/routes/routes.dart';
import 'package:angiz/provider/admin/admin_view_model.dart';
import 'package:angiz/view/admin/widgets/booking_widget.dart';
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
                return Column(
                  children: [
                    SizedBox(
                      height: h * 0.79,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: admin.bookings.length,
                        itemBuilder: (_, index) {
                          final booking = admin.bookings[index];
                          return BookingWidget(booking: booking);
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          NavigationService.push(
                            Routes.pdfRoute,
                            arg: PdfArgs(bookings: admin.bookings),
                          );
                        },
                        child: Container(
                          width: w * 0.23,
                          height: h * 0.045,
                          margin: EdgeInsets.symmetric(
                            horizontal: w * 0.05,
                            vertical: h * 0.02,
                          ),
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
                              "استخراج الكل",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: h * 0.017,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
