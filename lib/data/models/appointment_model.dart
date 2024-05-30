class AppointmentModel {
  final String doctorName;
  final String description;
  final String date;
  final String time;
  final String? reportsURL;
  final String? prescriptionURL;
  const AppointmentModel({
    required this.doctorName,
    required this.description,
    required this.date,
    required this.time,
    this.reportsURL,
    this.prescriptionURL,
  });

  Map<String, dynamic> toJson() {
    return {
      'doctor\'s name': doctorName,
      'description': description,
      'date': date,
      'time': time,
      'reports': reportsURL,
      'prescription': prescriptionURL,
    };
  }
}
