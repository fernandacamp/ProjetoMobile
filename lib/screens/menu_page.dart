import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projeto_mobile/settings/routes.dart';
import 'usuario_provider.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Pegando o usuário atual do provider
    final usuarioProvider = Provider.of<UsuarioProvider>(context);
    final usuario = usuarioProvider.usuario;

    // Verifica se o usuário está autenticado
    if (usuario == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Menu')),
        body: const Center(child: Text('Usuário não autenticado')),
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(146, 91, 245, 1),
      body: SafeArea(
        child: Column(
          children: [
            // Ícone de fechar no topo esquerdo
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context); // Fecha o menu
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.close, color: Color.fromRGBO(146, 91, 245, 1)),
                  ),
                ),
              ),
            ),
            // Espaçamento entre o ícone e os itens do menu
            const SizedBox(height: 20),
            // Saudação personalizada ao usuário
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Bem-vindo, ${usuario.nome}!',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Itens do menu
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildMenuItem(
                    context,
                    title: 'New Trip',
                    route: AppRoutes.newTrip,
                    icon: Icons.add_location_alt,
                    color: Colors.white.withOpacity(0.7),
                  ),
                  const SizedBox(height: 20),
                  _buildMenuItem(
                    context,
                    title: 'Order History',
                    route: AppRoutes.orderHistory,
                    icon: Icons.history,
                    color: Colors.white.withOpacity(0.7),
                  ),
                  const SizedBox(height: 20),
                  _buildMenuItem(
                    context,
                    title: 'My Profile',
                    route: AppRoutes.profile,
                    icon: Icons.person,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 20),
                  _buildMenuItem(
                    context,
                    title: 'Change Password',
                    route: AppRoutes.changePassword,
                    icon: Icons.lock,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ],
              ),
            ),

            // Botão de logout
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  usuarioProvider.logout();
                  Navigator.pushReplacementNamed(context, AppRoutes.login);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.redAccent,
                ),
                child: const Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required String title,
    required String route,
    required IconData icon,
    required Color color,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(route);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: color,
            size: 28,
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 24,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
