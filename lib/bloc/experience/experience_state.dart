import 'package:equatable/equatable.dart';
import '../../models/experience.dart';

abstract class ExperienceState extends Equatable {
  const ExperienceState();

  @override
  List<Object?> get props => [];
}

class ExperienceInitial extends ExperienceState {}

class ExperienceLoading extends ExperienceState {}

class ExperienceLoaded extends ExperienceState {
  final Set<int> selectedExperienceIds;
  final String description;
  final List<Experience> displayedExperiences;

  const ExperienceLoaded({
    required this.selectedExperienceIds,
    required this.description,
    required this.displayedExperiences,
  });

  ExperienceLoaded copyWith({
    Set<int>? selectedExperienceIds,
    String? description,
    List<Experience>? displayedExperiences,
  }) {
    return ExperienceLoaded(
      selectedExperienceIds: selectedExperienceIds ?? this.selectedExperienceIds,
      description: description ?? this.description,
      displayedExperiences: displayedExperiences ?? this.displayedExperiences,
    );
  }

  bool get hasContent => selectedExperienceIds.isNotEmpty || description.isNotEmpty;

  @override
  List<Object?> get props => [
        selectedExperienceIds,
        description,
        displayedExperiences,
      ];
}

class ExperienceError extends ExperienceState {
  final String message;

  const ExperienceError(this.message);

  @override
  List<Object?> get props => [message];
}

