// get user level
import 'package:shared_preferences/shared_preferences.dart';

// JUSTIFICATION

Future<String> getJustfName() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('justfName') ?? '';
}

Future<String> getJustfSubject() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('justfSubject') ?? '';
}

Future<String> getJustfDate() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('justfDate') ?? '';
}

Future<int> getJustfID() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getInt('justfID') ?? 0;
}

Future<String> getJustfBI() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('justfBI') ?? '';
}

Future<String> getJustfDays() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('justfDays') ?? '';
}

Future<String> getJustfAfter() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('justfAfter') ?? '';
}

// REQUISITIONS

Future<int> getRequisId() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getInt('requisId') ?? 0;
}

Future<String> getRequisName() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('requisName') ?? '';
}

Future<String> getRequisAge() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('requisAge') ?? '';
}

Future<String> getRequisPreD() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('requisPrediagnosis') ?? '';
}

Future<String> getRequisExams() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('requisExames') ?? '';
}

Future<String> getRequisDate() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('requisDate') ?? '';
}
