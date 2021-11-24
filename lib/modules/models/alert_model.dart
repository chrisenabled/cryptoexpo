

import 'package:cryptoexpo/modules/models/signal_alert.dart';

class AlertModel {
  final String type;
  final num duration;
  List<SignalAlert>? signalAlerts  = <SignalAlert>[] ;

  AlertModel({
    required this.type,
    required this.duration,
    this.signalAlerts
  });

  AlertModel copyWith({
    required List<SignalAlert> alerts
}) {
    return AlertModel(
        type: this.type,
        duration: this.duration,
      signalAlerts: [...?(this.signalAlerts), ...alerts]

    );

  }
}