part of 'books_bloc.dart';

@immutable
sealed class BooksEvent {}

class BooksInitialFecthEvent extends BooksEvent {}
