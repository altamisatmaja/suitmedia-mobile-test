part of '../bloc.dart';

class PalindromeBloc extends Bloc<PalindromeEvent, PalindromeState> {
  final PalindromeRepository palindromeRepository;

  PalindromeBloc({required this.palindromeRepository}) : super(PalindromeInitial()) {
    on<CheckPalindrome>(_onCheckPalindrome);
  }

  Stream<PalindromeState> _onCheckPalindrome(CheckPalindrome event, Emitter<PalindromeState> emit) async* {
    try {
      final bool isPalindrome = await palindromeRepository.isPalindrome(event.text);
      yield PalindromeResult(isPalindrome);
    } catch (e) {
      yield PalindromeError(error: e.toString());
    }
  }
}
