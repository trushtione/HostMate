import '../models/experience.dart';
import '../services/api_service.dart';
import 'experience_repository.dart';

class ExperienceRepositoryImpl implements ExperienceRepository {
  final ApiService _apiService;

  ExperienceRepositoryImpl({ApiService? apiService})
    : _apiService = apiService ?? ApiService();

  @override
  Future<List<Experience>> getExperiences({bool active = true}) async {
    return await _apiService.getExperiences(active: active);
  }
}
