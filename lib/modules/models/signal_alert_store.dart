

import 'package:cryptoexpo/modules/models/signal_alert.dart';

class SignalAlertStore {
  final String indicatorName;
  final num duration;
  List<SignalAlert>? signalAlerts  = <SignalAlert>[] ;

  SignalAlertStore({
    required this.indicatorName,
    required this.duration,
    this.signalAlerts
  });

  SignalAlertStore copyWith({
    required List<SignalAlert> alerts
}) {
    return SignalAlertStore(
        indicatorName: this.indicatorName,
        duration: this.duration,
      signalAlerts: [...?(this.signalAlerts), ...alerts]

    );

  }
}