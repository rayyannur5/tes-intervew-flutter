import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tes_interview_flutter/favorite_books/bloc/favorite_books_bloc.dart';

class FavoriteBooksPage extends StatelessWidget {
  final FavoriteBooksBloc favoriteBooksBloc;
  FavoriteBooksPage({super.key, required this.favoriteBooksBloc}) {
    favoriteBooksBloc.add(FavoriteBooksGetEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      floatingActionButton: ElevatedButton(
          onPressed: () {
            favoriteBooksBloc.add(FavoriteBooksDeleteAllEvent());
          },
          child: const Text("Delete All")),
      body: BlocBuilder<FavoriteBooksBloc, FavoriteBooksState>(
        bloc: favoriteBooksBloc,
        builder: (context, state) {
          if (state.runtimeType == FavoriteBooksGetState) {
            FavoriteBooksGetState bookState = state as FavoriteBooksGetState;
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                itemCount: bookState.books.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(bookState.books[index].title),
                  subtitle: Text(bookState.books[index].authors[0].name),
                  trailing: IconButton(
                      onPressed: () {
                        favoriteBooksBloc.add(FavoriteBooksDeleteEvent(book: bookState.books[index]));
                      },
                      icon: const Icon(Icons.close)),
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
