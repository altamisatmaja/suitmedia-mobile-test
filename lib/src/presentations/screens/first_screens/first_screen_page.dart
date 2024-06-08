part of '../screen.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Palindrome Checker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<PalindromeBloc, PalindromeState>(
          builder: (context, state) {
            if (state is PalindromeInitial) {
              return buildInitialInput(context);
            } else if (state is PalindromeResult) {
              return buildResult(context, state.isPalindrome);
            } else if (state is PalindromeError) {
              return buildErrorState(context, state.error);
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget buildInitialInput(BuildContext context) {
    late String sentence;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          decoration: const InputDecoration(
            labelText: 'Enter a sentence',
          ),
          onChanged: (value) {
            sentence = value;
          },
        ),
        const SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: () {
            if (sentence.isNotEmpty) {
              context.read<PalindromeBloc>().add(CheckPalindrome(sentence));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Please enter a sentence.'),
              ));
            }
          },
          child: const Text('Check'),
        ),
      ],
    );
  }

  Widget buildResult(BuildContext context, bool isPalindrome) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            isPalindrome ? 'Palindrome' : 'Not Palindrome',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SecondScreen()),
              );
            },
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }

  Widget buildErrorState(BuildContext context, String error) {
    return Center(
      child: Text('Error: $error'),
    );
  }
}
