
class SignalAlert {
  final String coinId;
  final String alertType;
  final String alertMsg;
  final num duration;

  SignalAlert({
    required this.coinId,
    required this.alertType,
    required this.alertMsg,
    required this.duration
  });

  @override
  String toString() {
    // TODO: implement toString
    return 'SignalAlert-> coinId: $coinId, alertType: $alertType,'
        ' alertMsg:$alertMsg, duration: $duration ';
  }
}