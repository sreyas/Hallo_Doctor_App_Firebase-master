import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hallo_doctor_doctor_app/app/modules/balance/views/widgets/transaction_tile.dart';
import 'package:hallo_doctor_doctor_app/app/modules/widgets/empty_list_widget.dart';
import 'package:hallo_doctor_doctor_app/app/modules/widgets/section_title.dart';
import 'package:hallo_doctor_doctor_app/app/styles/styles.dart';
import 'package:hallo_doctor_doctor_app/app/utils/constants.dart';

import '../controllers/balance_controller.dart';

enum TransactionType { withdraw, payment }

class BalanceView extends GetView<BalanceController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Balance'.tr,
          style: Styles.appBarTextStyle,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Colors.blue[400]),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: Column(
            children: [
              Container(
                height: 175,
                padding: EdgeInsets.only(top: 20, bottom: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Color(0x10000000),
                        blurRadius: 10,
                        spreadRadius: 4,
                        offset: Offset(0.0, 8.0))
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Current Balance'.tr,
                      style: GoogleFonts.inter(
                          fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                     Text(
                          currencySign + controller.amount.toStringAsFixed(2),
                          style: GoogleFonts.inter(
                              fontSize: 40, fontWeight: FontWeight.w600),
                        ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 150,
                      child: ElevatedButton(
                        child: Text("Withdraw".tr),
                        onPressed: () => controller.withdraw(),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SectionTitle(
                title: 'Last Transaction'.tr,
                subTitle: 'See all transaction'.tr,
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => controller.getTransaction(),
                  child: controller.obx(
                      (listTransaction) => ListView.separated(
                            shrinkWrap: true,
                            itemCount: listTransaction!.length,
                            itemBuilder: (contex, index) {
                              switch (TransactionType.values
                                  .byName(listTransaction[index].type!)) {
                                case TransactionType.payment:
                                  {
                                    return TransactionTile(
                                      type: 'Payment',
                                      status: listTransaction[index].status!,
                                      amount: listTransaction[index].amount!,
                                      dateCreate:
                                          listTransaction[index].createdAt!,
                                    );
                                  }

                                case TransactionType.withdraw:
                                  {
                                    return TransactionTile(
                                      type: 'Withdraw',
                                      status: listTransaction[index].status!,
                                      amount: listTransaction[index].amount!,
                                      dateCreate:
                                          listTransaction[index].createdAt!,
                                      method: listTransaction[index]
                                              .withdrawMethod!
                                              .method ??
                                          '',
                                      email: listTransaction[index]
                                              .withdrawMethod!
                                              .email ??
                                          '',
                                    );
                                  }
                              }
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                height: 5,
                              );
                            },
                          ),
                      onEmpty: EmptyList(msg: 'No Transaction yet'.tr)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
