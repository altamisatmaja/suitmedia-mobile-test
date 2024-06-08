part of 'repository.dart';

class PalindromeRepository {
  bool isPalindrome(String text) {
    String cleanText = text.replaceAll(" ", "").toLowerCase();
    int left = 0;
    int right = cleanText.length - 1;
    while (left < right) {
      if (cleanText[left] != cleanText[right]) {
        return false;
      }
      left++;
      right--;
    }
    return true;
  }
}