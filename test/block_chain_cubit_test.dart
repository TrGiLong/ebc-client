import 'package:bloc_test/bloc_test.dart';
import 'package:ebc_app/cubit/block_chain_cubit.dart';
import 'package:ebc_app/repository/ebc_repository.dart';
import 'package:flutter_test/flutter_test.dart';

class BlockChainStatesMatcher extends CustomMatcher {
  final bool Function(int index, BlockChainState state) test;

  BlockChainStatesMatcher(this.test)
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
    blocTest<BlockChainCubit, BlockChainState>("init",
        build: () => BlockChainCubit(LocalEbcRepository()), expect: () => []);

    blocTest<BlockChainCubit, BlockChainState>("fetch",
        build: () => BlockChainCubit(LocalEbcRepository()),
        act: (cubit) => cubit.fetch(),
        expect: () => BlockChainStatesMatcher((index, state) {
              switch (index) {
                case 0:
                  return state.fetching == true && state.blocks.length == 0;
                case 1:
                  return state.fetching == true && state.blocks.length == 1;
                case 2:
                  return state.fetching == false && state.blocks.length == 1;
                default:
                  return false;
              }
            }));

    blocTest<BlockChainCubit, BlockChainState>("fetch",
        build: () => BlockChainCubit(LocalEbcRepository()),
        act: (cubit) async {
          await cubit.fetch();
          await cubit.insert("Test");
        },
        expect: () => BlockChainStatesMatcher((index, state) {
          switch (index) {
            case 0:
            case 1:
            case 2:
              return true;
            case 3:
              return state.fetching == true && state.blocks.length == 1;
            case 4:
              return state.fetching == true && state.blocks.length == 2;
            case 5:
              return state.fetching == false && state.blocks.length == 2;
            default:
              return false;
          }
        }));
  });
}
