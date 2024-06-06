import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_shop/presentation/provider/router/router_provider.dart';

import '../../misc/constan.dart';
import 'btn_help_page/btn_help.dart';

class HelpPage extends ConsumerWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                    ),
                    child: InkWell(
                      onTap: () {
                        ref.read(routerProvider).pop();
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.arrow_back_ios_new,
                            size: 28,
                            color: hitam,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Help',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: hitam),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                const Center(
                  child: Text(
                    'Contact Us',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: hitam,
                        decoration: TextDecoration.underline),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const BtnHelp(
                  icon: Icons.room_service,
                  text: 'Customer Service',
                ),
                const BtnHelp(
                  icon: Icons.wifi_password,
                  text: 'Whatsapp',
                ),
                const BtnHelp(
                  icon: Icons.web_asset,
                  text: 'Website',
                ),
                const BtnHelp(
                  icon: Icons.facebook_outlined,
                  text: 'Facebook',
                ),
                const BtnHelp(
                  icon: Icons.broken_image_rounded,
                  text: 'Twiter',
                ),
                const BtnHelp(
                  icon: Icons.app_shortcut_outlined,
                  text: 'Instagram',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
