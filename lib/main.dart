import 'package:device_info_plus/device_info_plus.dart';
import 'package:ebc_app/repository/ebc_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'router/app_router.gr.dart';

void main() {
  runApp(
    // MyApp(ebcRepository: EbcServerRepository('http://10.0.2.2:3000')),
    MyApp(ebcRepository: EbcServerRepository('http://104.248.24.218:3000')),
  );
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  final EbcRepository ebcRepository;

  MyApp({Key? key, required this.ebcRepository}) : super(key: key);

  Future<PlatformStyleData> getPlatformStyleData() async {
    if (kIsWeb) {
      final deviceInfo = DeviceInfoPlugin();
      final info = await deviceInfo.webBrowserInfo;
      if (describeEnum(info.browserName) == 'safari') {
        return PlatformStyleData(web: PlatformStyle.Cupertino);
      }
    }
    return PlatformStyleData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PlatformStyleData>(
      future: getPlatformStyleData(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Container();
        return PlatformProvider(
          settings: PlatformSettingsData(
              iosUsesMaterialWidgets: true, platformStyle: snapshot.data!),
          builder: (context) => RepositoryProvider<EbcRepository>.value(
            value: ebcRepository,
            child: PlatformApp.router(
              debugShowCheckedModeBanner: false,
              routerDelegate: _appRouter.delegate(),
              routeInformationParser: _appRouter.defaultRouteParser(),
              title: 'Flutter Demo',
              localizationsDelegates: <LocalizationsDelegate<dynamic>>[
                DefaultMaterialLocalizations.delegate,
                DefaultWidgetsLocalizations.delegate,
                DefaultCupertinoLocalizations.delegate,
              ],
            ),
          ),
        );
      },
    );
  }
}
