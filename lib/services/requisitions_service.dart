import 'dart:convert';
import 'package:sosdoctorsystem/models/requisition_model.dart';
import '../constant.dart';
import '../models/api_response.dart';
import 'auth_service.dart';
import 'package:http/http.dart' as http;

// get all Requisitions
Future<ApiResponse> getRequisitions() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse("$baseURL/requisitions"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['requisitions']
            .map((o) => RequisitionModel.fromJson(o))
            .toList();
        // we get list of Requisitions, so we need to map each item to post model
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

// CREATE Requisitions
// Future<ApiResponse> createPost(String body, String? image) async {

Future<ApiResponse> createRequisition(
  String nameController,
  String ageController,
  String diaginosisController,
  String examesController,
  String dateController,
) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    final response =
        await http.post(Uri.parse("$baseURL/requisitions"), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'name_patients': nameController,
      'age_patients': ageController,
      'pre_diagnosis': diaginosisController,
      'exams': examesController,
      'date': dateController,
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
