import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tes_interview_flutter/books/models/book_model.dart';
import 'package:tes_interview_flutter/favorite_books/repositories/favorite_books_repo.dart';

part 'favorite_books_event.dart';
part 'favorite_books_state.dart';

class FavoriteBooksBloc extends Bloc<FavoriteBooksEvent, FavoriteBooksState> {
  FavoriteBooksBloc() : super(FavoriteBooksInitial()) {
    on<FavoriteBooksInsertEvent>(favoriteBooksInsert);
    on<FavoriteBooksGetEvent>(favoriteBooksGet);
    on<FavoriteBooksDeleteAllEvent>(favoriteBooksDeleteAll);
    on<FavoriteBooksDeleteEvent>(favoriteBooksDelete);
  }

  FutureOr<void> favoriteBooksInsert(event, emit) async {
    FavoriteBooksInsertEvent favoriteBooksInsertEvent = event as FavoriteBooksInsertEvent;
    await FavoriteBooksRepo.insertData(favoriteBooksInsertEvent.book);
    List<Result> books = await FavoriteBooksRepo.getData();
    emit(FavoriteBooksGetState(books: books));
  }

  FutureOr<void> favoriteBooksGet(event, emit) async {
    List<Result> books = await FavoriteBooksRepo.getData();
    emit(FavoriteBooksGetState(books: books));
  }

  FutureOr<void> favoriteBooksDeleteAll(event, emit) async {
    await FavoriteBooksRepo.deleteAllData();
    List<Result> books = await FavoriteBooksRepo.getData();
    emit(FavoriteBooksGetState(books: books));
  }

  FutureOr<void> favoriteBooksDelete(event, emit) async {
    FavoriteBooksDeleteEvent favoriteBooksDeleteEvent = event as FavoriteBooksDeleteEvent;
    await FavoriteBooksRepo.deleteData(favoriteBooksDeleteEvent.book);
    List<Result> books = await FavoriteBooksRepo.getData();
    emit(FavoriteBooksGetState(books: books));
  }
}
