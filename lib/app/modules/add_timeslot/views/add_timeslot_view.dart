import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/models/repeat_duration_model.dart';
import 'package:hallo_doctor_doctor_app/app/models/repeat_model.dart';

import '../controllers/add_timeslot_controller.dart';
import 'package:intl/intl.dart';

class AddTimeslotView extends GetView<AddTimeslotController> {
  @override
  Widget build(BuildContext context) {
    List<int> durationList = [20, 30, 45, 60, 90];
    var dropdownDuration = durationList
        .map(
          (e) => DropdownMenuItem(
            value: e.toString(),
            child: Text(e.toString() + ' Minute'.tr),
          ),
        )
        .toList();
    List<RepeatTimeslot> listRepeat = [
      controller.repeat,
      RepeatTimeslot(repeatText: 'Every Day'.tr, repeat: Repeat.EVERY_DAY),
      RepeatTimeslot(
          repeatText: 'Same Day Every Week'.tr,
          repeat: Repeat.SAME_DAY_EVERY_WEEK),
      RepeatTimeslot(
          repeatText: 'Same Day Every Month'.tr,
          repeat: Repeat.SAME_DAY_EVERY_MONTH),
    ];
    List<RepeatDuration> listRepeatDuration = [
      controller.repeatDuration,
      RepeatDuration(month: 3, monthText: '3 Month'.tr),
      RepeatDuration(month: 6, monthText: '6 Month'.tr),
      RepeatDuration(month: 12, monthText: '12 Month'.tr)
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Timeslot'.tr),
        actions: controller.editedTimeSlot == null
            ? [
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: IconButton(
                      onPressed: () {
                        controller.addTimeslot();
                      },
                      icon: Icon(Icons.add)),
                ),
              ]
            : [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      controller.editTimeSlot();
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Get.defaultDialog(
                      title: 'Delete Time Slot'.tr,
                      middleText:
                          'are you sure you want to delete this timeslot'.tr,
                      radius: 15,
                      textCancel: 'Cancel'.tr,
                      textConfirm: 'Delete'.tr,
                      onConfirm: () {
                        controller.deleteTimeSlot();
                      },
                    );
                  },
                  icon: Icon(Icons.delete),
                )
              ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          FormBuilder(
            key: controller.formKey,
            child: Column(
              children: [
                FormBuilderDateTimePicker(
                  name: 'timeslot',
                  inputType: InputType.time,
                  initialValue: controller.initialTime,
                  onChanged: (value) {
                    controller.newDateTime = DateTime(
                        controller.date.year,
                        controller.date.month,
                        controller.date.day,
                        value!.hour,
                        value.minute);
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.access_time),
                  ),
                ),
                Divider(),
                FormBuilderTextField(
                  name: 'Price',
                  initialValue: (controller.price ?? '').toString(),
                  decoration: InputDecoration(
                      hintText: 'Price'.tr,
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.currency_rupee)),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                    FormBuilderValidators.numeric(context),
                    FormBuilderValidators.max(context, 10000),
                  ]),
                  onSaved: (price) {
                    controller.price = int.parse(price!);
                  },
                ),
                Divider(),
                FormBuilderDropdown(
                  initialValue: controller.duration.toString(),
                  name: 'Duration',
                  items: dropdownDuration,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.timer),
                  ),
                  onChanged: (duration) {
                    controller.duration = int.parse(duration.toString());
                  },
                ),
                Divider(),
                FormBuilderDateTimePicker(
                  name: 'Date',
                  inputType: InputType.date,
                  initialValue: controller.date,
                  format: DateFormat('EEEE, dd MMMM, y'),
                  onChanged: (dateTime) {
                    controller.date = dateTime!;
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.date_range_outlined)),
                ),
                Divider(),
                GetBuilder<AddTimeslotController>(
                  builder: (_) {
                    return Visibility(
                      visible: !controller.isEditMode,
                      child: DropdownSearch<RepeatTimeslot>(
                        mode: Mode.MENU,
                        items: listRepeat,
                        itemAsString: (repeatTimeslot) =>
                            repeatTimeslot!.repeatText,
                        onChanged: (RepeatTimeslot? dropdown) {
                          if (dropdown != controller.repeat) {
                            controller.repeatDurationVisibility.value = true;
                          } else {
                            controller.repeatDurationVisibility.value = false;
                          }
                        },
                        selectedItem: controller.repeat,
                        dropdownSearchDecoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.refresh),
                            label: Text('Repeat Timeslot'.tr)),
                        onSaved: (RepeatTimeslot? repeat) {
                          controller.repeat = repeat!;
                        },
                      ),
                    );
                  },
                ),
                Divider(),
                Obx(() => Visibility(
                      visible: controller.repeatDurationVisibility.value,
                      child: DropdownSearch<RepeatDuration>(
                        mode: Mode.MENU,
                        items: listRepeatDuration,
                        itemAsString: (repeatDuration) {
                          return repeatDuration!.monthText;
                        },
                        onChanged: print,
                        selectedItem: controller.repeatDuration,
                        dropdownSearchDecoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.date_range_outlined),
                            label: Text('Repeat for how long')),
                        onSaved: (RepeatDuration? repeatDuration) {
                          controller.repeatDuration = repeatDuration!;
                        },
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
