part of 'repository.dart';

class UserRepository {
  final ApiService apiService;

  UserRepository({required this.apiService});

  Future<List<User>> getUsers(int page, int perPage) async {
    try {
      final response = await apiService.fetchDataWithPagination('users', page, perPage);
      final data = (response['data'] as List).map((user) => User.fromJson(user)).toList();
      debugPrint('$data');
      return data;
    } catch (e) {
      debugPrint('$e');
      throw Exception('Gagal mendapatkan pengguna: $e');
    }
  }
}
