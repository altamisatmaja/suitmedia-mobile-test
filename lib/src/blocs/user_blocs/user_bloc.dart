part of '../bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  List<User>? _users;

  UserBloc({required this.userRepository}) : super(UserInitial()) {
    on<FetchUsers>(_onFetchUsers);
  }

  Future<void> _onFetchUsers(FetchUsers event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      _users = await userRepository.getUsers(event.page, event.perPage);
      emit(UserLoaded(users: _users!));
    } catch (e) {
      emit(UserError(error: e.toString()));
    }
  }

  List<User>? get users => _users;
}
