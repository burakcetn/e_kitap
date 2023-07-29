import 'package:get/get.dart';
import 'package:getx_skeleton/app/data/books.dart';
import 'package:getx_skeleton/app/data/models/question/question_model.dart';
import 'package:getx_skeleton/app/routes/app_pages.dart';

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

  RxInt max = 0.obs;
  RxInt current = RxInt(0);
  RxString currentImage = RxString("assets/images/akdamar.jpg");
  List<BookManager> getManagers() => managers;
  init() async {
    QuestionManager.instance.load();
    max.value = bookList.length;
    int i = 0;
    for (var element in bookList) {
      i++;
      current.value = ((i / max.value) * 100).toInt();
      current.update((val) {});
      currentImage.value = element.imagePath;
      await setBook(element);
    }
    for (int i = managers.length - 1; i >= 0; i--) {
      var manager = managers[i];
      if (manager.current == null) {
        managers.removeAt(i);
      }
    }
    Get.offAndToNamed(Routes.LANDING);
  }

  getLength() {
    return managers.length;
  }

  BookManager get(int index) {
    return managers[index];
  }
}
