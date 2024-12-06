import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Registrar usuário
  Future<User?> registerUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('Erro ao registrar usuário: $e');
      return null;
    }
  }

  // Fazer login do usuário
  Future<User?> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('Erro ao fazer login: $e');
      return null;
    }
  }

  // Logout do usuário
  Future<void> logoutUser() async {
    await _auth.signOut();
  }

  // Verificar se há usuário autenticado
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
