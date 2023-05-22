// ignore_for_file: invalid_use_of_protected_member

import 'package:get/get.dart';
import 'package:test_magang/models/menu.dart';
import 'package:test_magang/models/voucher_model.dart';
import 'package:test_magang/source/source_menu.dart';

import '../models/checkout.dart';

class CMenu extends GetxController {
  final _loading = false.obs;
  bool get loading => _loading.value;

  final _listMenu = <Menu>[].obs;
  List<Menu> get listMenu => _listMenu.value;

  final _checkout = <Checkout>[].obs;
  List<Checkout> get checkout => _checkout.value;

  final _jumlahHarga = 0.obs;
  int get jumlah => _jumlahHarga.value;

  final _totalItem = 0.obs;
  int get totalItem => _totalItem.value;

  final _totalBayar = 0.obs;
  int get totalBayar => _totalBayar.value;

  final _vouchers = Vouchers().obs;
  Vouchers get voucher => _vouchers.value;

  final _voucherSukses = false.obs;
  bool get voucherSukses => _voucherSukses.value;

  final _postSukses = false.obs;
  bool get postSukses => _postSukses.value;

  final _batalBerhasil = false.obs;
  bool get batalBerhasil => _batalBerhasil.value;

  final _idCheckout = 0.obs;
  int get idCheckout => _idCheckout.value;
  setIdCheckout(int i) => _idCheckout.value = i;

  final _id = 0.obs;
  int get id => _id.value;

  setId(int i) => _id.value = i;

  setCheckout(String catatan, Menu menu, int count) async {
    final index =
        _checkout.value.indexWhere((element) => element.id == _id.value);
    if (index >= 0) {
      _checkout.value[index] =
          Checkout(id: _id.value, menu: menu, catatan: catatan, count: count);
    } else {
      _checkout.value.add(
          Checkout(id: _id.value, menu: menu, catatan: catatan, count: count));
    }
  }

  resetCheckout() {
    _checkout.value.clear();
    _id.value = 1;
  }

  getTotal() {
    _totalItem.value = listMenu.length;
    update();
  }

  resetTotal(int diskon) {
    if (_vouchers.value.nominal != null) {
      if (_vouchers.value.nominal! < _jumlahHarga.value) {
        _totalBayar.value = _totalBayar.value + diskon;
      }
    }
  }

  resetVoucher() {
    _voucherSukses.value = false;
  }

  updateVoucher(int diskon) async {
    _totalBayar.value = _totalBayar.value - diskon;
  }

  getVoucher(String kodeVoucher) async {
    _loading.value = true;
    update();
    _vouchers.value = await SourceMenu.getVouchers(kodeVoucher);
    update();
    if (_vouchers.value.nominal != null) {
      if (_vouchers.value.nominal! < _jumlahHarga.value) {
        _voucherSukses.value = true;
      }
    }
    update();
    _loading.value = false;
    update();
  }

  tambahJumlah(int jumlah) async {
    _jumlahHarga.value = _jumlahHarga.value + jumlah;
    _totalBayar.value = _totalBayar.value + jumlah;
    update();
  }

  kurangJumlah(int jumlah) async {
    _jumlahHarga.value = _jumlahHarga.value - jumlah;
    _totalBayar.value = _totalBayar.value - jumlah;
    update();
  }

  getListMenu() async {
    _loading.value = true;
    update();
    _listMenu.value = await SourceMenu.getItems();
    update();
    _loading.value = false;
    update();
  }

  postData(String body) async {
    _loading.value = true;
    update();
    _postSukses.value = await SourceMenu.postData(body);
    update();
    _loading.value = false;
  }

  pembatalan(int id) async {
    _loading.value = true;
    update();
    _batalBerhasil.value = await SourceMenu.batal(id);
    update();
    _loading.value = false;
  }
}
