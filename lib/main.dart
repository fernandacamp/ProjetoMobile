import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; 
import 'package:projeto_mobile/screens/login_page.dart';
import 'package:projeto_mobile/settings/routes.dart';
import 'screens/menu_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'repositories/task_repository.dart'; 
import 'models/task.dart'; 


void main() async {
  WidgetsFlutterBinding.ensureInitialized();  
  await Firebase.initializeApp();  
  runApp(MyApp());
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  var taskBox = await Hive.openBox<Task>('tasks');
  var repository = TaskRepository(taskBox);
  await repository.syncWithFirebase();
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
Hive.registerAdapter(TaskAdapter());
var taskBox = await Hive.openBox<Task>('tasks');
