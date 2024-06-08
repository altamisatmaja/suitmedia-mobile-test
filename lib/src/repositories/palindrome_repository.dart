part of 'repository.dart';

class PalindromeRepository {
  Future<bool> isPalindrome(String text) async {
    String cleanText = text.replaceAll(" ", "").toLowerCase();
    return cleanText == cleanText.split('').reversed.join('');
  }
}
