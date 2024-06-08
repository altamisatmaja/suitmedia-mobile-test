part of 'service.dart';

class ApiService {
  final String baseUrl = dotenv.env['API_BASE_URL']!;

  Future<Map<String, dynamic>> fetchDataWithPagination(String endpoint, int page, int perPage) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$endpoint?page=$page&per_page=$perPage'));
      debugPrint('$baseUrl/$endpoint?page=$page&per_page=$perPage');
      debugPrint('Response: ${response.body}');
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Gagal mendapatkan data: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('$e');
      throw Exception('Gagal terhubung ke server: $e');
    }
  }
}
