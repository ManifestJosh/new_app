import 'package:dio/dio.dart';

class WorkoutService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://exercisedb-api.vercel.app',
    connectTimeout: const Duration(milliseconds: 5000),
    receiveTimeout: const Duration(milliseconds: 3000),
  ));

  Future<List<dynamic>> getBodypart() async {
    try {
      Response response = await _dio.get('/api/v1/bodyparts');
      print(response.data);
      if (response.data['success'] == true) {
        return List<String>.from(
            response.data['data'].map((item) => item['name']));
      } else {
        throw Exception('Failed to fetch body parts');
      }
    } catch (e) {
      return [];
    }
  }

  Future<List<dynamic>> getBodyWeightExercise(String bodyPartName) async {
    try {
      Response response =
          await _dio.get('/api/v1/bodyparts/$bodyPartName/exercises');
      if (response.data['success'] == true) {
       
        return List<Map<String, dynamic>>.from( response.data['data']['exercises']);
      } else {
        throw Exception('Failed to fetch body exercise');
      }
    } catch (e) {
      print('Error $e');
      return [];
    }
  }

  Future<List<String>> getEquipmentsExercise() async {
    try {
      Response response = await _dio.get('/api/v1/equipments');
      List<dynamic> exercise = response.data;

      List<String> equipments = exercise
          .map((equipment) => equipment.toString().toLowerCase())
          .where((equipment) => equipment != 'body weight')
          .toList();
      return equipments;
    } catch (e) {
      return [];
    }
  }
}
