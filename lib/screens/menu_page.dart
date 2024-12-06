import 'package:flutter/material.dart';
import 'package:projeto_mobile/settings/routes.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                    Navigator.pop(context); // Ação para fechar o menu
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.close, color: Color.fromRGBO(146, 91, 245, 1)),
                  ),
                ),
              ),
            ),
            // Espaçamento entre o ícone e os itens do menu
            const SizedBox(height: 50),

            // Itens do menu centralizados
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildMenuItem(
                    context,
                    title: 'New Trip',
                    icon: Icons.add_location_alt,
                    color: Colors.white.withOpacity(0.7),
                  ),
                  const SizedBox(height: 20),
                  _buildMenuItem(
                    context,
                    title: 'Order History',
                    icon: Icons.history,
                    color: Colors.white.withOpacity(0.7),
                  ),
                  const SizedBox(height: 20),
                  _buildMenuItem(
                    context,
                    title: 'My Profile',
                    icon: Icons.person,
                    color: Colors.white,
                    isSelected: true,
                  ),
                  const SizedBox(height: 20),
                  _buildMenuItem(
                    context,
                    title: 'Change Password',
                    icon: Icons.lock,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ],
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
    required IconData icon,
    required Color color,
    bool isSelected = false,
  }) {
    return GestureDetector(
      onTap: () {
        switch (title) {
          case 'New Trip':
            Navigator.of(context).pushNamed(AppRoutes.newTrip);
            break;
          case 'Order History':
            Navigator.of(context).pushNamed(AppRoutes.orderHistory);
            break;
          case 'Meu Perfil':
            Navigator.of(context).pushNamed(AppRoutes.profile);
            break;
          case 'Mudar Senha':
            Navigator.of(context).pushNamed(AppRoutes.changePassword);
            break;
          default:
            break;
        }
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
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
