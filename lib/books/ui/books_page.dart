import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tes_interview_flutter/books/bloc/books_bloc.dart';
import 'package:tes_interview_flutter/books/models/book_model.dart';
import 'package:tes_interview_flutter/favorite_books/bloc/favorite_books_bloc.dart';
import 'package:tes_interview_flutter/favorite_books/ui/favorite_books_page.dart';

class BooksPage extends StatelessWidget {
  BooksPage({super.key});

  bool checkFavorite(List<Result> favorites, Result book) {
    var favorite = favorites.where((element) => element.id == book.id).toList();
    if (favorite.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    BooksBloc booksBloc = context.read<BooksBloc>();
    FavoriteBooksBloc favoriteBooksBloc = context.read<FavoriteBooksBloc>();

    return Scaffold(
      appBar: AppBar(title: const Text('Books')),
      floatingActionButton: ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => FavoriteBooksPage(favoriteBooksBloc: favoriteBooksBloc)));
          },
          child: const Text('Favorites')),
      body: BlocBuilder<BooksBloc, BooksState>(
        bloc: booksBloc,
        builder: (context, state) {
          if (state.runtimeType == BooksLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.runtimeType == BooksSuccessState) {
            final booksSuccess = state as BooksSuccessState;
            favoriteBooksBloc.add(FavoriteBooksGetEvent());
            return BlocBuilder<FavoriteBooksBloc, FavoriteBooksState>(
              bloc: favoriteBooksBloc,
              builder: (context, state) {
                if (state.runtimeType == FavoriteBooksGetState) {
                  final favoriteBooksState = state as FavoriteBooksGetState;
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: RefreshIndicator(
                      onRefresh: () async {
                        booksBloc.add(BooksInitialFecthEvent());
                      },
                      child: ListView.builder(
                        itemCount: booksSuccess.book.results.length,
                        itemBuilder: (context, index) => ListTile(
                          title: Text(booksSuccess.book.results[index].title),
                          subtitle: Text(booksSuccess.book.results[index].authors[0].name),
                          trailing: IconButton(
                              onPressed: () {
                                if (checkFavorite(favoriteBooksState.books, booksSuccess.book.results[index])) {
                                  favoriteBooksBloc.add(FavoriteBooksDeleteEvent(book: booksSuccess.book.results[index]));
                                } else {
                                  favoriteBooksBloc.add(FavoriteBooksInsertEvent(book: booksSuccess.book.results[index]));
                                }
                              },
                              icon: checkFavorite(favoriteBooksState.books, booksSuccess.book.results[index]) ? const Icon(Icons.favorite, color: Colors.pink) : const Icon(Icons.favorite_border)),
                        ),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
