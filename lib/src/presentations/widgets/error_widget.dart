part of 'widget.dart';

class ErrorWidgetState extends StatelessWidget {
  final String error;
  final UserBloc userBloc;

  const ErrorWidgetState({super.key, required this.error, required this.userBloc});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Error: $error'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              userBloc.add(const FetchUsers(page: 1, perPage: 10));
            },
            child: const Text('Refresh'),
          ),
        ],
      ),
    );
  }
}
