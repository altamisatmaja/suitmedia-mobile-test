part of 'repository.dart';

class UserRepository {
  final ApiService apiService;

  UserRepository({required this.apiService});

  Future<List<User>> getUsers(int page, int perPage) async {
    final response = await apiService.fetchDataWithPagination('users', page, perPage);
    return (response['data'] as List).map((user) => User.fromJson(user)).toList();
  }
}
