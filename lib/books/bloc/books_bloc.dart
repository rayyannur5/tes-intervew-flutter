import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tes_interview_flutter/books/models/book_model.dart';
import 'package:tes_interview_flutter/books/repositories/book_repo.dart';

part 'books_event.dart';
part 'books_state.dart';

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  BooksBloc() : super(BooksInitial()) {
    on<BooksInitialFecthEvent>(booksInitialFetchEvent);
  }

  FutureOr<void> booksInitialFetchEvent(event, emit) async {
    emit(BooksLoadingState());
    BookModel books = await BookRepo.fetchBooks();
    emit(BooksSuccessState(book: books));
  }
}
