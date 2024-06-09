part of '../bloc.dart';

class PalindromeBloc extends Bloc<PalindromeEvent, PalindromeState> {
  final PalindromeRepository palindromeRepository;

  PalindromeBloc({required this.palindromeRepository}) : super(PalindromeInitial()) {
    on<CheckPalindrome>(_onCheckPalindrome);
  }

  Future<void> _onCheckPalindrome(CheckPalindrome event, Emitter<PalindromeState> emit) async {
    try {
      final bool isPalindrome = palindromeRepository.isPalindrome(event.text);
      if (kDebugMode) {
        print(isPalindrome);
      }
      emit(PalindromeInitial());
      emit(PalindromeResult(isPalindrome));

    } catch (e) {
      emit(PalindromeError(error: e.toString()));
    }
  }
}