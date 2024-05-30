import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healtech/core/colors.dart';
import 'package:healtech/core/sizes.dart';
import 'package:healtech/domain/usecases/save_appointment.dart';
import 'package:healtech/presentation/controllers/appointments/add_appointment_controller.dart';
import 'package:healtech/core/widgets/detail_input.dart';

class AddAppointment extends StatefulWidget {
  final DateTime dateTime;
  const AddAppointment({
    super.key,
    required this.dateTime,
  });

  @override
  State<AddAppointment> createState() => _AddAppointmentState();
}

class _AddAppointmentState extends State<AddAppointment> {
  final AddAppointmentController controller =
      Get.put(AddAppointmentController(Get.find<SaveAppointment>()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(
            top: Sizes.small,
          ),
          child: Text(
            "Add Appointment",
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.headlineMedium?.fontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
            child: Column(
              children: [
                const Text(
                  "All the fields are mandatory",
                  style: TextStyle(
                    color: CustomColors.errorColor,
                    fontSize: Sizes.smallFont,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: Sizes.tileSpace),
                DetailField(
                  controller: controller.doctorName,
                  type: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'Doctor\'s name',
                  hint: "Enter doctor's name",
                ),
                const SizedBox(height: Sizes.sectionSpace),
                Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () => DetailField(
                          controller: TextEditingController(
                              text: controller.date.value),
                          title: 'Appointment date',
                          hint: controller.date.value,
                          readOnly: true,
                          suffixIcon: const IconButton(
                            onPressed: null,
                            icon: Icon(Icons.calendar_today_rounded),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: Sizes.sectionSpace),
                    Expanded(
                      child: Obx(
                        () => DetailField(
                          controller: TextEditingController(
                              text: controller.time.value),
                          title: 'Appointment time',
                          hint: controller.time.value,
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.getTimeFromUser(context);
                            },
                            icon: const Icon(Icons.access_time_rounded),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Sizes.sectionSpace),
                DetailField(
                  controller: controller.description,
                  type: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  title: 'Description',
                  hint: "Enter description",
                ),
                const SizedBox(height: Sizes.sectionSpace),
                Row(
                  children: [
                    const Text(
                      "Upload reports",
                      style: TextStyle(
                        fontSize: Sizes.mediumFont,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: Sizes.largestHeight),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey.shade400,
                        ),
                      ),
                      child: IconButton(
                        onPressed: () async {
                          await controller.pickFile(controller.reports);
                        },
                        icon: const Icon(Icons.attach_file_rounded),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Sizes.sectionSpace),
                Row(
                  children: [
                    const Text(
                      "Upload prescription",
                      style: TextStyle(
                        fontSize: Sizes.largeFont,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: Sizes.buttonHeight),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Sizes.fieldBorderRadius),
                        border: Border.all(
                          color: Colors.grey.shade400,
                        ),
                      ),
                      child: IconButton(
                        onPressed: () async {
                          await controller.pickFile(controller.prescription);
                        },
                        icon: const Icon(Icons.notes_rounded),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Sizes.largerSpace),
                SizedBox(
                  height: Sizes.buttonHeight,
                  width: Sizes.buttonWidth,
                  child: FilledButton(
                    onPressed: () async {
                      await controller.saveAppointmentDetails();
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor:
                              Theme.of(context).colorScheme.onInverseSurface,
                          content: Text(
                            "Appointment saved!",
                            style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.inverseSurface,
                              fontSize: Sizes.mediumFont,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Done",
                      style: TextStyle(
                        fontSize: Sizes.mediumFont,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
