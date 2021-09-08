import 'package:bloc/bloc.dart';
import 'package:ebc_app/model/block.dart';
import 'package:ebc_app/repository/ebc_repository.dart';
import 'package:equatable/equatable.dart';

part 'block_chain_state.dart';

class BlockChainCubit extends Cubit<BlockChainState> {
  final EbcRepository repository;

  BlockChainCubit(this.repository) : super(BlockChainState());

  Future<void> fetch() async {
    if (state.fetching) return;
    try {
      emit(state.copyWith(fetching: true));
      final blocks = await repository.getAll();
      emit(state.copyWith(blocks: blocks));
    } finally {
      emit(state.copyWith(fetching: false));
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }

  Future<void> insert(String value) async {
    try {
      emit(state.copyWith(fetching: true));
      final block = await repository.add(value);
      emit(state.copyWith(blocks: List.of(state.blocks)..add(block)));
    } finally {
      emit(state.copyWith(fetching: false));
    }
  }
}
