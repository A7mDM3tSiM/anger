import 'package:angiz/components/args/pdf_args.dart';
import 'package:angiz/view/pdf/widget/pdf_widget.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

class PdfView extends StatelessWidget {
  const PdfView({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as PdfArgs;
    return Scaffold(
      body: SafeArea(
        child: PdfPreview(
          build: (_) => makePdf(context, args.bookings),
        ),
      ),
    );
  }
}
