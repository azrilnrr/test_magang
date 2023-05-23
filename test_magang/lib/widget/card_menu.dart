import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:test_magang/models/menu.dart';

import '../controller/cMenu_lawas.dart';

class CardCustom extends StatefulWidget {
  final Menu item;
  const CardCustom({super.key, required this.item});

  @override
  State<CardCustom> createState() => _CardCustomState();
}

class _CardCustomState extends State<CardCustom> {
  final TextEditingController catatanController = TextEditingController();
  final cMenu = Get.put(CMenu());

  int jumlah = 0;
  int id = 0;
  bool clicked = true;

  setCheckout(Menu menu, String catatan, int jumlah) async {
    await cMenu.setCheckout(catatan, menu, jumlah);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
      child: Container(
        width: 378.w,
        height: 110.h,
        decoration: BoxDecoration(
            color: const Color(0xffF6F6F6),
            borderRadius: BorderRadius.circular(10.w)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: Image.network(
                widget.item.gambar.toString(),
                width: 75.w,
                height: 75.h,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 7.w,
                    ),
                    Text(
                      widget.item.nama.toString(),
                      style: GoogleFonts.montserrat(
                          fontSize: 16.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 7.w,
                    ),
                    Text(
                      'Rp. ${widget.item.harga.toString()}',
                      style: GoogleFonts.montserrat(
                          fontSize: 18.sp,
                          color: Colors.blue,
                          fontWeight: FontWeight.w700),
                    ),
                    TextFormField(
                      controller: catatanController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Tambahkan catatan",
                          hintStyle: TextStyle(fontSize: 8.sp)),
                    )
                  ],
                ),
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  child: Image.asset("assets/minus.png"),
                  onTap: () {
                    if (jumlah > 0) {
                      setState(() {
                        jumlah--;
                        cMenu.kurangJumlah(widget.item.harga!);
                        setCheckout(
                            widget.item, catatanController.text, jumlah);
                      });
                    }
                  },
                ),
                SizedBox(
                  width: 11.w,
                ),
                Text(
                  "$jumlah",
                  style: GoogleFonts.montserrat(
                      fontSize: 18.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 11.w,
                ),
                GestureDetector(
                  child: Image.asset("assets/plus.png"),
                  onTap: () {
                    setState(() {
                      jumlah++;
                      id = cMenu.id;
                      cMenu.tambahJumlah(widget.item.harga!);
                      if (clicked) {
                        clicked = false;
                        id++;
                      }
                      cMenu.setId(id);
                      print(id);

                      setCheckout(widget.item, catatanController.text, jumlah);
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
