

abstract class JsonSerialized<T> {

  Map<String, dynamic> toJson();

  T fromJson(dynamic map);

  List<T>? listFromJson(List<dynamic>? json);

}
