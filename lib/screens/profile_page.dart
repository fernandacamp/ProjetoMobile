import 'package:flutter/material.dart';
import 'package:projeto_mobile/settings/color.dart';
import 'package:projeto_mobile/settings/routes.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('My Profile'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: AppColors.greyColor),
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.menu);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Foto de perfil e nome do usuário
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.purple.shade100,
              child: Icon(Icons.person,
                  size: 60, color: Color.fromRGBO(146, 91, 245, 1)),
            ),
            SizedBox(height: 10),
            Text(
              'Karim Santel',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              '0167873902',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 30),

            _buildSettingsOption(
              icon: Icons.logout,
              title: 'Sair',
              onTap: () {
                Navigator.of(context).pushReplacementNamed(AppRoutes.login);
              },
            ),
            ListTile(
              leading: Icon(Icons.warning_amber_rounded, color: Colors.red),
              title: Text(
                'Desativar conta',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                // Ação para Desativar conta
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsOption(
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.purple.shade50,
        child: Icon(icon, color: Colors.purple),
      ),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
      onTap: onTap,
    );
  }
}
