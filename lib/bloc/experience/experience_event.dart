import 'package:equatable/equatable.dart';

abstract class ExperienceEvent extends Equatable {
  const ExperienceEvent();

  @override
  List<Object?> get props => [];
}

class LoadExperiences extends ExperienceEvent {
  final bool active;

  const LoadExperiences({this.active = true});

  @override
  List<Object?> get props => [active];
}

class ToggleExperienceSelection extends ExperienceEvent {
  final int experienceId;

  const ToggleExperienceSelection(this.experienceId);

  @override
  List<Object?> get props => [experienceId];
}

class UpdateDescription extends ExperienceEvent {
  final String description;

  const UpdateDescription(this.description);

  @override
  List<Object?> get props => [description];
}

class ReorderExperiences extends ExperienceEvent {
  final int experienceId;

  const ReorderExperiences(this.experienceId);

  @override
  List<Object?> get props => [experienceId];
}

