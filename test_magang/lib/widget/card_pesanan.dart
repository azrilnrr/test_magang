import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_magang/controller/cMenu_lawas.dart';
import 'package:test_magang/models/checkout.dart';

class CardPesanan extends StatefulWidget {
  final Checkout checkout;
  const CardPesanan({super.key, required this.checkout});

  @override
  State<CardPesanan> createState() => _CardPesananState();
}

class _CardPesananState extends State<CardPesanan> {
  final cCheckout = Get.put(CMenu());

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
                widget.checkout.menu.gambar!,
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
                      widget.checkout.menu.nama!,
                      style: GoogleFonts.montserrat(
                          fontSize: 16.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 7.w,
                    ),
                    Text(
                      'Rp. ${widget.checkout.menu.harga.toString()}',
                      style: GoogleFonts.montserrat(
                          fontSize: 18.sp,
                          color: Colors.blue,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      widget.checkout.catatan.toString(),
                      style: TextStyle(fontSize: 12.sp),
                    )
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  widget.checkout.count.toString(),
                  style: GoogleFonts.montserrat(
                      fontSize: 18.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 11.w,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
