part of '../screen.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  final ScrollController _scrollController = ScrollController();
  late UserBloc _userBloc;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _userBloc = context.read<UserBloc>();
    _userBloc.add(const FetchUsers(page: 1, perPage: 10));

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (!_isLoading && _userBloc.hasMorePages) {
        setState(() {
          _isLoading = true;
        });
        _userBloc.add(FetchUsers(page: _userBloc.currentPage + 1, perPage: 10));
      }
    }
  }

  Future<void> _onRefresh() async {
    _userBloc.add(const FetchUsers(page: 1, perPage: 10));
  }

  Widget _buildLoadingList() {
    return Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.grey[300],
                                ),
                                title: Container(
                                  width: double.infinity,
                                  height: 10.0,
                                  color: Colors.grey[300],
                                ),
                                subtitle: Container(
                                  width: double.infinity,
                                  height: 10.0,
                                  color: Colors.grey[300],
                                ),
                              ),
                            );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Third Screen'),
        centerTitle: true,
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
            if (stateUser is UserInitial ||
                stateUser is UserLoading && _userBloc.currentPage == 1) {
              return const Center(child: CircularProgressIndicator());
            } else if (stateUser is UserLoaded) {
              _isLoading = false;
              return RefreshIndicator(
                onRefresh: _onRefresh,
                child: stateUser.users.isEmpty
                    ? const Center(child: Text('No data'))
                    : ListView.builder(
                        controller: _scrollController,
                        itemCount: stateUser.hasMore
                            ? stateUser.users.length + 1
                            : stateUser.users.length,
                        itemBuilder: (context, index) {
                          if (index < stateUser.users.length) {
                            final user = stateUser.users[index];
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(user.avatar!),
                              ),
                              title: Text('${user.firstName} ${user.lastName}'),
                              subtitle: Text(user.email!),
                              onTap: () {
                                final selectedUserName =
                                    '${user.firstName} ${user.lastName}';
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SecondScreen(
                                        userName: selectedUserName),
                                  ),
                                );
                              },
                            );
                          } else {
                            _buildLoadingList;
                          }
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
                        _userBloc.add(const FetchUsers(page: 1, perPage: 10));
                      },
                      child: const Text('Refresh'),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('No data'));
            }
          },
        ),
      ),
    );
  }
}
