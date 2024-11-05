import 'package:flutter/material.dart';
import 'package:projeto_mobile/settings/color.dart';
import 'package:projeto_mobile/settings/fonts.dart';

import '../repositores/pet_repository.dart';
import '../settings/routes.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  // Instância do repositório de pets
  final PetRepository petRepository = PetRepository();
  
  // Lista para armazenar os dados dos pets
  late List<Map<String, dynamic>> allPets;

  // Exemplo de dados de pedidos
  final List<Map<String, dynamic>> _orderHistory = [
    {'orderNumber': '001', 'date': '02/11/2024', 'status': 'Entregue'},
    {'orderNumber': '002', 'date': '28/10/2024', 'status': 'Em trânsito'},
    {'orderNumber': '003', 'date': '20/10/2024', 'status': 'Cancelado'},
    {'orderNumber': '004', 'date': '02/11/2024', 'status': 'Entregue'},
    {'orderNumber': '005', 'date': '28/10/2024', 'status': 'Em trânsito'},
    {'orderNumber': '006', 'date': '20/10/2024', 'status': 'Cancelado'},
  ];

  @override
  void initState() {
    super.initState();
    // Carregar todos os pets na lista
    allPets = petRepository.getAllPets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: AppColors.menuTextColor,
        ),
        title: Text('Histórico de Pedidos de Pets',
        style: AppFonts.defaultLarger.copyWith(color: AppColors.menuTextColor)),
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: allPets.isEmpty
            ? Center(
                child: Text(
                  'Nenhum pet encontrado.',
                  style: AppFonts.boldRegular.copyWith(color: AppColors.menuTextColor),
                ),
              )
            : ListView.builder(
                itemCount: allPets.length, // Alterado para a quantidade de pets
                itemBuilder: (context, index) {
                  final pet = allPets[index];
                  final order = _orderHistory[index]; // Acesso ao histórico de pedidos
                  return Card(
                    margin: EdgeInsets.only(bottom: 16),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.purple.shade100,
                        child: Icon(Icons.pets, color: Colors.purple),
                      ),
                      title: Text(
                        pet['name'], // Exibe o nome do pet
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Data: ${order['date']}'), // Exibe a data do pedido
                      trailing: Text(
                        order['status'], // Exibe o status do pedido
                        style: TextStyle(
                          color: order['status'] == 'Entregue'
                              ? Colors.green
                              : order['status'] == 'Em trânsito'
                                  ? Colors.orange
                                  : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        // Ação ao clicar no pedido (exibir detalhes, por exemplo)
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}
