
import 'package:cryptoexpo/modules/interfaces/json_serialized.dart';

class SignalIndicator implements JsonSerialized<SignalIndicator> {
  final String? name;
  final List<String>? messages;
  final List<num>? durationsInMin;
  final String? description;
  final List<String> includeTickers; // indicator only works with coins in include

  SignalIndicator({
     this.name,
     this.messages,
     this.durationsInMin,
     this.description,
    List<String>? includeTickers
  }) : includeTickers = includeTickers?? <String>[] ;

  @override
  SignalIndicator fromJson(dynamic _json) {

    final json = _json as Map<String, dynamic>;
    
    final List<String>? includeTickers = json.containsKey('include_tickers')
        ?  List.from(json['include_tickers']) : <String>[];

    return SignalIndicator(
      name: json['name'],
      messages: List<String>.from(json['messages']),
      durationsInMin: List<num>.from(json['durations']),
      description: json['description'],
      includeTickers: includeTickers
    );

  }

  @override
  List<SignalIndicator>? listFromJson(List<dynamic>? json) {
    if(json == null || json.length == 0) return null;

    final list = json.cast<Map<String, dynamic>>();
    return list.map((j) => SignalIndicator().fromJson(j)).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'messages': messages,
      'durations': durationsInMin,
      'description': description,
      'include_tickers': includeTickers
    };
  }
}