import 'package:equatable/equatable.dart';

class Block extends Equatable {
  final int index;
  final int timeStamp;
  final String value;
  final String hash;
  final String prevHash;

  Block({
    required this.index,
    required this.timeStamp,
    required this.value,
    required this.hash,
    required this.prevHash,
  });

  @override
  List<Object> get props => [index, timeStamp, value, hash, prevHash];

  Map<String, dynamic> toMap() {
    return {
      'index': this.index,
      'timeStamp': this.timeStamp,
      'value': this.value,
      'hash': this.hash,
      'prevHash': this.prevHash,
    };
  }

  factory Block.fromMap(Map<String, dynamic> map) {
    return Block(
      index: map['Index'] as int,
      timeStamp: map['Timestamp'] as int,
      value: map['Value'] as String,
      hash: map['Hash'] as String,
      prevHash: map['PrevHash'] as String,
    );
  }

  factory Block.fromJson(Map<String, dynamic> json) => Block.fromMap(json);

  Map<String, dynamic> toJson() => toMap();
}
