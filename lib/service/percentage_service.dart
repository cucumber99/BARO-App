import 'dart:convert';
import 'package:baro_project/models/percentage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class PercentageService {
  final storage = const FlutterSecureStorage();
  Future<Percentage> getPercentage() async {
    String? accessToken = await storage.read(key: 'accessToken');
    var response = await http
        .get(Uri.parse('${dotenv.get('SERVER_URL')}/analysis/rank'), headers: {'Authorization': 'Bearer $accessToken'});

    if (response.statusCode == 200) {
      return Percentage.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load percentage');
    }
  }
}
