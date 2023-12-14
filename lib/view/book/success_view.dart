import 'package:angiz/components/routes/routes.dart';
import 'package:angiz/services/navigation_service.dart';
import 'package:flutter/material.dart';

class SuccessView extends StatelessWidget {
  const SuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: h,
          width: w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: h * 0.25,
                width: h * 0.25,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.red),
                  borderRadius: BorderRadius.circular(360),
                ),
                child: Center(
                  child: Icon(
                    Icons.check,
                    size: h * 0.15,
                    color: Colors.red,
                  ),
                ),
              ),
              SizedBox(height: h * 0.05),
              Text(
                'تم الحجز بنجاح'
                '\n'
                ' الرجاء التوجة للعيادة في الزمن والتاريخ المختارين',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: h * 0.02, color: Colors.black),
              ),
              SizedBox(height: h * 0.05),
              GestureDetector(
                onTap: () => NavigationService.popUntil(Routes.homeRoute),
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
                      "موافق",
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
