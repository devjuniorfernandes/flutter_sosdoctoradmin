import 'package:sosdoctorsystem/models/user_model.dart';

class OccorrenceModel {
  int? id;
  User? user;
  String? namePatients;
  int? phonePatients;
  String? addressPatients;
  int? agePatients;
  String? subject;
  String? description;
  int? urgency;
  int? status;

  OccorrenceModel({
    this.id,
    this.user,
    this.namePatients,
    this.phonePatients,
    this.addressPatients,
    this.agePatients,
    this.subject,
    this.description,
    this.urgency,
    this.status,
  });

  factory OccorrenceModel.fromJson(Map<String, dynamic> json) {
    return OccorrenceModel(
      id: json['id'],
      namePatients: json['name_patients'],
      phonePatients: json['phone_patients'],
      addressPatients: json['address_patients'],
      agePatients: json['age_patients'],
      subject: json['subject'],
      description: json['description'],
      urgency: json['urgency'],
      status: json['status'],
      user: User(
        id: json['user']['id'],
        name: json['user']['name'],
      ),
      
    );
  }
}
