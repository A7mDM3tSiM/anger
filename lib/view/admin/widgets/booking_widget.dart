import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../models/admin/booking_model.dart';

class BookingWidget extends StatelessWidget {
  final Booking booking;
  const BookingWidget({super.key, required this.booking});

  String? fixPaymentMethod(int? paymentMethod) {
    if (paymentMethod == 0) {
      return "تم الدفع";
    } else if (paymentMethod == 1) {
      return "دفع آجل";
    }
    return "";
  }

  String? fixNumber(String? number) {
    late final String? newNum;

    if (number?[0] == "0") {
      newNum = number?.replaceFirst(RegExp(r'0'), '+249', 0);
    }

    return newNum;
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(vertical: h * 0.01, horizontal: w * 0.01),
      padding: EdgeInsets.symmetric(vertical: h * 0.01, horizontal: h * 0.01),
      decoration: BoxDecoration(
        border: Border.all(width: 1.5, color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          SizedBox(
            width: w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  booking.name ?? "",
                  style: TextStyle(
                    fontSize: h * 0.017,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    final number = fixNumber(booking.number);
                    launchUrlString(
                      "https://wa.me/$number",
                      mode: LaunchMode.externalApplication,
                    );
                  },
                  child: Text(
                    booking.number ?? "",
                    style: TextStyle(
                      fontSize: h * 0.017,
                      decoration: TextDecoration.underline,
                    ),
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
                Text(
                  fixPaymentMethod(booking.paymentMethod) ?? "",
                  style: TextStyle(
                    fontSize: h * 0.017,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: h * 0.005,
            left: w * 0.01,
            child: GestureDetector(
              onTap: () async {
                await Clipboard.setData(
                  ClipboardData(
                    text: "الاسم : ${booking.name}"
                        "\n"
                        "الرقم : ${booking.number}"
                        "\n"
                        "التاريخ : ${booking.date}"
                        "\n"
                        "الظبيب : ${booking.doctor}",
                  ),
                );
                Fluttertoast.showToast(
                  msg: 'تم نسخ البيانات',
                  backgroundColor: Colors.grey,
                  fontSize: 17,
                );
              },
              child: const Icon(Icons.copy),
            ),
          )
        ],
      ),
    );
  }
}
