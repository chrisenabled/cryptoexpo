
import 'package:cryptoexpo/modules/interfaces/json_serialized.dart';

class SignalIndicator implements JsonSerialized {
  final String? name;
  final List<String>? messages;
  final List<num>? durationsInMin;
  final String? description;

  SignalIndicator({
     this.name,
     this.messages,
     this.durationsInMin,
     this.description
  });

  @override
  SignalIndicator fromJson(dynamic _json) {

    final json = _json as Map<String, dynamic>;

    return SignalIndicator(
      name: json['name'],
      messages: List<String>.from(json['messages']),
      durationsInMin: List<num>.from(json['durations']),
      description: json['description'],
    );

  }

  @override
  List<SignalIndicator> listFromJson(List<dynamic> json) {
    final list = json.cast<Map<String, dynamic>>();
    return list.map((j) => SignalIndicator().fromJson(j)).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'messages': messages,
      'durations': durationsInMin,
      'description': description
    };
  }
}