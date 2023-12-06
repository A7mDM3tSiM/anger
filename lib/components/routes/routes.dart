import 'package:angiz/view/admin/add_doctor_view.dart';
import 'package:angiz/view/admin/admin_booking_view.dart';
import 'package:angiz/view/admin/admin_view.dart';
import 'package:angiz/view/book/book_view.dart';
import 'package:angiz/view/home/contact_us_view.dart';
import 'package:angiz/view/home/home_view.dart';
import 'package:angiz/view/payment/payment.dart';

import '../../view/spalsh/splash_view.dart';

class Routes {
  // assign routes to static strings to avoid string confusion
  static String splashRoute = '/';
  static String homeRoute = '/home';
  static String bookRoute = '/book';
  static String paymentRoute = '/payment';
  static String contactUsRoute = '/contact_us';
  static String adminRoute = '/admin';
  static String addDoctorRoute = '/add_doctor';
  static String adminBookingsRoute = '/admin_bookings';

  /// a set contain all the app routes assigned to widgets
  // (_) is context but it's not needed
  static final routes = {
    splashRoute: (_) => const SplashView(),
    homeRoute: (_) => const HomeView(),
    bookRoute: (_) => const BookView(),
    paymentRoute: (_) => const PaymentView(),
    contactUsRoute: (_) => const ContactUsView(),
    adminRoute: (_) => const AdminView(),
    addDoctorRoute: (_) => const AddDoctorView(),
    adminBookingsRoute: (_) => const AdminBookingView(),
  };
}
