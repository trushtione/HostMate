import 'package:dio/dio.dart';
import '../models/experience.dart';
import '../models/api_response.dart';

class ApiService {
  final Dio _dio;
  ApiService({String? baseUrl})
    : _dio = Dio(
        BaseOptions(
          baseUrl: baseUrl ?? 'https://staging.chamberofsecrets.8club.co',
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
        ),
      );
  Future<List<Experience>> getExperiences({bool active = true}) async {
    try {
      final response = await _dio.get(
        '/v1/experiences',
        queryParameters: {'active': active},
      );

      if (response.statusCode == 200) {
        // Parse API response using freezed models
        final apiResponse = ApiResponse<ExperiencesData>.fromJson(
          response.data as Map<String, dynamic>,
          (json) => ExperiencesData.fromJson(json as Map<String, dynamic>),
        );
        
        if (apiResponse.data != null) {
          return apiResponse.data!.experiences;
        } else {
          throw Exception(
            'Invalid response format: experiences data not found',
          );
        }
      } else {
        throw Exception(
          'Failed to load experiences: Status code ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception(
          'Connection timeout. Please check your internet connection.',
        );
      } else if (e.type == DioExceptionType.badResponse) {
        throw Exception('Server error: ${e.response?.statusCode}');
      } else {
        throw Exception('Failed to load experiences: ${e.message}');
      }
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
