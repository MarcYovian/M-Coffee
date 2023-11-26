import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class CrudRepository {
  Future<void> _storeImage() async {
    try {
      final dir = await getTemporaryDirectory();
      print(dir);
    } catch (e) {}
  }
}
