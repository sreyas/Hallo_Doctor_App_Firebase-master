import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({
    Key? key,
    required this.type,
    required this.status,
    required this.amount,
    required this.dateCreate,
    this.email = '',
    this.method = '',
  }) : super(key: key);

  final String type;
  final String status;
  final int amount;
  final DateTime dateCreate;
  final String email;
  final String method;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(
          right: 20,
        ),
        height: 80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: Color(0x04000000),
                  blurRadius: 10,
                  spreadRadius: 10,
                  offset: Offset(0.0, 8.0))
            ],
            color: Colors.white),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 12,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  type,
                  style: GoogleFonts.nunito(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '\$' + amount.toString(),
                  style: GoogleFonts.nunito(fontSize: 20),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  dateCreate.toLocal().toString(),
                  style: GoogleFonts.nunito(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey),
                )
              ],
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Status : '.tr + status,
                  style: GoogleFonts.nunito(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                Text(
                  email,
                  style: GoogleFonts.nunito(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                Text(
                  method,
                  style: GoogleFonts.nunito(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
