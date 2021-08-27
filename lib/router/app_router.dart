import 'package:auto_route/annotations.dart';
import 'package:ebc_app/screen/block_detail_screen.dart';
import 'package:ebc_app/screen/home_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(path: '/', page: HomeScreen, initial: true),
    AutoRoute(path: '/:index', page: BlockDetailScreen),
  ],
)
class $AppRouter {}
