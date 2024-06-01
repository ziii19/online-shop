import 'package:go_router/go_router.dart';
import 'package:online_shop/presentation/pages/login/login.dart';
import 'package:online_shop/presentation/pages/main_page/main_page.dart';
import 'package:online_shop/presentation/pages/register_page.dart/register.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router_provider.g.dart';

@Riverpod(keepAlive: true)
Raw<GoRouter> router(RouterRef ref) => GoRouter(
      routes: [
        GoRoute(
          path: '/main',
          name: 'main',
          builder: (context, state) => const MainPage(),
        ),
        GoRoute(
          path: '/login',
          name: 'login',
          builder: (context, state) => LoginPage(),
        ),
        GoRoute(
          path: '/register',
          name: 'register',
          builder: (context, state) => RegisterPage(),
        ),
      ],
      initialLocation: '/login',
      debugLogDiagnostics: true,
    );
