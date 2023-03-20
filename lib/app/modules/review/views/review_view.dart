import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/modules/home/views/widgets/review_tile.dart';

import '../../../styles/styles.dart';
import '../controllers/review_controller.dart';

class ReviewView extends GetView<ReviewController> {
  const ReviewView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Review'.tr,
          style: Styles.appBarTextStyle,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: controller.obx(
        (listReview) => Container(
            child: ListView.builder(
                itemCount: controller.listReview.length,
                itemBuilder: (context, index) {
                  return ReviewTile(
                      imgUrl: listReview![index].userReview!.photoUrl!,
                      name: listReview[index].userReview!.displayName!,
                      rating: listReview[index].rating!,
                      review: listReview[index].review!);
                })),
      ),
    );
  }
}
