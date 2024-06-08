part of '../screen.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Third Screen'),
      ),
      body: BlocProvider(
        create: (context) => UserBloc(userRepository: UserRepository(apiService: ApiService())),
        child: const UserList(),
      ),
    );
  }
}

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserLoaded) {
          return ListView.builder(
            itemCount: state.users.length,
            itemBuilder: (context, index) {
              final user = state.users[index];
              return ListTile(
                title: Text('${user.firstName} ${user.lastName}'),
                onTap: () {
                  final selectedUserName = '${user.firstName} ${user.lastName}';
                  final secondScreenRoute = ModalRoute.of(context);
                  if (secondScreenRoute != null) {
                    Navigator.pop(context, selectedUserName);
                  }
                },
              );
            },
          );
        } else if (state is UserError) {
          return Center(child: Text('Error: ${state.error}'));
        } else {
          return const Center(child: Text('No data'));
        }
      },
    );
  }
}
