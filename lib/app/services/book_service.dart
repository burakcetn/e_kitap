import 'package:getx_skeleton/app/data/books.dart';

import '../data/models/book_model.dart';
import '../data/models/books/word_model.dart';

class BookService {
  static BookService instance = BookService();
  List<BookManager> managers = [];

  Future<void> setBook(BookModel book) async {
    BookManager manager = BookManager(book);
    await manager.load();

    managers.add(manager);
  }

  List<BookManager> getManagers() => managers;
  init() async {
    for (var element in bookList) {
      await setBook(element);
    }

    for (int i = managers.length - 1; i >= 0; i--) {
      var manager = managers[i];
      if (manager.current == null) {
        managers.removeAt(i);
      }
    }
  }

  getLength() {
    return managers.length;
  }

  BookManager get(int index) {
    return managers[index];
  }
}
