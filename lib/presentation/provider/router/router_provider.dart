import 'package:go_router/go_router.dart';
import 'package:online_shop/domain/entities/product.dart';
import 'package:online_shop/presentation/pages/account_page/sections/edit_profile_page.dart';
import 'package:online_shop/presentation/pages/detail_produk_page/detail_produk_page.dart';
import 'package:online_shop/presentation/pages/help_page/help_page.dart';
import 'package:online_shop/presentation/pages/product_page/sections/edit_product.dart';
import 'package:online_shop/presentation/pages/profile_page/profile_page.dart';
import '../../../domain/entities/user.dart';
import '../../pages/login/login.dart';
import '../../pages/main_page/main_page.dart';
import '../../pages/product_page/sections/form_product.dart';
import '../../pages/register_page.dart/register.dart';
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
        GoRoute(
          path: '/form-product',
          name: 'form-product',
          builder: (context, state) => const FormProduct(),
        ),
        GoRoute(
          path: '/detail-product',
          name: 'detail-product',
          builder: (context, state) =>
              DetailProdukPage(product: state.extra as Product),
        ),
        GoRoute(
          path: '/edit-product',
          name: 'edit-product',
          builder: (context, state) => EditProduct(state.extra as Product),
        ),
        GoRoute(
          path: '/edit-profile',
          name: 'edit-profile',
          builder: (context, state) => const EditProfilePage(),
        ),
        GoRoute(
          path: '/help',
          name: 'help',
          builder: (context, state) => const HelpPage(),
        ),
        GoRoute(
          path: '/profile',
          name: 'profile',
          builder: (context, state) => UserProfile(
            user: state.extra as User,
          ),
        )
      ],
      initialLocation: '/login',
      debugLogDiagnostics: true,
    );
