import 'package:angiz/components/routes/routes.dart';
import 'package:angiz/provider/doctor/doctor_view_model.dart';
import 'package:angiz/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        final doc = context.read<DoctorViewModel>();
        await doc.fetchSpecs();
        await doc.fetchDoctors();
        NavigationService.pushReplacement(Routes.homeRoute);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/app_logo.png',
            ),
            SizedBox(height: h * 0.02),
            Text(
              "أنجز",
              style: TextStyle(
                fontSize: h * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            SizedBox(height: h * 0.02),
            Text(
              "احجز طبيبك من اي مكان\n اكثر من 200 أخصائي واستشاري\n أكثر من 30 مجمع طبي",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: h * 0.03,
                color: Colors.red,
              ),
            ),
            SizedBox(height: h * 0.05),
            const CircularProgressIndicator(
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
