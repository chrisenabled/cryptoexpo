
import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptoexpo/constants/constants.dart';
import 'package:cryptoexpo/modules/controllers/coin_controller.dart';
import 'package:cryptoexpo/modules/interfaces/json_serialized.dart';
import 'package:cryptoexpo/modules/models/signal_alert.dart';
import 'package:cryptoexpo/modules/models/signal_indicator.dart';
import 'package:cryptoexpo/utils/helpers/helpers.dart';
import 'package:cryptoexpo/utils/helpers/local_store.dart';
import 'package:get/get.dart';

class CoinFirestoreService extends GetxService {

  static CoinFirestoreService to = Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  List<SignalIndicator>? indicators;

  Future<T> fetchModel<T>({
    required String docPath,
    required JsonSerialized<T> instance,
  }) {
    return _db
        .doc(docPath)
        .get()
        .then((value) => instance.fromJson(value.data()));
  }

  Stream<T?> streamFirestoreModel<T>({
      required String path,
      required JsonSerialized<T> instance,
      String orderBy = ''
  }) {
    print('streamFirestoreModel()');
    final modelsRef = _db
        .doc(path);

        return modelsRef
            .snapshots().where((event) => false)
            .map((s) => instance.fromJson(s.data()));
  }

  Future<List<T>> fetchSignalAlerts<T> ({
    required String docPath,
    required String collectionPath,
    required JsonSerialized<T> instance
  }) {

    _db.collection('coin/$docPath/$collectionPath')
        .get()
        .then((value) => printInfo(info: '${value.size}'));

    return _db
        .collection('coin/$docPath/$collectionPath')
        .get()
        .then((querySnapshot) {
          printInfo(info:
          'coin/$docPath/$collectionPath, size: ${querySnapshot.size}');
          querySnapshot.docs.map((e) => printInfo(info: '${e.data()}'));
          return querySnapshot.docs.map((e) {
            printInfo(info: 'id of doc is ${e.id}');
            return instance.fromJson(e.data());
          }).toList();
        }).onError((error, stackTrace) => []);

  }

  Stream<List<T>?> streamSignalAlerts<T>({
    required String docPath,
    required String collectionPath,
    required JsonSerialized<T> instance
  }) {

    printInfo(info: 'coin/$docPath/$collectionPath');

    try {

      return _db
          .collection('coin/$docPath/$collectionPath')
          .snapshots()
          .map((querySnapshot) =>
          querySnapshot.docs.map((e) {
            printInfo(info: 'id of doc is ${e.id}');
            return instance.fromJson(e.data());
          }).toList());

    } catch (e) {
      printError(info: '$e');
      return Stream.empty();
    }

  }

  Stream<SignalAlert> signalStream(String coinId) =>
      Stream.periodic(Duration(minutes: 1))
          .asyncMap((event) => _fakeSignalAlert(coinId))
          .asBroadcastStream(onCancel: (sub) => sub.cancel()) ;

  Future<SignalAlert> _fakeSignalAlert(String coinId) async {
    if(indicators == null) {
      indicators = LocalStore.getOrSetSignalIndicator()!;
    }

    final indicator = indicators![getRandomNumber(0, indicators!.length)];

    final indicatorName = indicator.name!;

    final alertMsg = indicator.messages![
      getRandomNumber(0, indicator.messages!.length)];

    final alertCode = indicator.messages!.indexOf(alertMsg);

    final duration = indicator.durationsInMin![
      getRandomNumber(0, indicator.durationsInMin!.length)];

    final signal =  SignalAlert(
      coinId: coinId,
      indicatorName: indicatorName,
      alertMsg: alertMsg,
      alertCode: alertCode,
      duration: duration,
      volume: null,
      price: null,
      time: DateTime.now()
    );

    // printInfo(info: signal.toString());

    return signal;

  }
}