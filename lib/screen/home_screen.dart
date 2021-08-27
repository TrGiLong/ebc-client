import 'package:ebc_app/cubit/block_chain_cubit.dart';
import 'package:ebc_app/widget/block_chain_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ebc_app/utils/error_dialog.dart';

import 'insert_block_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlockChainCubit>(
      create: (context) =>
          BlockChainCubit(context.read())..fetch().onError((error, stackTrace) => context.showError(error.toString())),
      child: Builder(builder: (context) => content(context)),
    );
  }

  Widget content(BuildContext context) {
    return PlatformScaffold(
      iosContentPadding: true,
      appBar: PlatformAppBar(
        title: Text("Simple Blockchain (etcd)"),
        trailingActions: [
          PlatformIconButton(
            icon: Icon(PlatformIcons(context).add),
            onPressed: () {
              final rootContext = context;
              showPlatformDialog(
                context: context,
                // barrierDismissible: true,
                builder: (context) {
                  return InsertBlockScreen(
                    onAdd: (value) {
                      rootContext.read<BlockChainCubit>().insert(value).then((_) {
                        // scrollController.animateTo(
                        //     scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 500),
                        //     curve: Curves.easeInOutQuint);
                      }).onError((error, stackTrace) => context.showError(error.toString()));
                    },
                  );
                },
              );
            },
            cupertino: (_, __) => CupertinoIconButtonData(padding: EdgeInsets.all(0)),
          )
        ],
      ),
      body: CustomScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        controller: scrollController,
        slivers: [
          CupertinoSliverRefreshControl(
            onRefresh: () async {
              try {
                await context.read<BlockChainCubit>().fetch();
              } catch (e) {
                context.showError(e.toString());
              }
            },
          ),
          BlockChainList(),
        ],
      ),
    );
  }
}
