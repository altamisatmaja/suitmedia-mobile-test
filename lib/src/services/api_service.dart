part of 'service.dart';

class ApiService {
  final String baseUrl = dotenv.env['API_URL']!;

  Future<Map<String, dynamic>> fetchDataWithPagination(String endpoint, int page, int perPage) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$endpoint?page=$page&per_page=$perPage'));
      debugPrint('Response: ${response.body}');
      
      return response.statusCode == 200 ? json.decode(response.body) : throw Exception('Gagal mendapatkan data');
    } catch (e) {
      throw Exception('Gagal terhubung ke server');
    }
  }
}
