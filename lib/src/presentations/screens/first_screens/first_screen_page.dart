part of '../screen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
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
    final userSingleton = UserSingleton();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: BlocListener<PalindromeBloc, PalindromeState>(
          listener: (context, state) {
            if (state is PalindromeResult) {
              final String message =
                  state.isPalindrome ? 'isPalindrome' : 'not Palindrome';
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(message),
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
          child: Center(
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              primary: false,
              padding: const EdgeInsets.all(16.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30.0),
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
                      CustomTextField(
                        controller: nameEditingController,
                        hintText: 'Name',
                      ),
                      const SizedBox(height: 16.0),
                      CustomTextField(
                        controller: textEditingController,
                        hintText: 'Palindrome',
                      ),
                      const SizedBox(height: 30.0),
                      CustomButton(
                        text: 'CHECK',
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
                      ),
                      const SizedBox(height: 16.0),
                      CustomButton(
                        text: 'NEXT',
                        onPressed: () {
                          final String name = nameEditingController.text;
                          if (name.isNotEmpty) {
                            userSingleton.userName = name;
                            Navigator.pushNamed(context, Routes.secondScreen);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text('Please enter your name.'),
                            ));
                          }
                        },
                      ),
                      const SizedBox(height: 60.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
