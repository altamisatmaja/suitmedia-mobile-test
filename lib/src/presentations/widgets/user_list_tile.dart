part of 'widget.dart';

class UserListTile extends StatelessWidget {
  final User user;

  const UserListTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final userSingleton = UserSingleton();
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            final userName = ('${user.firstName} ${user.lastName}');
            debugPrint(userName);
            userSingleton.userName = userName;
            navigateAndRemoveUntil(context, Routes.secondScreen);
          },
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user.avatar!),
            ),
            title: Text('${user.firstName} ${user.lastName}',
                style: Config.textStyleTitleSmall),
            subtitle: Text(
              user.email!.toUpperCase(),
              style:
                  Config.textStyleBodyMedium.copyWith(color: Config.greyColor),
            ),
          ),
        ),
        const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: CustomerDivider(),
        ),
      ],
    );
  }
}
