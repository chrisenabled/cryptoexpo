

abstract class JsonSerialized<T> {

  Map<String, dynamic> toJson();

  T fromJson(Map map);

  List<T>? listFromJson(List<dynamic>? json);

}
