part of 'favorite_books_bloc.dart';

@immutable
sealed class FavoriteBooksState {}

final class FavoriteBooksInitial extends FavoriteBooksState {}

final class FavoriteBooksGetState extends FavoriteBooksState {
  final List<Result> books;
  FavoriteBooksGetState({required this.books});
}
