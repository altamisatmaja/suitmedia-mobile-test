part of '../screen.dart';

class SecondScreen extends StatelessWidget {
  final String? userName;
  final String? userTemp;

  const SecondScreen({super.key, this.userName, this.userTemp});

  @override
  Widget build(BuildContext context) {
    final userSingleton = UserSingleton();

    String displayName = userSingleton.userName ?? '';
    String displayTempName = userTemp ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen', style: Config.textStyleHeadlineSmall),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Config.backColor),
          onPressed: () => navigateAndRemoveUntil(context, Routes.firstScreen),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: CustomerDivider(),
        ),
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome',
                style: Config.textStyleBodyMedium.copyWith(color: Config.fontColor, fontSize: 12.0)
              ),
              const SizedBox(height: 10.0),
              Text(
                displayName.isEmpty ? displayTempName : displayName,
                style: Config.textStyleHeadlineSmall
              ),
              const Spacer(),
              Center(
                child: Text(
                  'Selected ${displayName.isEmpty ? 'User Name' : displayName}',
                  style: Config.textStyleHeadlineMedium,
                ),
              ),
              const Spacer(),
              CustomButton(
                text: 'Choose a User',
                onPressed: () {
                  navigateAndRemoveUntil(context, Routes.thirdScreen);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
