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
  final userSingleton = UserSingleton();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Third Screen',
          style: Config.textStyleHeadlineSmall,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: CustomerDivider(),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Config.backColor),
          onPressed: () => navigateAndRemoveUntil(context, Routes.secondScreen),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: BlocListener<UserBloc, UserState>(
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
                return ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return const LoadingListTile();
                  },
                );
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
                              return UserListTile(user: user);
                            } else {
                              return const LoadingListTile();
                            }
                          },
                        ),
                );
              } else if (stateUser is UserError) {
                return ErrorWidgetState(
                    error: stateUser.error, userBloc: _userBloc);
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
