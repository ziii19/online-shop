import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../../../../domain/entities/entities.dart';
import '../../../methods/show_snackbar.dart';
import '../../../misc/constan.dart';
import '../../../misc/dimens.dart';
import '../../../provider/produk_data/produk_provider.dart';
import '../../../provider/router/router_provider.dart';
import '../../../widgets/text_field.dart';

class EditProduct extends ConsumerStatefulWidget {
  final Product product;
  const EditProduct(this.product, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditProductState();
}

class _EditProductState extends ConsumerState<EditProduct> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  XFile? xfile;
  bool _isLoading = false;
  final ImagePicker _picker = ImagePicker();
  final int _maxFileSize = 3 * 1024 * 1024; // 3MB

  @override
  void initState() {
    nameController.text = widget.product.nameProduct;
    descController.text = widget.product.desc;
    priceController.text = widget.product.price.toString();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    priceController.dispose();
    xfile = null; // Reset the selected file
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    Future<void> _editProduct() async {
      setState(() {
        _isLoading = true;
      });

      try {
        if (nameController.text != widget.product.nameProduct ||
            descController.text != widget.product.desc ||
            priceController.text != widget.product.price.toString() ||
            xfile != null) {
          var price = int.tryParse(priceController.text);

          if (xfile != null) {
            String filename = basename(xfile!.path);

            Reference reference =
                FirebaseStorage.instance.ref().child(filename);
            Reference oldImage =
                FirebaseStorage.instance.refFromURL(widget.product.imgProduct);

            oldImage.delete();
            await reference.putFile(File(xfile!.path));

            String downloadUrl = await reference.getDownloadURL();

            var updateProduct = widget.product.copyWith(
                price: price as int,
                nameProduct: nameController.text,
                desc: descController.text,
                imgProduct: downloadUrl);

            ref
                .read(produkDataProvider.notifier)
                .editProduct(product: updateProduct);
          } else {
            var updateProduct = widget.product.copyWith(
              price: price as int,
              nameProduct: nameController.text,
              desc: descController.text,
            );

            ref
                .read(produkDataProvider.notifier)
                .editProduct(product: updateProduct);
          }

          ref.read(produkDataProvider.notifier).refreshProductData();
          ref.read(routerProvider).pop();
        } else {
          context.showSnackbar('No changes made');
        }
      } catch (e) {
        // ignore: use_build_context_synchronously
        context.showSnackbar('An error occurred');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }

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
      appBar: AppBar(
        title: const Text('Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textForm(text: 'Image Product'),
                Dimens.dp20.height,
                InkWell(
                  onTap: _pickImage,
                  child: xfile != null
                      ? Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimens.dp8),
                              border: Border.all(color: Colors.grey.shade300),
                              image: DecorationImage(
                                  image: FileImage(File(xfile!.path)),
                                  fit: BoxFit.cover)),
                        )
                      : Container(
                          width: 150,
                          height: 150,
                          padding: const EdgeInsets.all(Dimens.dp16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimens.dp8),
                              border: Border.all(color: Colors.grey.shade300),
                              image: DecorationImage(
                                image: NetworkImage(widget.product.imgProduct),
                                fit: BoxFit.cover,
                              )),
                        ),
                ),
                Dimens.dp16.height,
                textForm(text: 'Product Name'),
                Dimens.dp10.height,
                RegularTextInput(
                  required: true,
                  hintText: 'product name',
                  controller: nameController,
                  maxLength: 20,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(20),
                  ],
                ),
                Dimens.dp16.height,
                textForm(text: 'Product Description'),
                Dimens.dp10.height,
                RegularTextInput(
                  required: true,
                  hintText: 'Product Description',
                  controller: descController,
                ),
                Dimens.dp16.height,
                textForm(text: 'Price'),
                Dimens.dp10.height,
                RegularTextInput(
                  required: true,
                  hintText: 'Rp 100.000,-',
                  controller: priceController,
                  maxLength: 10,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10)
                  ],
                  keyboardType: TextInputType.number,
                ),
                Dimens.dp100.height,
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(Dimens.dp16),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: navy,
            ),
            onPressed: _isLoading ? null : _editProduct,
            child: _isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : const Text(
                    'Edit Product',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
          ),
        ),
      ),
    );
  }

  Text textForm({required String text}) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    );
  }
}
