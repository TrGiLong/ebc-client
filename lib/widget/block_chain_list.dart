import 'dart:math';

import 'package:ebc_app/cubit/block_chain_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:auto_route/auto_route.dart';

class BlockChainList extends StatelessWidget {
  BlockChainList({Key? key}) : super(key: key);

  final dateFormat = DateFormat('EE MMM dd yyyy HH:mm:ss');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlockChainCubit, BlockChainState>(builder: (context, state) {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final block = state.blocks[index];
            final dateTime = DateTime.fromMillisecondsSinceEpoch(block.timeStamp);

            return Column(
              children: [
                ListTile(
                  leading: Text("${block.index}"),
                  trailing: Icon(Icons.chevron_right),
                  title: Text(block.value),
                  onTap: () {
                    context.router.pushPath('/${block.index}');
                  },
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${dateFormat.format(dateTime)}'),
                      Text('Hash: ${block.hash.substring(0, 10)}'),
                      Text('PrevHash: ${block.prevHash.substring(0, min(block.prevHash.length, 10))}'),
                    ],
                  ),
                ),
                Divider(height: 1),
              ],
            );
          },
          childCount: state.blocks.length,
        ),
      );
    });
  }
}
