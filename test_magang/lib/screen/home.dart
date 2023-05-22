import 'dart:convert';

import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_magang/config/theme.dart';
import 'package:test_magang/controller/cMenu_lawas.dart';
import 'package:test_magang/models/menu.dart';
import 'package:test_magang/models/post_data.dart';
import 'package:test_magang/screen/pesanan.dart';
import 'package:test_magang/widget/card_menu.dart';
import 'package:d_info/d_info.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final cMenu = Get.put(CMenu());

  TextEditingController kodeVoucher = TextEditingController();

  refresh() {
    cMenu.getListMenu();
  }

  getVoucher() async {
    await cMenu.getVoucher(kodeVoucher.text);
    if (cMenu.voucherSukses) {
      cMenu.updateVoucher(cMenu.voucher.nominal!);
    } else {
      DInfo.dialogError(context, "Total pembayaran kurang dari diskon");
      DInfo.closeDialog(context);
    }
  }

  postData() async {
    List<Item> items = [];

    for (int i = 0; i < cMenu.checkout.length; i++) {
      var checkout = cMenu.checkout[i];
      items.add(Item(
          id: checkout.menu.id!, harga: checkout.menu.harga!, catatan: '/'));
    }

    var sendData = PostData(
            nominalDiskon: cMenu.voucher.nominal.toString(),
            nominalPesanan: cMenu.totalBayar.toString(),
            items: items)
        .toJson();
    print(jsonEncode(sendData));
    await cMenu.postData(jsonEncode(sendData));
    if (cMenu.postSukses) {
      DInfo.dialogSuccess(context, 'Berhasil');
      DInfo.closeDialog(context, actionAfterClose: () {
        Get.to(PesananScreen());
      });
    } else {
      Get.snackbar(
        'Alert',
        'Upload gagal',
        colorText: Colors.white,
      );
    }
  }

  @override
  void initState() {
    refresh();
    cMenu.getListMenu();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CMenu>(builder: (menu) {
        if (menu.loading) return DView.loadingCircle();
        if (menu.listMenu.isEmpty) return DView.empty('Kosong');
        return Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async => refresh(),
                child: ListView.builder(
                  itemCount: menu.listMenu.length,
                  itemBuilder: (context, index) {
                    Menu item = menu.listMenu[index];
                    return CardCustom(item: item);
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Column(
                children: [
                  Container(
                    height: 110.h,
                    width: 428.w,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.w),
                        topRight: Radius.circular(10.w),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Total Pesanan',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(width: 5.w),
                                  Text(
                                    '(3 Menu):',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(width: 60.w),
                                  Text(
                                    'Rp ${menu.jumlah}',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: secondColor),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30.h,
                                child: Divider(
                                  height: 2.h,
                                  color: Colors.black,
                                ),
                              ),
                              Row(
                                children: [
                                  Image.asset('assets/voucher.png'),
                                  SizedBox(width: 10.w),
                                  Text(
                                    'Voucher',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600,
                                        color: blackColor),
                                  ),
                                  SizedBox(width: 160.w),
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) => Container(
                                          height: 250.h,
                                          decoration: BoxDecoration(
                                            color: whiteColor,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(40.w),
                                              topRight: Radius.circular(40.w),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(24),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      'assets/voucher.png',
                                                    ),
                                                    SizedBox(width: 6.w),
                                                    Text(
                                                      'Punya Kode Voucher?',
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontSize: 24.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  blackColor),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 6.h),
                                                Text(
                                                  'Masukkan kode voucher disini',
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: blackColor),
                                                ),
                                                TextFormField(
                                                  controller: kodeVoucher,
                                                  decoration:
                                                      const InputDecoration(
                                                    hintText: 'puas atau hemat',
                                                  ),
                                                ),
                                                SizedBox(height: 10.h),
                                                Center(
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      getVoucher();
                                                      navigator?.pop(context);
                                                      if (menu.voucher.id !=
                                                          null) {
                                                        menu.resetTotal(menu
                                                            .voucher.nominal!);
                                                      }
                                                      menu.resetVoucher();
                                                    },
                                                    child: const Text(
                                                        'Validasi Voucher'),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                secondColor),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: menu.voucherSukses
                                        ? Column(
                                            children: [
                                              Text(
                                                  '${menu.voucher.kode}'
                                                      .toString(),
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w400,
                                                  )),
                                              Text(
                                                  'Rp. ${menu.voucher.nominal}'
                                                      .toString(),
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 12.sp,
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.w400,
                                                  ))
                                            ],
                                          )
                                        : Text(
                                            'Input Voucher',
                                            style: GoogleFonts.montserrat(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400,
                                                color: blackColor),
                                          ),
                                  ),
                                  SizedBox(width: 5.w),
                                  Image.asset('assets/next.png'),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 80.h,
                width: 428.w,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.w),
                    topRight: Radius.circular(10.w),
                  ),
                ),
                // color: whiteColor,
                child: Padding(
                  padding: EdgeInsets.only(left: 20.w, top: 10.h),
                  child: Row(
                    children: [
                      Image.asset('assets/keranjang.png'),
                      SizedBox(width: 10.w),
                      Column(
                        children: [
                          SizedBox(height: 12.h),
                          Text(
                            'Total Pembayaran',
                            style: GoogleFonts.montserrat(
                                fontSize: 12.sp, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'Rp. ${menu.totalBayar}',
                            style: GoogleFonts.montserrat(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                color: secondColor),
                          ),
                        ],
                      ),
                      SizedBox(width: 50.w),
                      ElevatedButton(
                          onPressed: () {
                            postData();
                          },
                          child: const Text('Pesan Sekarang'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: secondColor,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}
