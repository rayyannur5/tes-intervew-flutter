import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tes_interview_flutter/books/bloc/books_bloc.dart';
import 'package:tes_interview_flutter/books/ui/books_page.dart';
import 'package:tes_interview_flutter/favorite_books/bloc/favorite_books_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final BooksBloc booksBloc = BooksBloc();
  final FavoriteBooksBloc favoriteBooksBloc = FavoriteBooksBloc();

  MyApp({super.key}) {
    booksBloc.add(BooksInitialFecthEvent());
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BooksBloc>(create: (context) => booksBloc),
        BlocProvider<FavoriteBooksBloc>(create: (context) => favoriteBooksBloc),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BooksPage(),
      ),
    );
  }
}
