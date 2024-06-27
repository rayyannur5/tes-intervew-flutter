import 'package:json_store/json_store.dart';
import 'package:tes_interview_flutter/books/models/book_model.dart';

class FavoriteBooksRepo {
  static insertData(Result result) async {
    JsonStore jsonStore = JsonStore();
    Map<String, dynamic> favorites = await jsonStore.getItem('favorites') ?? {'favorites': []};
    favorites['favorites'].add(result.toJson());
    await jsonStore.setItem('favorites', favorites);
  }

  static Future<List<Result>> getData() async {
    JsonStore jsonStore = JsonStore();
    Map<String, dynamic> favorites = await jsonStore.getItem('favorites') ?? {'favorites': []};
    List<Result> books = favorites['favorites'].map<Result>((favorite) => Result.fromJson(favorite)).toList();
    return books;
  }

  static deleteAllData() async {
    JsonStore jsonStore = JsonStore();
    await jsonStore.setItem('favorites', {'favorites': []});
  }

  static deleteData(Result result) async {
    JsonStore jsonStore = JsonStore();
    Map<String, dynamic> favorites = await jsonStore.getItem('favorites') ?? {'favorites': []};
    favorites['favorites'].removeWhere((element) => Result.fromJson(element).id == result.id);
    await jsonStore.setItem('favorites', favorites);
  }
}
