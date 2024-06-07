// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_shop/domain/usecases/edit_user/edit_user.dart';
import 'package:online_shop/domain/usecases/edit_user/edit_user_param.dart';
import 'package:online_shop/presentation/methods/show_snackbar.dart';
import 'package:online_shop/presentation/misc/constan.dart';
import 'package:online_shop/presentation/misc/dimens.dart';
import 'package:online_shop/presentation/provider/router/router_provider.dart';
import 'package:online_shop/presentation/provider/usecase/edit_user_prov.dart';
import 'package:path/path.dart';

import '../../../provider/user_data/user_data_prov.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  XFile? xfile;
  bool _isLoading = false;
  final ImagePicker _picker = ImagePicker();
  final int _maxFileSize = 3 * 1024 * 1024; // 3MB

  @override
  void initState() {
    super.initState();
    nameController.text = ref.read(userDataProvider).valueOrNull!.name;
    emailController.text = ref.read(userDataProvider).valueOrNull!.email;
  }

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    Future<void> _pickImage() async {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final file = File(pickedFile.path);
        final fileExtension = pickedFile.path.split('.').last.toLowerCase();
        if (fileExtension != 'jpg' && fileExtension != 'png') {
          context.showSnackbar(
              "Format file tidak didukung. Hanya JPG dan PNG yang diizinkan.");
        } else if (await file.length() > _maxFileSize) {
          context
              .showSnackbar("File terlalu besar. Ukuran maksimum adalah 3MB.");
        } else {
          setState(() {
            xfile = pickedFile;
          });
        }
      }
    }

    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: InkWell(
                onTap: () {
                  ref.read(routerProvider).pop();
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                    Dimens.dp16.width,
                    const Text(
                      'Edit Profile',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: scaffold,
                      backgroundImage:
                          xfile != null ? FileImage(File(xfile!.path)) : null,
                      child: xfile != null
                          ? null
                          : Container(
                              width: 100,
                              height: 100,
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
                                        : const AssetImage(
                                            'assets/images/ikon.png'),
                                    fit: BoxFit.cover),
                              ),
                            ),
                    ),
                  ),
                  Dimens.dp100.height,
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(label: Text('Name')),
                  ),
                  Dimens.dp20.height,
                  TextFormField(
                    controller: emailController,
                    enabled: false,
                    decoration: const InputDecoration(label: Text('Email')),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: navy),
              onPressed: _isLoading
                  ? null
                  : () async {
                      setState(() {
                        _isLoading = true;
                      });

                      var user = ref.watch(userDataProvider).valueOrNull!;

                      if (xfile != null) {
                        String filename = basename(xfile!.path);

                        Reference reference =
                            FirebaseStorage.instance.ref().child(filename);

                        if (user.photoProfile != null &&
                            nameController.text != user.name) {
                          Reference oldPp = FirebaseStorage.instance
                              .refFromURL(user.photoProfile!);
                          await oldPp.delete();
                        }

                        await reference.putFile(File(xfile!.path));

                        String imgUrl = await reference.getDownloadURL();

                        if (imgUrl.isNotEmpty) {
                          var update = user.copyWith(
                              name: nameController.text, photoProfile: imgUrl);

                          EditUser editUser = ref.read(editUserProvider);

                          editUser(EditUserParam(user: update));

                          ref.read(userDataProvider.notifier).refreshUserData();

                          ref.read(routerProvider).pop();
                        } else {
                          context
                              .showSnackbar('Failed to upload photo profile');
                        }
                      } else if (nameController.text != user.name) {
                        var update = user.copyWith(name: nameController.text);

                        EditUser editUser = ref.read(editUserProvider);

                        editUser(EditUserParam(user: update));

                        ref.read(userDataProvider.notifier).refreshUserData();

                        ref.read(routerProvider).pop();
                      } else {
                        context.showSnackbar('No changes made');
                      }
                      setState(() {
                        _isLoading = false;
                      });
                    },
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text(
                      'Update Profile',
                      style: TextStyle(color: white, fontSize: 16),
                    )),
        ),
      ),
    );
  }
}
