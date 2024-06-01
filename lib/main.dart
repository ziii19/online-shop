import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:online_shop/firebase_options.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_shop/presentation/misc/constan.dart';
import 'package:online_shop/presentation/misc/theme.dart';
import 'package:online_shop/presentation/pages/login/login.dart';
import 'package:online_shop/presentation/pages/register_page.dart/register.dart';
import 'package:online_shop/presentation/provider/router/router_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(
    child: MainApp(),
  ));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      theme: LightTheme(scaffold).theme,
      debugShowCheckedModeBanner: false,
      routeInformationParser: ref.watch(routerProvider).routeInformationParser,
      routeInformationProvider:
          ref.watch(routerProvider).routeInformationProvider,
      routerDelegate: ref.watch(routerProvider).routerDelegate,
    );
  }
}
