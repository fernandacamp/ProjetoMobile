import 'package:flutter/material.dart';
import 'package:projeto_mobile/settings/routes.dart';
import 'profile_page.dart'; 

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(146, 91, 245, 1),
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
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.close, color: Color.fromRGBO(146, 91, 245, 1)),
                  ),
                ),
              ),
            ),

            // Espaçamento entre o ícone e os itens do menu
            SizedBox(height: 50),

            // Itens do menu centralizados
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildMenuItem(context, 'New Trip', Colors.white.withOpacity(0.7)),
                  SizedBox(height: 20),
                  _buildMenuItem(context, 'Order History', Colors.white.withOpacity(0.7)),
                  SizedBox(height: 20),
                  _buildMenuItem(context, 'My Profile', Colors.white, isSelected: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String title, Color color, {bool isSelected = false}) {
    return GestureDetector(
      onTap: () {
        // Navegação baseada no título do item
        if (title == 'New Trip') {
           Navigator.of(context).pushNamed(AppRoutes.NewTrip);
        } else if (title == 'Order History') {
           Navigator.of(context).pushNamed(AppRoutes.orderHistory);
        } else if (title == 'My Profile') {
           Navigator.of(context).pushNamed(AppRoutes.profile);
        }
      },
      child: Text(
        title,
        style: TextStyle(
          color: color,
          fontSize: 24,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}