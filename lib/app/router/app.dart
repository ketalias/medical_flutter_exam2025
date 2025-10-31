import 'package:flutter/material.dart';
import '../router/app_router.dart';
import '../router/route_names.dart';

class ClinicApp extends StatelessWidget {
  const ClinicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clinic App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal, useMaterial3: true),
      initialRoute: RouteNames.home,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
