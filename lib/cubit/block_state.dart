part of 'block_cubit.dart';

class BlockState extends Equatable {
  final bool fetching;
  final Block? block;

  const BlockState({this.fetching = false, this.block});

  @override
  List<Object?> get props => [fetching, block];

  BlockState copyWith({bool? fetching, Block? block}) {
    return BlockState(
      fetching: fetching ?? this.fetching,
      block: block ?? this.block,
    );
  }
}
