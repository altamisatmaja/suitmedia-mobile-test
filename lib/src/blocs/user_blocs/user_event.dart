part of '../bloc.dart';

abstract class UserEvent {}

class FetchUsers extends UserEvent {
  final int page;
  final int perPage;

  FetchUsers({required this.page, required this.perPage});
}
