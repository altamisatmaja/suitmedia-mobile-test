part of '../screen.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<UserBloc>().add(FetchUsers(page: 1, perPage: 10));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Third Screen'),
      ),
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.error}')),
            );
          }
        },
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, stateUser) {
            if (stateUser is UserInitial || stateUser is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (stateUser is UserLoaded) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: stateUser.users.length,
                  itemBuilder: (context, index) {
                    final user = stateUser.users[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user.avatar!),
                      ),
                      title: Text('${user.firstName} ${user.lastName}'),
                      subtitle: Text(user.email!),
                      onTap: () {
                        final selectedUserName = '${user.firstName} ${user.lastName}';
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SecondScreen(userName: selectedUserName)),
                        );
                      },
                    );
                  },
                ),
              );
            } else if (stateUser is UserError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: ${stateUser.error}'),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        context.read<UserBloc>().add(FetchUsers(page: 1, perPage: 10));
                      },
                      child: const Text('Refresh'),
                    ),
                  ],
                ),
              );
            } else {
              // Tampilkan pesan "No data" jika tidak ada data yang ditemukan.
              return const Center(child: Text('No data'));
            }
          },
        ),
      ),
    );
  }
}
