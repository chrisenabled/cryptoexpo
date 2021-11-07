
enum Indicator {
  MacD,
  Community,
}

enum Direction {
  UP, DOWN
}

class SignalType {
  final Indicator indicator;
  final String upDirectionName;
  final String downDirectionName;

  const SignalType(this.indicator, this.upDirectionName, this.downDirectionName);
}

const SignalType MacD = SignalType(Indicator.MacD, 'Buy', 'Sell');

const SignalType Community = SignalType(Indicator.Community, 'Bull', 'Bear');


class Signal {
  final String pair;
  final String type;
  final Direction direction;
  final String directionName;
  final DateTime time;

  Signal(this.type, this.direction, this.time, this.pair, this.directionName);
}