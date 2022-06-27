import 'package:sosdoctorsystem/models/user_model.dart';

class RequisitionModel {
  int? id;
  User? user;
  String? namePatients;
  String? agePatients;
  String? preDiagnosis;
  String? exames;
  String? date;

  RequisitionModel({
    this.id,
    this.user,
    this.namePatients,
    this.agePatients,
    this.preDiagnosis,
    this.exames,
    this.date,
  });

  factory RequisitionModel.fromJson(Map<String, dynamic> json) {
    return RequisitionModel(
      id: json['id'],
      namePatients: json['name_patients'],
      agePatients: json['age_patients'],
      preDiagnosis: json['pre_diagnosis'],
      exames: json['exams'],
      date: json['date'],
      user: User(
        id: json['user']['id'],
        name: json['user']['name'],
      ),
    );
  }
}
