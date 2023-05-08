import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/modules/login/views/widgets/submit_button.dart';
import 'package:hallo_doctor_doctor_app/app/modules/withdraw_method/controllers/withdraw_method_controller.dart';
import 'package:hallo_doctor_doctor_app/app/styles/styles.dart';

class AddPaypalPage extends GetView<WithdrawMethodController> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Add Account',
            style: Styles.appBarTextStyle,
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: Colors.blue[400])),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: SafeArea(
          child: FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                FormBuilderTextField(
                  name: 'name',
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.minLength(context, 2),
                    ],
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Name',
                  ),
                  onEditingComplete: () => node.nextFocus(),
                ),
                SizedBox(
                  height: 10,
                ),
                FormBuilderTextField(
                  name: 'email',
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.email(context),
                    ],
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email Address',
                  ),
                  onEditingComplete: () => node.nextFocus(),
                ),
                SizedBox(
                  height: 10,
                ),
                FormBuilderTextField(
                  name: 'accountno',
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.minLength(context, 14),
                    ],
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Account No',
                  ),
                  onEditingComplete: () => node.nextFocus(),
                ),
                SizedBox(
                  height: 10,
                ),
                FormBuilderTextField(
                  name: 'ifsc',
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.minLength(context, 6),
                    ],
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'IFSC',
                  ),
                  onEditingComplete: () => node.nextFocus(),
                ),
                SizedBox(
                  height: 10,
                ),
                submitButton(
                    onTap: () {
                      _formKey.currentState!.save();
                      if (_formKey.currentState!.validate()) {
                        controller.addPaypal(
                            _formKey.currentState!.value['name'],
                            _formKey.currentState!.value['email'],
                          _formKey.currentState!.value['accountno'],
                            _formKey.currentState!.value['ifsc']);

                        print('validation success');
                      } else {
                        print("validation failed");
                      }
                    },
                    text: 'Save')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
