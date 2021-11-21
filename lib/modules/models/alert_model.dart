

import 'package:cryptoexpo/modules/models/signal_alert.dart';

class AlertModel {
  final String type;
  final num duration;
  List<SignalAlert> signalAlerts = <SignalAlert>[];

  AlertModel({
    required this.type, required this.duration
  });
}