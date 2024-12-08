import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'package:projeto_mobile/screens/login_page.dart';
import 'package:projeto_mobile/screens/menu_page.dart';
import 'package:projeto_mobile/settings/routes.dart';
import 'package:projeto_mobile/repositories/task_repository.dart';
import 'package:projeto_mobile/models/task.dart';
import 'usuario_provider.dart';
import 'services/network_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Firebase
  await Firebase.initializeApp();

  // Configura o Firestore para persistência offline
  FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: true);

  // Inicializa o Hive
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());

  // Verifica conexão com a internet e sincroniza dados
  if (await NetworkService().isConnected()) {
    print("Conectado à internet. Sincronizando dados...");
    await syncDataToHive();
  } else {
    print("Sem conexão com a internet. Dados não sincronizados.");
  }

  // Abre a caixa de tarefas no Hive e sincroniza com o Firebase
  final taskBox = await Hive.openBox<Task>('tasks');
  final repository = TaskRepository(taskBox);
  await repository.syncWithFirebase();

  // Teste de exemplo: salvar e recuperar uma tarefa no Hive
  taskBox.put('task1', Task(id: '1', description: 'Primeira tarefa'));
  final task = taskBox.get('task1');
  print(task?.description); // Output: Primeira tarefa

  // Inicia o aplicativo com o Provider para gerenciar estado
  runApp(
    ChangeNotifierProvider(
      create: (context) => UsuarioProvider(),
      child: const MyApp(),
    ),
  );
}

// Sincroniza dados do Firestore com o Hive
Future<void> syncDataToHive() async {
  try {
    // Obter instância do Firebase Firestore
    final firestore = FirebaseFirestore.instance;

    // Acessar a coleção de tarefas
    final querySnapshot = await firestore.collection('tasks').get();

    // Abrir ou criar a caixa do Hive
    final taskBox = await Hive.openBox<Task>('tasks');

    // Percorrer documentos do Firestore e salvar no Hive
    for (var doc in querySnapshot.docs) {
      final task = Task(
        id: doc.id,
        description: doc['description'] ?? 'Descrição não fornecida',
      );

      // Salvar no Hive usando o ID do Firestore como chave
      taskBox.put(doc.id, task);
    }

    print('Sincronização de dados concluída com sucesso.');
  } catch (e) {
    print('Erro durante a sincronização de dados: $e');
  }
}

// Classe principal do aplicativo
class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return const MenuPage(); // Página inicial para usuários autenticados
          } else {
            return const LoginPage(); // Página de login para usuários não autenticados
          }
        },
      ),
      routes: AppRoutes.routes,
    );
  }
}
