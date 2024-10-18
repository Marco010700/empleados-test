import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:empleados_test/routes/app_pages.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( 
      title: 'Empleados App',
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
