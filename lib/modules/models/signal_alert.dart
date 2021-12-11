
class SignalAlert {
  final String? coinId;
  final String? indicatorName;
  final String? alertMsg;
  final int? alertCode;
  final num? duration;
  final num? price;
  final num? volume;
  DateTime? time;

  SignalAlert({
    required this.coinId,
    required this.indicatorName,
    required this.alertMsg,
    required this.alertCode,
    required this.duration,
    required this.price,
    required this.volume,
    this.time,
  });

  @override
  String toString() {
    // TODO: implement toString
    return 'SignalAlert-> coinId: $coinId, alertType: $indicatorName,'
        ' alertMsg:$alertMsg, duration: $duration ';
  }

  SignalAlert copyWith({
    String? coinId,
    String? indicatorName,
    String? alertMsg,
    num? duration,
    int? alertCode,
    num? price,
    num? volume,
    DateTime? time,
    SignalAlert? other,
  }) {
    if(other != null) {
      return copyWith(
        coinId: coinId?? other.coinId,
        indicatorName: indicatorName?? other.indicatorName,
        alertMsg: alertMsg?? other.alertMsg,
        alertCode: alertCode?? other.alertCode,
        duration: duration?? other.duration,
        price: price?? other.price,
        volume: volume?? other.volume,
        time: time?? other.time,
      );
    }

    return SignalAlert(
      coinId: coinId?? this.coinId,
      indicatorName: indicatorName?? this.indicatorName,
      alertMsg: alertMsg?? this.alertMsg,
      alertCode: alertCode?? this.alertCode,
      duration: duration?? this.duration,
      price: price?? this.price,
      volume: volume?? this.volume,
      time: time?? this.time,
    );
  }
}