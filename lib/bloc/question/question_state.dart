import 'package:equatable/equatable.dart';

class AudioRecordingState extends Equatable {
  final bool isRecording;
  final bool hasRecorded;
  final Duration duration;
  final bool isPlaying;
  final String? audioPath;
  final List<double> amplitudeData;

  const AudioRecordingState({
    this.isRecording = false,
    this.hasRecorded = false,
    this.duration = Duration.zero,
    this.isPlaying = false,
    this.audioPath,
    this.amplitudeData = const [],
  });

  AudioRecordingState copyWith({
    bool? isRecording,
    bool? hasRecorded,
    Duration? duration,
    bool? isPlaying,
    String? audioPath,
    List<double>? amplitudeData,
  }) {
    return AudioRecordingState(
      isRecording: isRecording ?? this.isRecording,
      hasRecorded: hasRecorded ?? this.hasRecorded,
      duration: duration ?? this.duration,
      isPlaying: isPlaying ?? this.isPlaying,
      audioPath: audioPath ?? this.audioPath,
      amplitudeData: amplitudeData ?? this.amplitudeData,
    );
  }

  @override
  List<Object?> get props => [
    isRecording,
    hasRecorded,
    duration,
    isPlaying,
    audioPath,
    amplitudeData,
  ];
}

class VideoRecordingState extends Equatable {
  final bool isRecording;
  final bool hasRecorded;
  final Duration duration;
  final bool isPlaying;
  final String? videoPath;
  final String? thumbnailPath;

  const VideoRecordingState({
    this.isRecording = false,
    this.hasRecorded = false,
    this.duration = Duration.zero,
    this.isPlaying = false,
    this.videoPath,
    this.thumbnailPath,
  });

  VideoRecordingState copyWith({
    bool? isRecording,
    bool? hasRecorded,
    Duration? duration,
    bool? isPlaying,
    String? videoPath,
    String? thumbnailPath,
  }) {
    return VideoRecordingState(
      isRecording: isRecording ?? this.isRecording,
      hasRecorded: hasRecorded ?? this.hasRecorded,
      duration: duration ?? this.duration,
      isPlaying: isPlaying ?? this.isPlaying,
      videoPath: videoPath ?? this.videoPath,
      thumbnailPath: thumbnailPath ?? this.thumbnailPath,
    );
  }

  @override
  List<Object?> get props => [
    isRecording,
    hasRecorded,
    duration,
    isPlaying,
    videoPath,
    thumbnailPath,
  ];
}

class QuestionState extends Equatable {
  final String questionText;
  final AudioRecordingState audioState;
  final VideoRecordingState videoState;

  const QuestionState({
    this.questionText = '',
    AudioRecordingState? audioState,
    VideoRecordingState? videoState,
  }) : audioState = audioState ?? const AudioRecordingState(),
       videoState = videoState ?? const VideoRecordingState();

  QuestionState copyWith({
    String? questionText,
    AudioRecordingState? audioState,
    VideoRecordingState? videoState,
  }) {
    return QuestionState(
      questionText: questionText ?? this.questionText,
      audioState: audioState ?? this.audioState,
      videoState: videoState ?? this.videoState,
    );
  }

  bool get hasContent =>
      questionText.isNotEmpty ||
      audioState.hasRecorded ||
      videoState.hasRecorded;

  @override
  List<Object?> get props => [questionText, audioState, videoState];
}
