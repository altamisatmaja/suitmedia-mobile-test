
part of 'widget.dart';

class UserListTile extends StatelessWidget {
  final User user;

  const UserListTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final userSingleton = UserSingleton();
    return GestureDetector(
      onTap: () {
        final userName = ('${user.firstName} ${user.lastName}');
        debugPrint(userName);
        userSingleton.userName = userName;
        Navigator.pushNamed(context, Routes.secondScreen);
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(user.avatar!),
        ),
        title: Text('${user.firstName} ${user.lastName}'),
        subtitle: Text(user.email!),
      ),
    );
  }
}
