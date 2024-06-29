import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_shop/presentation/methods/show_snackbar.dart';
import 'package:path/path.dart';

import '../../../../domain/usecases/edit_user/edit_user.dart';
import '../../../../domain/usecases/edit_user/edit_user_param.dart';
import '../../../misc/constan.dart';
import '../../../provider/router/router_provider.dart';
import '../../../provider/usecase/edit_user_prov.dart';
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
  TextEditingController phoneController = TextEditingController();
  TextEditingController _birthdateController =
      TextEditingController(text: "../../....");

  XFile? _image;
  bool _isLoading = false;
  final ImagePicker _picker = ImagePicker();
  final int _maxFileSize = 3 * 1024 * 1024;

  @override
  void initState() {
    super.initState();
    final userData = ref.read(userDataProvider).valueOrNull;
    if (userData != null) {
      nameController.text = userData.name;
      emailController.text = userData.email;
      _birthdateController.text = userData.birthday!;
      phoneController.text = userData.phoneNumber.toString();
    }
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
            _image = pickedFile;
          });
        }
      }
    }

    // ignore: no_leading_underscores_for_local_identifiers
    Future<void> _selectDate(TextEditingController controller) async {
      DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2101),
      );
      if (picked != null) {
        setState(() {
          controller.text = "${picked.day}/${picked.month}/${picked.year}";
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            ref.read(routerProvider).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: scaffold,
                backgroundImage:
                    _image != null ? FileImage(File(_image!.path)) : null,
                child: _image != null
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
                                  : const AssetImage('assets/images/ikon.png'),
                              fit: BoxFit.cover),
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                enabled: false,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            ProfileTextField(
              labelText: "Birthdate",
              controller: _birthdateController,
              isDate: true,
              selectDate: _selectDate,
            ),
            TextFormField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'Contact number',
                hintText: '+62',
              ),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 65, right: 65, bottom: 30),
        child: SizedBox(
          height: 50,
          width: double.infinity,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: navy),
              onPressed: _isLoading
                  ? null
                  : () async {
                      setState(() {
                        _isLoading = true;
                      });

                      var user = ref.watch(userDataProvider).valueOrNull!;

                      if (_image != null) {
                        String filename = basename(_image!.path);

                        Reference reference =
                            FirebaseStorage.instance.ref().child(filename);

                        if (user.photoProfile != null) {
                          Reference oldPp = FirebaseStorage.instance
                              .refFromURL(user.photoProfile!);
                          await oldPp.delete();
                        }

                        await reference.putFile(File(_image!.path));

                        String imgUrl = await reference.getDownloadURL();

                        if (imgUrl.isNotEmpty &&
                            nameController.text != user.name) {
                          var update = user.copyWith(
                            name: nameController.text,
                            photoProfile: imgUrl,
                            birthday: _birthdateController.text,
                            phoneNumber: num.parse(phoneController.text),
                          );

                          EditUser editUser = ref.read(editUserProvider);

                          editUser(EditUserParam(user: update));

                          ref.read(userDataProvider.notifier).refreshUserData();

                          ref.read(routerProvider).pop();
                        } else {
                          context
                              .showSnackbar('Failed to upload photo profile');
                        }
                      } else if (nameController.text != user.name ||
                          _birthdateController.text.isNotEmpty ||
                          phoneController.text.isNotEmpty) {
                        var update = user.copyWith(
                          name: nameController.text,
                          birthday: _birthdateController.text,
                          phoneNumber: num.parse(phoneController.text),
                        );

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

class ProfileTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool isDate;
  final Function(TextEditingController) selectDate;

  const ProfileTextField({
    super.key,
    required this.labelText,
    required this.controller,
    this.isDate = false,
    required this.selectDate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        readOnly: isDate,
        decoration: InputDecoration(
          labelText: labelText,
          suffixIcon: isDate
              ? IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () {
                    selectDate(controller);
                  },
                )
              : null,
        ),
      ),
    );
  }
}
