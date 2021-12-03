
class SignalAlert {
  final String? coinId;
  final String? signalType;
  final String? alertMsg;
  final num? duration;
  final num? price;
  final num? volume;
  DateTime? time;

  SignalAlert({
    required this.coinId,
    required this.signalType,
    required this.alertMsg,
    required this.duration,
    required this.price,
    required this.volume,
  });

  @override
  String toString() {
    // TODO: implement toString
    return 'SignalAlert-> coinId: $coinId, alertType: $signalType,'
        ' alertMsg:$alertMsg, duration: $duration ';
  }
}