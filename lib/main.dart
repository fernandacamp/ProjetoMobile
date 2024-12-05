import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; 
import 'package:projeto_mobile/screens/login_page.dart';
import 'package:projeto_mobile/settings/routes.dart';
import 'screens/menu_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  
  await Firebase.initializeApp();  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Menu Design',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      initialRoute: AppRoutes.login,
      routes: AppRoutes.routes,
    );
  }
}