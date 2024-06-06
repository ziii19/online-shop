  import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../misc/constan.dart';
import '../../../provider/user_data/user_data_prov.dart';

List<Widget> userInfo(WidgetRef ref) => [
   Padding(
                padding: const EdgeInsets.only(top: 40, left: 25),
                child: Row(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: ref
                                      .watch(userDataProvider)
                                      .valueOrNull!
                                      .photoProfile !=
                                  null
                              ? NetworkImage(ref
                                  .watch(userDataProvider)
                                  .valueOrNull!
                                  .photoProfile!) as ImageProvider
                              : const AssetImage('assets/images/ikon.png'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ref.watch(userDataProvider).valueOrNull!.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                          ref.watch(userDataProvider).valueOrNull!.email,
                          style: const TextStyle(color: abuAbu, fontSize: 16),
                        )
                      ],
                    ),
                  ],
                ),
              ),
];

