part of 'favorite_books_bloc.dart';

@immutable
sealed class FavoriteBooksEvent {}

class FavoriteBooksInsertEvent extends FavoriteBooksEvent {
  final Result book;
  FavoriteBooksInsertEvent({required this.book});
}

class FavoriteBooksGetEvent extends FavoriteBooksEvent {}

class FavoriteBooksDeleteAllEvent extends FavoriteBooksEvent {}

class FavoriteBooksDeleteEvent extends FavoriteBooksEvent {
  final Result book;
  FavoriteBooksDeleteEvent({required this.book});
}
