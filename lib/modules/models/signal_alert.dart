
import 'package:cryptoexpo/modules/interfaces/json_serialized.dart';

class SignalAlert implements JsonSerialized {
  final String? coinId;
  final String? indicatorName;
  final String? alertMsg;
  final int? alertCode;
  final num? duration;
  final num? price;
  final num? volume;
  DateTime? time;

  SignalAlert({
     this.coinId,
     this.indicatorName,
     this.alertMsg,
     this.alertCode,
     this.duration,
     this.price,
     this.volume,
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

  @override
  fromJson(Map map) {
    final json = map as Map<String, dynamic>;

    return SignalAlert(
      coinId: json['coinId'],
      indicatorName: json['indicatorName'],
      alertMsg: json['alertMsg'],
      alertCode: json['alertCode'],
      duration: json['duration'],
      price: json['price'],
      volume: json['volume'],
      time: DateTime.parse(json['time']),
    );
  }

  @override
  List listFromJson(List<dynamic> json) {
    final list = json.cast<Map<String, dynamic>>();
    return list.map((j) => SignalAlert().fromJson(j)).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'coinId': coinId,
      'indicatorName': indicatorName,
      'alertMsg': alertMsg,
      'alertCode': alertCode,
      'duration': duration,
      'price': price,
      'volume': volume,
      'time': time.toString(),
    };
  }
}