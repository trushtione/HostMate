import '../models/experience.dart';

abstract class ExperienceRepository {
  Future<List<Experience>> getExperiences({bool active = true});
}
