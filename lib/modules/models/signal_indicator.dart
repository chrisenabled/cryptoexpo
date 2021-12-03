
class SignalIndicator {
  final String name;
  final Map<int, String> messageTypes;
  final List<int> durations;
  final String description;

  SignalIndicator({
    required this.name,
    required this.messageTypes,
    required this.durations,
    required this.description
  });
}