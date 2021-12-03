
import 'package:cryptoexpo/modules/models/coin_data/coin_data.dart';
import 'package:cryptoexpo/widgets/lottie_buttom_navigation.dart';

import 'package:get/get.dart';

class HomeController extends GetxController {

  static HomeController to = Get.find();

  RxInt _selectedPos = 0.obs;

  RxInt get selectedPos => _selectedPos;

  String? _selectedDerivative = (Get.find<List<CoinMetaData>>())[0].id ;

  String? get selectedDerivative => _selectedDerivative ;

  late LottieBottomNavigationController bottomNavigationController;

  @override
  void onInit() {
    super.onInit();

    bottomNavigationController =
        LottieBottomNavigationController(_selectedPos.value);

    bottomNavigationController.addListener(_handleBottomNavSelection);
  }

  void _handleBottomNavSelection() {
    _selectedPos.value = bottomNavigationController.value;
    update();
  }

  void navigateToDerivative(String coinId) {
    _selectedDerivative = coinId;
    bottomNavigationController.value = 2;
  }

}