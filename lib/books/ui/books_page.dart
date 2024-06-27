import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tes_interview_flutter/books/bloc/books_bloc.dart';
import 'package:tes_interview_flutter/favorite_books/ui/favorite_books_page.dart';

class BooksPage extends StatelessWidget {
  final BooksBloc booksBloc = BooksBloc();
  BooksPage({super.key}) {
    booksBloc.add(BooksInitialFecthEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Books')),
      floatingActionButton: ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const FavoriteBooksPage()));
          },
          child: const Text('Favorites')),
      body: BlocBuilder<BooksBloc, BooksState>(
        bloc: booksBloc,
        builder: (context, state) {
          if (state.runtimeType == BooksLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.runtimeType == BooksSuccessState) {
            final booksSuccess = state as BooksSuccessState;
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                itemCount: booksSuccess.book.results.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(booksSuccess.book.results[index].title),
                  subtitle: Text(booksSuccess.book.results[index].authors[0].name),
                  trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
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
