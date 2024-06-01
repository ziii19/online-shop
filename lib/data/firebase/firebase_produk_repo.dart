import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_shop/data/repositories/produk_repo.dart';
import 'package:online_shop/domain/entities/product.dart';
import 'package:online_shop/domain/entities/result.dart';

class FirebaseProdukRepo implements ProductRepo {
  final FirebaseFirestore _firebaseFirestore;

  FirebaseProdukRepo({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;
  @override
  Future<Result<Product>> addProduct({required Product product}) async {
    try {
      CollectionReference<Map<String, dynamic>> add =
          _firebaseFirestore.collection('product');

      await add.doc(product.id).set(product.toJson());

      DocumentSnapshot<Map<String, dynamic>> result =
          await add.doc(product.id).get();

      if (result.exists) {
        return Result.success(Product.fromJson(result.data()!));
      } else {
        return const Result.failed('Failed to Add Product');
      }
    } catch (e) {
      return Result.failed("Failed to Add Product $e");
    }
  }

  @override
  Future<Result<void>> deleteProduct({required int id}) async {
    try {
      DocumentReference<Map<String, dynamic>> documentReference =
          _firebaseFirestore.doc('product/$id');

      await documentReference.delete();
      return const Result.success(null);
    } catch (e) {
      return Result.failed('Failed to delete Product: $e');
    }
  }

  @override
  Future<Result<Product>> editProduct({required Product product}) async {
    try {
      DocumentReference<Map<String, dynamic>> reference =
          _firebaseFirestore.doc('product/${product.id}');

      await reference.update(product.toJson());

      DocumentSnapshot<Map<String, dynamic>> result = await reference.get();

      if (result.exists) {
        Product updateProduct = Product.fromJson(result.data()!);

        if (updateProduct == product) {
          return Result.success(updateProduct);
        } else {
          return const Result.failed("Failed to edit product");
        }
      } else {
        return const Result.failed("Failed to edit product");
      }
    } on FirebaseException catch (e) {
      return Result.failed(e.message ?? 'Failed to Edit Product');
    }
  }

  @override
  Future<Result<List<Product>>> getProduct({required String uid}) async {
    CollectionReference<Map<String, dynamic>> products =
        _firebaseFirestore.collection('product');

    try {
      var result = await products.where('uid', isEqualTo: uid).get();

      if (result.docs.isNotEmpty) {
        return Result.success(
            result.docs.map((e) => Product.fromJson(e.data())).toList());
      } else {
        return const Result.success([]);
      }
    } catch (e) {
      return const Result.failed('Failed to get user product');
    }
  }

  @override
  Future<Result<List<Product>>> getAllProduct() async {
    try {
      CollectionReference<Map<String, dynamic>> reference =
          _firebaseFirestore.collection('product');

      var result = await reference.get();

      if (result.docs.isNotEmpty) {
        return Result.success(
            result.docs.map((e) => Product.fromJson(e.data())).toList());
      } else {
        return const Result.success([]);
      }
    } catch (e) {
      return const Result.failed('Failed to get product');
    }
  }
}
