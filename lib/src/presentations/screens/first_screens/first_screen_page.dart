part of '../screen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController nameEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    nameEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 60.0),
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white.withOpacity(0.3),
                      child: const Icon(
                        Icons.person_add,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 40.0),
                    TextField(
                      controller: nameEditingController,
                      decoration: InputDecoration(
                        hintText: 'Name',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: textEditingController,
                      decoration: InputDecoration(
                        hintText: 'Palindrome',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          final String text = textEditingController.text;
                          if (text.isNotEmpty) {
                            context.read<PalindromeBloc>().add(CheckPalindrome(text));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text('Please enter a text.'),
                            ));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(43, 99, 123, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                        ),
                        child: const Text(
                          'CHECK',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          final String name = nameEditingController.text;
                          if (name.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SecondScreen(userName: name)),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text('Please enter your name.'),
                            ));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(43, 99, 123, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                        ),
                        child: const Text(
                          'NEXT',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    BlocListener<PalindromeBloc, PalindromeState>(
                      listener: (context, state) {
                        if (state is PalindromeResult) {
                          final String message = state.isPalindrome ? 'is Palindrome' : 'is Not Palindrome';
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Palindrome Result'),
                              content: Text('The entered text $message'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        } else if (state is PalindromeError) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Error: ${state.error}'),
                          ));
                        }
                      },
                      child: Container(),
                    ),
                    const SizedBox(height: 60.0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
