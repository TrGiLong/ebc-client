part of 'block_chain_cubit.dart';

class BlockChainState extends Equatable {
  final bool fetching;
  final List<Block> blocks;

  const BlockChainState({
    this.fetching = false,
    this.blocks = const [],
  });

  @override
  List<Object> get props => [fetching, blocks];

  BlockChainState copyWith({bool? fetching, List<Block>? blocks}) {
    return BlockChainState(
        fetching: fetching ?? this.fetching, blocks: blocks ?? this.blocks);
  }
}
