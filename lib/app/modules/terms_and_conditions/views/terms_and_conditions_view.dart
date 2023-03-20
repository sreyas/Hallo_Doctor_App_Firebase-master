import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

import '../controllers/terms_and_conditions_controller.dart';

class TermsAndConditionsView extends GetView<TermsAndConditionsController> {
  const TermsAndConditionsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Terms And Conditions'),
          centerTitle: true,
        ),
        body: Container(
          child: Obx(() {
            String myValue = controller.termsAndConditions.value;
            print(myValue);
            if (myValue.isEmpty) {
              return SizedBox();
            } else {
              return WebViewPlus(
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (webController) {
                  webController.loadString(myValue);
                },
              );
            }
          }),
        ));
  }
}
