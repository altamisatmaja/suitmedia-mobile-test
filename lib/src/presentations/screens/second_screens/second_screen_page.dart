part of '../screen.dart';

class SecondScreen extends StatelessWidget {
  final String? userName;

  const SecondScreen({Key? key, this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome'),
            SizedBox(height: 20),
            Text('Show name from First Screen: ${userName ?? 'No name provided'}'),
            SizedBox(height: 20),
            Text('Selected User Name'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ThirdScreen()),
                );
              },
              child: Text('Choose a User'),
            ),
          ],
        ),
      ),
    );
  }
}
