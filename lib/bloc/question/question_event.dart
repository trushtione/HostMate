import 'package:equatable/equatable.dart';

abstract class QuestionEvent extends Equatable {
  const QuestionEvent();

  @override
  List<Object?> get props => [];
}

class UpdateQuestionText extends QuestionEvent {
  final String text;

  const UpdateQuestionText(this.text);

  @override
  List<Object?> get props => [text];
}

class StartAudioRecording extends QuestionEvent {}

class StopAudioRecording extends QuestionEvent {
  final Duration duration;
  final String? audioPath;

  const StopAudioRecording(this.duration, this.audioPath);

  @override
  List<Object?> get props => [duration, audioPath];
}

class UpdateAudioRecordingDuration extends QuestionEvent {
  final Duration duration;

  const UpdateAudioRecordingDuration(this.duration);

  @override
  List<Object?> get props => [duration];
}

class UpdateAudioAmplitude extends QuestionEvent {
  final List<double> amplitudeData;

  const UpdateAudioAmplitude(this.amplitudeData);

  @override
  List<Object?> get props => [amplitudeData];
}

class PauseAudioRecording extends QuestionEvent {}

class ToggleAudioPlayback extends QuestionEvent {}

class DeleteAudioRecording extends QuestionEvent {}

class StartVideoRecording extends QuestionEvent {}

class StopVideoRecording extends QuestionEvent {
  final Duration duration;
  final String? videoPath;
  final String? thumbnailPath;

  const StopVideoRecording(this.duration, this.videoPath, this.thumbnailPath);

  @override
  List<Object?> get props => [duration, videoPath, thumbnailPath];
}

class UpdateVideoRecordingDuration extends QuestionEvent {
  final Duration duration;

  const UpdateVideoRecordingDuration(this.duration);

  @override
  List<Object?> get props => [duration];
}

class PauseVideoRecording extends QuestionEvent {}

class ToggleVideoPlayback extends QuestionEvent {}

class DeleteVideoRecording extends QuestionEvent {}

