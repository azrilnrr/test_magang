import 'package:get/get.dart';
import 'package:test_magang/api/api.dart';
import 'package:test_magang/config/app_request.dart';
import 'package:test_magang/controller/cMenu_lawas.dart';
import 'package:test_magang/models/menu.dart';
import 'package:test_magang/models/voucher_model.dart';

class SourceMenu {
  static Future<List<Menu>> getItems() async {
    String url = '${Api.baseUrl}/menus';
    Map? responseBody = await AppRequest.get(url);

    if (responseBody == null) return [];
    if (responseBody.isNotEmpty) {
      List list = responseBody['datas'];
      return list.map((e) => Menu.fromJson(e)).toList();
    }
    return [];
  }

  static Future<Vouchers> getVouchers(String kode) async {
    String url = '${Api.baseUrl}/vouchers?kode=$kode';
    Map? responseBody = await AppRequest.get(url);
    if (responseBody == null) return Vouchers();
    // List<Vourcher> list = [];
    // list.add(Vourcher.fromJson(responseBody['datas']));
    if (responseBody['status_code'] == 204) return Vouchers();
    Vouchers voucher = Vouchers.fromJson(responseBody['datas']);
    return voucher;
  }

  static Future<bool> postData(String body) async {
    String url = '${Api.baseUrl}/order';
    Map? responseBody = await AppRequest.post(url, body);
    if (responseBody == null) return false;
    if (responseBody["status_code"] == 200) {
      print(responseBody['status_code']);
      print(responseBody['message']);
      print(responseBody['status_code'] == 200);
      final cCheckout = Get.put(CMenu());
      cCheckout.setIdCheckout(responseBody['id']);
      return true;
    }
    print(responseBody['status_code']);
    print(responseBody['message']);
    print(responseBody['status_code'] == 200);
    return responseBody['status_code'] == 200;
  }

  static Future<bool> batal(int id) async {
    String url = '${Api.baseUrl}/order/cancel/{$id}';
    Map? responseBody = await AppRequest.batal(url);
    if (responseBody == null) return false;
    if (responseBody['status_code'] == 200) {
      print(responseBody['status_code']);
      return true;
    }
    ;
    print(responseBody['status_code']);
    return responseBody['status_code'] == 200;
  }
}
