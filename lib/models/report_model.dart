import 'user_model.dart';

class ReportModel {
  int? id;
  String? dateSchedules;
  User? user;
  String? namePatients;
  int? phonePatients;
  String? addressPatients;
  int? agePatients;
  String? subject;
  String? description;
  int? status;

  ReportModel({
    this.id,
    this.dateSchedules,
    this.user,
    this.namePatients,
    this.phonePatients,
    this.addressPatients,
    this.agePatients,
    this.subject,
    this.description,
    this.status,
  });

    factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['id'],
      dateSchedules: json['date_schedules'],
      namePatients: json['name_patients'],
      phonePatients: json['phone_patients'],
      addressPatients: json['address_patients'],
      agePatients: json['age_patients'],
      subject: json['subject'],
      description: json['description'],
      status: json['status'],
      user: User(
        id: json['user']['id'],
        name: json['user']['name'],
      ),
    );
  }


}