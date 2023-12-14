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
                  return SizedBox(
                    height: h * 0.85,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: admin.bookings.length,
                      itemBuilder: (_, index) {
                        final booking = admin.bookings[index];
                        return BookingWidget(booking: booking);
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
