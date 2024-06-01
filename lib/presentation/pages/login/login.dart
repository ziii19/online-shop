// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:online_shop/presentation/methods/show_snackbar.dart';
// import 'package:online_shop/presentation/misc/dimens.dart';
// import 'package:online_shop/presentation/provider/router/router_provider.dart';
// import 'package:online_shop/presentation/provider/user_data/user_data_prov.dart';
// import 'package:online_shop/presentation/widgets/text_field.dart';

// class LoginPage extends ConsumerWidget {
//   LoginPage({super.key});
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     ref.listen(
//       userDataProvider,
//       (previous, next) {
//         if (next is AsyncData) {
//           if (next.value != null) {
//             ref.read(routerProvider).goNamed('main');
//           }
//         } else if (next is AsyncError) {
//           context.showSnackbar(next.error.toString());
//         }
//       },
//     );
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView(
//           children: [
//             Dimens.dp200.height,
//             RegularTextInput(
//               labelText: 'Email',
//               controller: emailController,
//             ),
//             Dimens.dp20.height,
//             RegularTextInput(
//               labelText: 'Password',
//               obscureText: true,
//               maxLines: 1,
//               controller: passwordController,
//             ),
//             Dimens.dp20.height,
//             ElevatedButton(
//               onPressed: () {
//                 ref.read(userDataProvider.notifier).login(
//                     email: emailController.text,
//                     password: passwordController.text);
//               },
//               child: const Text('Login'),
//             ),
//             // switch (ref.watch(userDataProvider)) {
//             //   AsyncData(:final value) => value == null
//             //       ? SizedBox(
//             //           width: double.infinity,
//             //           child: ElevatedButton(
//             //               onPressed: () {
//             //                 ref.read(userDataProvider.notifier).login(
//             //                     email: emailController.text,
//             //                     password: passwordController.text);
//             //               },
//             //               child: const Text(
//             //                 'Login',
//             //                 style: TextStyle(fontWeight: FontWeight.bold),
//             //               )),
//             //         )
//             //       : const Center(
//             //           child: CircularProgressIndicator(),
//             //         ),
//             //   _ => const Center(
//             //       child: CircularProgressIndicator(),
//             //     ),
//             // },
//             ElevatedButton(
//                 onPressed: () {
//                   ref.read(routerProvider).goNamed('register');
//                 },
//                 child: const Text('Register'))
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_shop/presentation/methods/show_snackbar.dart';
import 'package:online_shop/presentation/misc/constan.dart';
import 'package:online_shop/presentation/provider/router/router_provider.dart';
import 'package:online_shop/presentation/widgets/btn_widget.dart';

import '../../misc/dimens.dart';
import '../../provider/user_data/user_data_prov.dart';
import '../../widgets/text_field.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({super.key});

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      userDataProvider,
      (previous, next) {
        if (next is AsyncData) {
          if (next.value != null) {
            ref.read(routerProvider).goNamed('main');
          }
        } else if (next is AsyncError) {
          context.showSnackbar(next.error.toString());
        }
      },
    );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(Dimens.dp16),
        child: ListView(
          children: [
            Dimens.dp20.height,
            Center(
              child: Image.asset(
                'assets/images/mutushop.png',
              ),
            ),
            RegularTextInput(
              labelText: 'Email',
              controller: emailController,
            ),
            Dimens.dp20.height,
            RegularTextInput(
              labelText: 'Password',
              obscureText: true,
              maxLines: 1,
              controller: passwordController,
            ),
            Dimens.dp32.height,
            switch (ref.watch(userDataProvider)) {
              AsyncData(:final value) => value == null
                  ? ButtonCustom(
                      color: hitam,
                      textBtn: 'Login',
                      onPressed: () {
                        ref.read(userDataProvider.notifier).login(
                            email: emailController.text,
                            password: passwordController.text);
                      },
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
              _ => const Center(
                  child: CircularProgressIndicator(),
                ),
            },
            Dimens.dp10.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account? "),
                TextButton(
                    onPressed: () {
                      ref.read(routerProvider).goNamed('register');
                    },
                    child: const Text(
                      'Register here',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
