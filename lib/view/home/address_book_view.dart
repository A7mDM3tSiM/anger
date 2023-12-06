import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/doctor/doctor_view_model.dart';
import '../../services/navigation_service.dart';

class AddressBookView extends StatelessWidget {
  const AddressBookView({super.key});

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
            SizedBox(height: h * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.1),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "من فضلك قم بإختيار الظبيب لعرض بياناته",
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
                child: Text("اختر التخصص"),
              ),
            ),
            Consumer<DoctorViewModel>(
              builder: (_, doc, __) => DropdownButton(
                items: doc.specItem(context),
                value: doc.currentSpec,
                onChanged: (value) => doc.serCurrentSpec(value),
              ),
            ),
            SizedBox(height: h * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.1),
              child: const Align(
                alignment: Alignment.centerRight,
                child: Text("اختر الطبيب"),
              ),
            ),
            Consumer<DoctorViewModel>(
              builder: (_, doc, __) => DropdownButton<String>(
                items: doc.docItems(context),
                value: doc.currentDoc,
                hint: SizedBox(
                  width: w * 0.76,
                  child: const Text(
                    "اختر الطبيب",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                onChanged: (value) => doc.serCurrentDoc(value ?? ""),
              ),
            ),
            SizedBox(height: h * 0.02),
            Consumer<DoctorViewModel>(builder: (_, doc, __) {
              if (doc.currentDoc == null) {
                return const SizedBox();
              }
              return Container(
                width: w * 0.85,
                padding: EdgeInsets.symmetric(horizontal: w * 0.01),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1.5, color: Colors.black),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "الاسم : ${doc.getCurrentDoctor().name}",
                      style: TextStyle(
                        fontSize: h * 0.02,
                      ),
                    ),
                    Text(
                      "التخصص : ${doc.getCurrentDoctor().spec}",
                      style: TextStyle(
                        fontSize: h * 0.02,
                      ),
                    ),
                    Text(
                      "الموقع : ${doc.getCurrentDoctor().location}",
                      style: TextStyle(
                        fontSize: h * 0.02,
                      ),
                    ),
                  ],
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
