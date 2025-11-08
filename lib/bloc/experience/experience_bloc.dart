import 'package:flutter_bloc/flutter_bloc.dart';
import 'experience_event.dart';
import 'experience_state.dart';
import '../../models/experience.dart';
import '../../repositories/experience_repository.dart';
import '../../repositories/experience_repository_impl.dart';

class ExperienceBloc extends Bloc<ExperienceEvent, ExperienceState> {
  final ExperienceRepository _experienceRepository;

  ExperienceBloc({ExperienceRepository? experienceRepository})
    : _experienceRepository =
          experienceRepository ?? ExperienceRepositoryImpl(),
      super(ExperienceInitial()) {
    on<LoadExperiences>(_onLoadExperiences);
    on<ToggleExperienceSelection>(_onToggleExperienceSelection);
    on<UpdateDescription>(_onUpdateDescription);
    on<ReorderExperiences>(_onReorderExperiences);
  }

  Future<void> _onLoadExperiences(
    LoadExperiences event,
    Emitter<ExperienceState> emit,
  ) async {
    emit(ExperienceLoading());
    try {
      final experiences = await _experienceRepository.getExperiences(
        active: event.active,
      );
      emit(
        ExperienceLoaded(
          selectedExperienceIds: const {},
          description: '',
          displayedExperiences: experiences,
        ),
      );
    } catch (e) {
      emit(ExperienceError(e.toString()));
    }
  }

  void _onToggleExperienceSelection(
    ToggleExperienceSelection event,
    Emitter<ExperienceState> emit,
  ) {
    if (state is ExperienceLoaded) {
      final currentState = state as ExperienceLoaded;
      final newSelectedIds = Set<int>.from(currentState.selectedExperienceIds);

      if (newSelectedIds.contains(event.experienceId)) {
        newSelectedIds.remove(event.experienceId);
      } else {
        newSelectedIds.add(event.experienceId);
      }

      emit(currentState.copyWith(selectedExperienceIds: newSelectedIds));
    }
  }

  void _onUpdateDescription(
    UpdateDescription event,
    Emitter<ExperienceState> emit,
  ) {
    if (state is ExperienceLoaded) {
      final currentState = state as ExperienceLoaded;
      emit(currentState.copyWith(description: event.description));
    }
  }

  void _onReorderExperiences(
    ReorderExperiences event,
    Emitter<ExperienceState> emit,
  ) {
    if (state is ExperienceLoaded) {
      final currentState = state as ExperienceLoaded;
      final experiences = List<Experience>.from(
        currentState.displayedExperiences,
      );

      // Find the index of the selected experience
      final selectedIndex = experiences.indexWhere(
        (e) => e.id == event.experienceId,
      );

      if (selectedIndex != -1 && selectedIndex != 0) {
        // Remove the selected experience from its current position
        final selectedExperience = experiences.removeAt(selectedIndex);
        // Insert it at the first position
        experiences.insert(0, selectedExperience);

        emit(currentState.copyWith(displayedExperiences: experiences));
      }
    }
  }
}
