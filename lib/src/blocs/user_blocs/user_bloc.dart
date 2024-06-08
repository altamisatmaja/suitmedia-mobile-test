part of '../bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  List<User>? _users;
  int _currentPage = 1;
  bool _hasMore = true;

  UserBloc({required this.userRepository}) : super(UserInitial()) {
    on<FetchUsers>(_onFetchUsers);
  }

  Future<void> _onFetchUsers(FetchUsers event, Emitter<UserState> emit) async {
    try {
      if (_users == null || event.page == 1) {
        emit(UserLoading());
      }
      final users = await userRepository.getUsers(event.page, event.perPage);
      _currentPage = event.page;
      if (_users == null || event.page == 1) {
        _users = users;
      } else {
        _users!.addAll(users);
      }
      _hasMore = users.isNotEmpty; // Update _hasMore based on whether there are more users
      emit(UserLoaded(users: _users!, hasMore: _hasMore));
    } catch (e) {
      emit(UserError(error: e.toString()));
    }
  }

  int get currentPage => _currentPage;
  bool get hasMorePages => _hasMore;
}
