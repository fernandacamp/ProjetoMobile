import 'dart:convert';
import 'package:http/http.dart' as http;

class CepService {
  static Future<Map<String, dynamic>?> getAddress(String cep) async {
    final url = Uri.parse('https://viacep.com.br/ws/$cep/json/'); 
    final response = await http.get(url); 

    if (response.statusCode == 200) { 
      return json.decode(response.body); 
    } else {
      return null; 
    }
  }
}
