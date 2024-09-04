import 'dart:convert';
import 'package:challenge_web/app/data/models/timekeeping_model.dart';
import 'package:challenge_web/app/utils/enum/point_controller_error.dart';
import 'package:dio/dio.dart';

class PointRemoteDataSource {
  final Dio _dio;

  PointRemoteDataSource({required Dio dio}) : _dio = dio;

  Future<void> clockIn(TimekeepingModel clockIn) async {
    try {
      final response = await _dio.post(
        '/Point/clockin',
        data: jsonEncode(clockIn.toJson()),
      );
      if (response.statusMessage != 200) {
        throw Exception(PointControllerError.fromErrorMessage(response.toString()));
      }
    } catch (e) {
      throw Exception('Failed to clock in: $e');
    }
  }

  Future<void> clockOut(TimekeepingModel clockOut) async {
    try {
      final response = await _dio.post(
        '/Point/clockout',
        data: jsonEncode(clockOut.toJson()),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to clock out: ${response.data}');
      }
    } catch (e) {
      throw Exception('Failed to clock out: $e');
    }
  }

  Future<List<TimekeepingModel>> listAll({int pageNumber = 1, int pageSize = 10, int? month, int? year}) async {
    try {
      final response = await _dio.get(
        '/Point/list',
        queryParameters: {
          'pageNumber': pageNumber,
          'pageSize': pageSize,
          'month': month,
          'year': year,
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => TimekeepingModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load timekeeping records');
      }
    } catch (e) {
      throw Exception('Failed to load timekeeping records: $e');
    }
  }
}
