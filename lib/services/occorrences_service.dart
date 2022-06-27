// get all occorrences
import 'dart:convert';

import 'package:sosdoctorsystem/models/occorrence_model.dart';
import '../constant.dart';
import '../models/api_response.dart';
import 'auth_service.dart';
import 'package:http/http.dart' as http;


// get all occorrences
Future<ApiResponse> getOccorrences() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse("$baseURL/occurrences"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['occorrences']
            .map((o) => OccorrenceModel.fromJson(o))
            .toList();
        // we get list of occorrences, so we need to map each item to post model
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

// CREATE OCCORRENCES
// Future<ApiResponse> createPost(String body, String? image) async {

Future<ApiResponse> createOccorrence(
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
        await http.post(Uri.parse("$baseURL/occurrences"), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
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
Future<ApiResponse> editOccorrence(
  int id,
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
        await http.put(Uri.parse('$baseURL/occurrences/$id'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
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
Future<ApiResponse> deleteOccorrences(int id) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.delete(Uri.parse('$baseURL/occurrences/$id'),
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
