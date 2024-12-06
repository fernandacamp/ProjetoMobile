import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:projeto_mobile/screens/login_page.dart';
import 'package:projeto_mobile/screens/menu_page.dart';
import 'package:projeto_mobile/settings/routes.dart';
import 'package:projeto_mobile/repositories/task_repository.dart';
import 'package:projeto_mobile/models/task.dart';
import 'package:firebase_auth/firebase_auth.dart'; 
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Firebase e Hive
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  
  // Abre a caixa de tarefas no Hive
  var taskBox = await Hive.openBox<Task>('tasks');
  var repository = TaskRepository(taskBox);

  // Sincroniza dados do Hive com o Firebase
  await repository.syncWithFirebase();

  // Inicia o app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Transporte',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.purple),
      // Define a navegação inicial com base no estado do usuário
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return MenuPage(); // Página inicial para usuários autenticados
          } else {
            return LoginPage(); // Página de login para usuários não autenticados
          }
        },
      ),
      routes: AppRoutes.routes, 
    );
  }
}
