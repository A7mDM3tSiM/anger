import '../../models/admin/booking_model.dart';

class PdfArgs {
  final List<Booking?> bookings;
  const PdfArgs({required this.bookings});
}
