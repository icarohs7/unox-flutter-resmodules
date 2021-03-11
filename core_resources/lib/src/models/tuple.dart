class Tuple2<A,B> {
  final A value1;
  final B value2;

  const Tuple2(this.value1,this.value2);

  factory Tuple2.fromJson(Map<String, dynamic> json) {
    return Tuple2(json['value1'],json['value2']);
  }

  Map<String, dynamic> toJson() => {'value1': value1, 'value2': value2};

  Tuple2 copyWith({A? value1, B? value2}) {
    return Tuple2(value1 ?? this.value1, value2 ?? this.value2);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Tuple2 &&
          runtimeType == other.runtimeType &&
          value1 == other.value1 &&
          value2 == other.value2;

  @override
  int get hashCode => value1.hashCode ^ value2.hashCode;

  @override
  String toString() {
    return 'Tuple2(value1: $value1, value2: $value2)';
  }
}