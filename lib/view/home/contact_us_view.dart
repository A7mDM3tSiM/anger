import 'package:flutter/material.dart';

import '../../services/navigation_service.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({super.key});

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
            SizedBox(height: h * 0.015),
            Text(
              "أنجز"
              "\n"
              "احجز طبيبك من اي مكان"
              "\n"
              "اكثر من 200 أخصائي واستشاري"
              "\n"
              "أكثر من 30 مجمع طبي"
              "\n"
              "ولاية الجزيرة"
              "\n"
              "للإتصال : ٠٩٠٧٤١٣٢٢١",
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: h * 0.02,
                color: Colors.black,
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
            )
          ],
        ),
      ),
    );
  }
}
