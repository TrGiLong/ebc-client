import 'package:bloc/bloc.dart';
import 'package:ebc_app/model/block.dart';
import 'package:ebc_app/repository/ebc_repository.dart';
import 'package:equatable/equatable.dart';

part 'block_state.dart';

class BlockCubit extends Cubit<BlockState> {
  final EbcRepository repository;

  BlockCubit(this.repository) : super(BlockState());

  Future<void> fetch(int index) async {
    if (state.fetching) return;
    try {
      emit(state.copyWith(fetching: true));
      final block = await repository.get(index);
      emit(state.copyWith(block: block));
    } finally {
      emit(state.copyWith(fetching: false));
    }
  }
}
