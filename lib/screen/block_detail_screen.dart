import 'package:auto_route/annotations.dart';
import 'package:ebc_app/cubit/block_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:ebc_app/utils/error_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class BlockDetailScreen extends StatelessWidget {
  final String index;

  const BlockDetailScreen({Key? key, @PathParam() required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlockCubit>(
      create: (context) => BlockCubit(context.read())
        ..fetch(int.tryParse(index)!).onError((error, stackTrace) => context.showError(error.toString())),
      child: Builder(builder: (context) => content(context)),
    );
  }

  Widget content(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<BlockCubit, BlockState>(
      builder: (context, state) {
        return PlatformScaffold(
          iosContentPadding: true,
          appBar: PlatformAppBar(
            title: Text('Block ${state.block?.index ?? ''}'),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PlatformTextButton(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(state.block?.value ?? '', style: theme.textTheme.headline5),
                ),
                onPressed: () {
                  if (state.block != null) launch(state.block!.value);
                },
              ),
              Text("Index: ${state.block?.index ?? ''}", textAlign: TextAlign.center),
              const SizedBox(height: 16),
              Text("Hash", textAlign: TextAlign.center),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("${state.block?.hash}", textAlign: TextAlign.center),
              ),
              const SizedBox(height: 16),
              Text("Previous hash", textAlign: TextAlign.center),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("${state.block?.prevHash}", textAlign: TextAlign.center),
              ),
            ],
          ),
        );
      },
    );
  }
}
