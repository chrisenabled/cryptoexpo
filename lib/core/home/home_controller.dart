
import 'package:get/get.dart';

class HomeController extends GetxController {

  RxInt _selectedPos = 0.obs;

  RxInt get selectedPos => _selectedPos;

  setSelectedPos(int pos) {
    _selectedPos.value = pos;
    update();
  }

}