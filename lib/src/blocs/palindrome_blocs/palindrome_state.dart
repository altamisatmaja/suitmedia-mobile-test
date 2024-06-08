part of '../bloc.dart';

abstract class PalindromeState extends Equatable {
  const PalindromeState();

  @override
  List<Object> get props => [];
}

class PalindromeInitial extends PalindromeState {}

class PalindromeResult extends PalindromeState {
  final bool isPalindrome;

  const PalindromeResult(this.isPalindrome);

  @override
  List<Object> get props => [isPalindrome];
}

class PalindromeError extends PalindromeState {
  final String error;

  const PalindromeError({required this.error});

  @override
  List<Object> get props => [error];
}
