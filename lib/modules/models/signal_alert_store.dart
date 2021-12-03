

import 'package:cryptoexpo/modules/models/signal_alert.dart';

class SignalAlertStore {
  final String type;
  final num duration;
  List<SignalAlert>? signalAlerts  = <SignalAlert>[] ;

  SignalAlertStore({
    required this.type,
    required this.duration,
    this.signalAlerts
  });

  SignalAlertStore copyWith({
    required List<SignalAlert> alerts
}) {
    return SignalAlertStore(
        type: this.type,
        duration: this.duration,
      signalAlerts: [...?(this.signalAlerts), ...alerts]

    );

  }
}