import 'package:flutter/material.dart' as m;
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../../models/admin/booking_model.dart';

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

/// Used to devide the list of bookings into Lists each list has four items
List<List<Booking?>> _devideIntoListsOfFour(List<Booking?> list) {
  final newlist = <List<Booking?>>[];
  final numberOfLists = (list.length ~/ 4);

  for (var i = 0; i < numberOfLists; i++) {
    final holder = <Booking?>[];

    holder.add(list[(i * 4) + 0]);
    holder.add(list[(i * 4) + 1]);
    holder.add(list[(i * 4) + 2]);
    holder.add(list[(i * 4) + 3]);

    newlist.add(holder);
  }

  if (list.isNotEmpty) {
    newlist.add(list.sublist(numberOfLists * 4));
  }

  return newlist;
}

Future<Uint8List> makePdf(
    m.BuildContext context, List<Booking?> bookings) async {
  final h = m.MediaQuery.of(context).size.height;
  final w = m.MediaQuery.of(context).size.width;
  var arabicFont = Font.ttf(
    await rootBundle.load(
      "assets/fonts/arabic_font.ttf",
    ),
  );

  final bookingLists = _devideIntoListsOfFour(bookings);
  final pdf = Document();

  pdf.addPage(
    Page(
      theme: ThemeData.withFont(
        base: arabicFont,
      ),
      build: (context) => SizedBox(
        width: w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "أنجز",
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: h * 0.05),
            ),
            SizedBox(height: h * 0.05),
            Text(
              "تقرير الحجوزات اليومية",
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: h * 0.03),
            ),
            Text(
              "${DateTime.now().year}/"
              "${DateTime.now().month}/"
              "${DateTime.now().day}",
              style: TextStyle(fontSize: h * 0.03),
            ),
          ],
        ),
      ),
    ),
  );

  for (final bList in bookingLists) {
    pdf.addPage(
      Page(
        theme: ThemeData.withFont(
          base: arabicFont,
        ),
        build: (_) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ...bList.map(
              (e) => Container(
                margin: const EdgeInsets.fromLTRB(22, 5, 22, 5),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Table(
                    border: TableBorder.all(color: PdfColors.black),
                    children: [
                      TableRow(
                        children: [
                          SizedBox(
                            width: w * 0.7,
                            child: Padding(
                              padding: EdgeInsets.all(h * 0.005),
                              child: Text(
                                "${e?.name}",
                                style: TextStyle(
                                  fontSize: h * 0.015,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(h * 0.005),
                            child: Text(
                              "الاسم",
                              style: TextStyle(
                                fontSize: h * 0.015,
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(h * 0.005),
                            child: Text(
                              "${e?.number}",
                              style: TextStyle(
                                fontSize: h * 0.015,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(h * 0.005),
                            child: Text(
                              "الرقم",
                              style: TextStyle(
                                fontSize: h * 0.015,
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(h * 0.005),
                            child: Text(
                              "${e?.doctor}",
                              style: TextStyle(
                                fontSize: h * 0.015,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(h * 0.005),
                            child: Text(
                              "الطبيب",
                              style: TextStyle(
                                fontSize: h * 0.015,
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(h * 0.005),
                            child: Text(
                              "${e?.date}",
                              style: TextStyle(
                                fontSize: h * 0.015,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(h * 0.005),
                            child: Text(
                              "التاريخ",
                              style: TextStyle(
                                fontSize: h * 0.015,
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(h * 0.005),
                            child: Text(
                              "${e?.paymentMethod}",
                              style: TextStyle(
                                fontSize: h * 0.015,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(h * 0.005),
                            child: Text(
                              "الدفع",
                              style: TextStyle(
                                fontSize: h * 0.015,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return pdf.save();
}
