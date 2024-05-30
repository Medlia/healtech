import 'dart:io';

import 'package:healtech/data/models/appointment_model.dart';
import 'package:healtech/data/repositories/appointment_repository.dart';

class SaveAppointment {
  final AppointmentRepository repository;
  SaveAppointment(this.repository);

  Future<void> call(AppointmentModel appointment) {
    return repository.saveAppointmentDetails(appointment);
  }

  Future<String?> uploadFile(File file, String folder) {
    return repository.uploadFile(file, folder);
  }
}
