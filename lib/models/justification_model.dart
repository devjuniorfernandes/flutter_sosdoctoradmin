import 'package:sosdoctorsystem/models/user_model.dart';

class JustificationModel {
  int? id;
  User? user;
  String? biPatients;
  String? namePatients;
  String? description;
  String? date;
  String? days;
  String? after;

  JustificationModel(
      {this.id,
      this.user,
      this.biPatients,
      this.namePatients,
      this.description,
      this.date,
      this.days,
      this.after});

  factory JustificationModel.fromJson(Map<String, dynamic> json) {
    return JustificationModel(
      id: json['id'],
      biPatients: json['bi_user'],
      namePatients: json['name_patients'],
      description: json['description'],
      date: json['date'],
      days: json['days'],
      after: json['after'],
      user: User(
        id: json['user']['id'],
        name: json['user']['name'],
      ),
    );
  }
}
