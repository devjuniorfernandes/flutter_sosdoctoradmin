// get all schedules
import 'dart:convert';

import 'package:sosdoctorsystem/models/schedules_model.dart';
import '../constant.dart';
import '../models/api_response.dart';
import 'auth_service.dart';
import 'package:http/http.dart' as http;

// get all schedules
Future<ApiResponse> getSchedules() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse("$baseURL/schedules"), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['schadules']
            .map((o) => SchedulesModel.fromJson(o))
            .toList();
        // we get list of schedules, so we need to map each item to post model
        apiResponse.data as List<dynamic>;

        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

// CREATE schedules
// Future<ApiResponse> createPost(String body, String? image) async {

Future<ApiResponse> createSchedules(
  String dateController,
  String nameController,
  String addressController,
  String descriptionController,
  String idadeController,
  String numberPhoneController,
  String subjectController,
) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    final response =
        await http.post(Uri.parse("$baseURL/schedules"), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'date_schedules': dateController,
      'name_patients': nameController,
      'phone_patients': numberPhoneController,
      'address_patients': addressController,
      'age_patients': idadeController,
      'subject': subjectController,
      'description': descriptionController,
      'urgency': "1",
      'status': "1",
    });

    // here if the image is null we just send the body, if not null we send the image too

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

// Edit post
Future<ApiResponse> editSchedules(
  int id,
  String dateController,
  String nameController,
  String addressController,
  String descriptionController,
  String idadeController,
  String numberPhoneController,
  String subjectController,
) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response =
        await http.put(Uri.parse('$baseURL/schedules/$id'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'date_schedules': dateController,
      'name_patients': nameController,
      'phone_patients': numberPhoneController,
      'address_patients': addressController,
      'age_patients': idadeController,
      'subject': subjectController,
      'description': descriptionController,
      'urgency': "1",
      'status': "1",
    });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

// Delete post
Future<ApiResponse> deleteschedules(int id) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.delete(Uri.parse('$baseURL/schedules/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}
