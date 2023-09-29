

import 'add_ads_controller.dart';

class AcceptPetsController {
  AcceptPetsController();

  static bool? isReady;
  static List<bool> listCheck = List<bool>.generate(3, (index) {
    return false;
  });

  static change2ListCheck(int index) {
    listCheck[index] = !listCheck[index];
    if (index == 0) {
      AddAdsController.animals = listCheck[index] ? 1 : 0;
    }
    else if (index == 1) {
      AddAdsController.visits = listCheck[index] ? 1 : 0;
    }
    else if (index == 2) {
      AddAdsController.smoking = listCheck[index] ? 1 : 0;
    }
  }
}
