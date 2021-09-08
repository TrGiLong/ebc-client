import 'package:bloc_test/bloc_test.dart';
import 'package:ebc_app/cubit/block_cubit.dart';
import 'package:ebc_app/repository/ebc_repository.dart';
import 'package:flutter_test/flutter_test.dart';

class BlockStatesMatcher extends CustomMatcher {
  final bool Function(int index, BlockState state) test;

  BlockStatesMatcher(this.test)
      : super("This matcher check all state", "BlockchainStates check", null);

  @override
  bool matches(Object? item, Map matchState) {
    for (var entry in (item as List).asMap().entries) {
      if (test(entry.key, entry.value) == false) return false;
    }
    return true;
  }
}

void main() {
  group('blockchain cubit', () {
    blocTest<BlockCubit, BlockState>("init",
        build: () => BlockCubit(LocalEbcRepository()), expect: () => []);

    blocTest<BlockCubit, BlockState>(
      "init",
      build: () => BlockCubit(LocalEbcRepository()),
      act: (cubit) => cubit.fetch(1),
      expect: () => BlockStatesMatcher((index, state) {
        switch (index) {
          case 0:
            return state.fetching == true && state.block == null;
          case 1:
            return state.fetching == true && state.block != null;
          case 2:
            return state.fetching == false && state.block != null;
          default:
            return false;
        }
      }),
    );
  });
}
