import 'package:test_magang/models/menu.dart';

class Checkout {
  int id;
  Menu menu;
  String? catatan;
  int count;

  Checkout(
      {required this.id,
      required this.menu,
      this.catatan,
      required this.count});
}
