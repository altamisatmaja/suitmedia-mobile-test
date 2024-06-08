part of '../screen.dart';

class SecondScreen extends StatelessWidget {
  final String? userName;

  const SecondScreen({super.key, this.userName});

  @override
  Widget build(BuildContext context) {
    final userSingleton = UserSingleton();

    String displayName = userSingleton.userName ?? 'Guest';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF554AF0)),
          onPressed: () => Navigator.pushNamed(context, Routes.firstScreen),
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
              const Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                displayName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              Center(
                child: Text(
                  'Selected $displayName',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const Spacer(),
              CustomButton(
                text: 'Choose a User',
                onPressed: () {
                  Navigator.pushNamed(context, Routes.thirdScreen);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
