import 'package:get/get.dart';
import 'package:it_project/src/features/main/home/search/search_screen.dart';
import 'main/home/home_screen.dart';
import 'main/me/me_screen.dart';
import 'my_book/my_book_screen.dart';

class MainViewModel extends GetxController {
  final RxInt _tab = 0.obs;
  int get tab => _tab.value;
  set tab(int value) {
    _tab.value = value;
  }

  final List tabs = [
    // const HomeScreen(),i
    const HomeScreen(),
    const SearchScreen(),
    const MyBookScreen(),
    const MeScreen(),
    // const HomeScreen(),
  ];
}
