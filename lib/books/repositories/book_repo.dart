import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:tes_interview_flutter/books/models/book_model.dart';

class BookRepo {
  static Future<BookModel> fetchBooks() async {
    try {
      var response = await http.get(Uri.parse('https://gutendex.com/books'));
      Map result = jsonDecode(response.body);
      BookModel books = BookModel.fromJson(result as Map<String, dynamic>);
      return books;
    } catch (e) {
      log(e.toString());
      return BookModel(count: 0, next: "", previous: null, results: []);
    }
  }
}
