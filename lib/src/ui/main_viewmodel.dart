import 'package:get/get.dart';
import 'package:it_project/src/ui/book_store_screen/store_screen.dart';
import 'package:it_project/src/ui/home_screen/home_screen.dart';
import 'package:it_project/src/ui/my_book/my_book_screen.dart';

class MainViewModel extends GetxController {
  final RxInt _tab = 0.obs;
  int get tab => _tab.value;
  set tab(int value) {
    _tab.value = value;
  }

  List tabs = [
    const HomeScreen(),
    const MyBookScreen(),
    const StoreScreen(),
    const HomeScreen(),
  ];
}
