import 'package:angiz/provider/admin/admin_view_model.dart';
import 'package:angiz/provider/doctor/doctor_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/routes/routes.dart';
import 'components/theme/theme.dart';
import 'components/theme/theme_manger.dart';
import 'services/navigation_service.dart';
import 'services/network_service.dart';

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

Future<void> main() async {
  // Global Init
  WidgetsFlutterBinding.ensureInitialized();

  // Init Firebase
  await Firebase.initializeApp();

  // Init navigation services
  await NavigationService.init();

  // Init Networkservices
  NetworkService.init();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeManegerProvider>(
          create: (_) => ThemeManegerProvider(),
        ),
        ChangeNotifierProvider<DoctorViewModel>(
          create: (_) => DoctorViewModel(),
        ),
        ChangeNotifierProvider<AdminViewModel>(
          create: (_) => AdminViewModel(),
        ),
      ],
      child: Consumer<ThemeManegerProvider>(
        builder: (context, theme, _) {
          return MaterialApp(
            routes: Routes.routes,
            initialRoute: Routes.splashRoute,
            scaffoldMessengerKey: scaffoldMessengerKey,
            navigatorKey: NavigationService.navKey,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: theme.themeMode,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
