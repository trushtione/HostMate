import 'dart:async';
import 'dart:math' as math;
import 'dart:io';
import 'package:just_audio/just_audio.dart';
import 'package:record/record.dart';
import 'package:camera/camera.dart' hide ImageFormat;
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'question_event.dart';
import 'question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  Timer? _recordingTimer;
  Timer? _amplitudeTimer;
  AudioPlayer? _audioPlayer;
  final AudioRecorder _audioRecorder = AudioRecorder();
  String? _currentRecordingPath;

  // Video recording
  CameraController? _cameraController;
  bool _isInitializingCamera = false;

  // Getter to expose camera controller for preview
  CameraController? get cameraController => _cameraController;

  QuestionBloc() : super(const QuestionState()) {
    on<UpdateQuestionText>(_onUpdateQuestionText);
    on<StartAudioRecording>(_onStartAudioRecording);
    on<StopAudioRecording>(_onStopAudioRecording);
    on<UpdateAudioRecordingDuration>(_onUpdateAudioRecordingDuration);
    on<UpdateAudioAmplitude>(_onUpdateAudioAmplitude);
    on<PauseAudioRecording>(_onPauseAudioRecording);
    on<ToggleAudioPlayback>(_onToggleAudioPlayback);
    on<DeleteAudioRecording>(_onDeleteAudioRecording);
    on<StartVideoRecording>(_onStartVideoRecording);
    on<StopVideoRecording>(_onStopVideoRecording);
    on<UpdateVideoRecordingDuration>(_onUpdateVideoRecordingDuration);
    on<PauseVideoRecording>(_onPauseVideoRecording);
    on<ToggleVideoPlayback>(_onToggleVideoPlayback);
    on<DeleteVideoRecording>(_onDeleteVideoRecording);
  }

  void _onUpdateQuestionText(
    UpdateQuestionText event,
    Emitter<QuestionState> emit,
  ) {
    emit(state.copyWith(questionText: event.text));
  }

  void _onStartAudioRecording(
    StartAudioRecording event,
    Emitter<QuestionState> emit,
  ) async {
    try {
      // Check and request permissions
      if (await _audioRecorder.hasPermission()) {
        // Get directory for saving audio
        final directory = await getApplicationDocumentsDirectory();
        final fileName = 'audio_${DateTime.now().millisecondsSinceEpoch}.m4a';
        _currentRecordingPath = path.join(directory.path, fileName);

        // Start recording
        await _audioRecorder.start(
          const RecordConfig(
            encoder: AudioEncoder.aacLc,
            bitRate: 128000,
            sampleRate: 44100,
          ),
          path: _currentRecordingPath!,
        );

        emit(
          state.copyWith(
            audioState: state.audioState.copyWith(
              isRecording: true,
              duration: Duration.zero,
              amplitudeData: [],
            ),
          ),
        );
        _startRecordingTimer();
        _startAmplitudeUpdates();
      } else {
        print('Microphone permission not granted');
      }
    } catch (e) {
      print('Error starting audio recording: $e');
    }
  }

  void _onStopAudioRecording(
    StopAudioRecording event,
    Emitter<QuestionState> emit,
  ) async {
    _recordingTimer?.cancel();
    _amplitudeTimer?.cancel();

    try {
      final audioPath = await _audioRecorder.stop();
      final finalAudioPath =
          audioPath ?? _currentRecordingPath ?? event.audioPath;

      emit(
        state.copyWith(
          audioState: state.audioState.copyWith(
            isRecording: false,
            hasRecorded: true,
            duration: event.duration,
            audioPath: finalAudioPath,
            amplitudeData: state.audioState.amplitudeData,
          ),
        ),
      );

      _currentRecordingPath = null;
    } catch (e) {
      print('Error stopping audio recording: $e');
      emit(
        state.copyWith(
          audioState: state.audioState.copyWith(
            isRecording: false,
            hasRecorded: true,
            duration: event.duration,
            audioPath: event.audioPath,
            amplitudeData: state.audioState.amplitudeData,
          ),
        ),
      );
    }
  }

  void _onUpdateAudioRecordingDuration(
    UpdateAudioRecordingDuration event,
    Emitter<QuestionState> emit,
  ) {
    if (state.audioState.isRecording) {
      emit(
        state.copyWith(
          audioState: state.audioState.copyWith(duration: event.duration),
        ),
      );
    }
  }

  void _onUpdateAudioAmplitude(
    UpdateAudioAmplitude event,
    Emitter<QuestionState> emit,
  ) {
    if (state.audioState.isRecording) {
      emit(
        state.copyWith(
          audioState: state.audioState.copyWith(
            amplitudeData: event.amplitudeData,
          ),
        ),
      );
    }
  }

  void _onPauseAudioRecording(
    PauseAudioRecording event,
    Emitter<QuestionState> emit,
  ) async {
    _recordingTimer?.cancel();
    _amplitudeTimer?.cancel();

    try {
      if (await _audioRecorder.isRecording()) {
        await _audioRecorder.pause();
      }
    } catch (e) {
      print('Error pausing audio recording: $e');
    }
  }

  void _onToggleAudioPlayback(
    ToggleAudioPlayback event,
    Emitter<QuestionState> emit,
  ) async {
    if (state.audioState.audioPath == null) {
      return; // No audio to play
    }
    final audioPath = state.audioState.audioPath!;

    // Check if it's a mock path
    if (audioPath.contains('mock')) {
      // For mock paths, just toggle the playing state
      emit(
        state.copyWith(
          audioState: state.audioState.copyWith(
            isPlaying: !state.audioState.isPlaying,
          ),
        ),
      );
      return;
    }

    try {
      if (_audioPlayer == null) {
        _audioPlayer = AudioPlayer();
        _audioPlayer!.playerStateStream.listen((playerState) {
          if (playerState.processingState == ProcessingState.completed) {
            if (_audioPlayer?.playing ?? false) {
              add(ToggleAudioPlayback());
            }
          }
        });
      }

      if (state.audioState.isPlaying) {
        await _audioPlayer!.pause();
        emit(
          state.copyWith(
            audioState: state.audioState.copyWith(isPlaying: false),
          ),
        );
      } else {
        try {
          if (audioPath.startsWith('http://') ||
              audioPath.startsWith('https://')) {
            await _audioPlayer!.setUrl(audioPath);
          } else {
            await _audioPlayer!.setFilePath(audioPath);
          }
          await _audioPlayer!.play();
          emit(
            state.copyWith(
              audioState: state.audioState.copyWith(isPlaying: true),
            ),
          );
        } catch (loadError) {
          print('Error loading audio: $loadError');
          emit(
            state.copyWith(
              audioState: state.audioState.copyWith(isPlaying: false),
            ),
          );
        }
      }
    } catch (e) {
      // Handle error
      print('Error playing audio: $e');
      emit(
        state.copyWith(audioState: state.audioState.copyWith(isPlaying: false)),
      );
    }
  }

  void _onDeleteAudioRecording(
    DeleteAudioRecording event,
    Emitter<QuestionState> emit,
  ) async {
    _amplitudeTimer?.cancel();

    if (_audioPlayer != null) {
      try {
        await _audioPlayer!.stop();
        await _audioPlayer!.dispose();
      } catch (e) {
        print('Error disposing audio player: $e');
      } finally {
        _audioPlayer = null;
      }
    }

    final audioPath = state.audioState.audioPath;
    if (audioPath != null && !audioPath.contains('mock')) {
      try {
        final file = File(audioPath);
        if (await file.exists()) {
          await file.delete();
        }
      } catch (e) {
        print('Error deleting audio file: $e');
      }
    }

    emit(state.copyWith(audioState: const AudioRecordingState()));
  }

  void _onStartVideoRecording(
    StartVideoRecording event,
    Emitter<QuestionState> emit,
  ) async {
    try {
      if (_isInitializingCamera) {
        return; // Already initializing
      }

      _isInitializingCamera = true;

      try {
        final cameras = await availableCameras();
        if (cameras.isEmpty) {
          print('No cameras available - may be running on simulator');
          _isInitializingCamera = false;
          emit(
            state.copyWith(
              videoState: state.videoState.copyWith(
                isRecording: true,
                duration: Duration.zero,
              ),
            ),
          );
          _startRecordingTimer();
          return;
        }

        final camera = cameras.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.front,
          orElse: () => cameras.first,
        );

        _cameraController = CameraController(
          camera,
          ResolutionPreset.medium,
          enableAudio: true,
        );

        await _cameraController!.initialize();
        await _cameraController!.startVideoRecording();

        emit(
          state.copyWith(
            videoState: state.videoState.copyWith(
              isRecording: true,
              duration: Duration.zero,
            ),
          ),
        );

        _startRecordingTimer();
        _isInitializingCamera = false;
      } on CameraException catch (e) {
        print('CameraException: ${e.code} - ${e.description}');
        _isInitializingCamera = false;
        emit(
          state.copyWith(
            videoState: state.videoState.copyWith(
              isRecording: true,
              duration: Duration.zero,
            ),
          ),
        );
        _startRecordingTimer();
      }
    } catch (e) {
      print('Error starting video recording: $e');
      _isInitializingCamera = false;
      emit(
        state.copyWith(
          videoState: state.videoState.copyWith(
            isRecording: true,
            duration: Duration.zero,
          ),
        ),
      );
      _startRecordingTimer();
    }
  }

  void _onStopVideoRecording(
    StopVideoRecording event,
    Emitter<QuestionState> emit,
  ) async {
    _recordingTimer?.cancel();

    try {
      String? videoPath;
      String? thumbnailPath;

      if (_cameraController != null &&
          _cameraController!.value.isRecordingVideo) {
        final videoFile = await _cameraController!.stopVideoRecording();
        videoPath = videoFile.path;

        if (!videoPath.contains('mock')) {
          thumbnailPath = await _generateVideoThumbnail(videoPath);
        }

        await _cameraController!.dispose();
        _cameraController = null;
      } else {
        // Fallback to event paths if camera is not available
        videoPath = event.videoPath;
        thumbnailPath = event.thumbnailPath;
      }

      emit(
        state.copyWith(
          videoState: state.videoState.copyWith(
            isRecording: false,
            hasRecorded: true,
            duration: event.duration,
            videoPath: videoPath,
            thumbnailPath: thumbnailPath,
          ),
        ),
      );
    } catch (e) {
      print('Error stopping video recording: $e');
    }
  }

  Future<String?> _generateVideoThumbnail(String videoPath) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final thumbnailFileName =
          'thumbnail_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final thumbnailPath = path.join(directory.path, thumbnailFileName);

      return await VideoThumbnail.thumbnailFile(
        video: videoPath,
        thumbnailPath: thumbnailPath,
        imageFormat: ImageFormat.JPEG,
        timeMs: 1000,
        quality: 75,
      );
    } catch (e) {
      print('Error generating thumbnail: $e');
      return null;
    }
  }

  void _onUpdateVideoRecordingDuration(
    UpdateVideoRecordingDuration event,
    Emitter<QuestionState> emit,
  ) {
    if (state.videoState.isRecording) {
      emit(
        state.copyWith(
          videoState: state.videoState.copyWith(duration: event.duration),
        ),
      );
    }
  }

  void _onPauseVideoRecording(
    PauseVideoRecording event,
    Emitter<QuestionState> emit,
  ) {
    _recordingTimer?.cancel();

    // Note: Camera package doesn't support pausing video recording directly
    // The timer is paused, but actual recording continues
  }

  void _onToggleVideoPlayback(
    ToggleVideoPlayback event,
    Emitter<QuestionState> emit,
  ) {
    emit(
      state.copyWith(
        videoState: state.videoState.copyWith(
          isPlaying: !state.videoState.isPlaying,
        ),
      ),
    );
  }

  void _onDeleteVideoRecording(
    DeleteVideoRecording event,
    Emitter<QuestionState> emit,
  ) async {
    if (_cameraController != null &&
        _cameraController!.value.isRecordingVideo) {
      try {
        await _cameraController!.stopVideoRecording();
        await _cameraController!.dispose();
        _cameraController = null;
      } catch (e) {
        print('Error stopping video recording on delete: $e');
      }
    }

    final videoPath = state.videoState.videoPath;
    final thumbnailPath = state.videoState.thumbnailPath;

    if (videoPath != null && !videoPath.contains('mock')) {
      try {
        final file = File(videoPath);
        if (await file.exists()) {
          await file.delete();
        }
      } catch (e) {
        print('Error deleting video file: $e');
      }
    }

    if (thumbnailPath != null && !thumbnailPath.contains('mock')) {
      try {
        final file = File(thumbnailPath);
        if (await file.exists()) {
          await file.delete();
        }
      } catch (e) {
        print('Error deleting thumbnail file: $e');
      }
    }

    emit(state.copyWith(videoState: const VideoRecordingState()));
  }

  void _startRecordingTimer() {
    _recordingTimer?.cancel();
    _recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.audioState.isRecording) {
        add(
          UpdateAudioRecordingDuration(
            state.audioState.duration + const Duration(seconds: 1),
          ),
        );
      } else if (state.videoState.isRecording) {
        add(
          UpdateVideoRecordingDuration(
            state.videoState.duration + const Duration(seconds: 1),
          ),
        );
      } else {
        timer.cancel();
      }
    });
  }

  void _startAmplitudeUpdates() {
    _amplitudeTimer?.cancel();

    _amplitudeTimer = Timer.periodic(const Duration(milliseconds: 100), (
      timer,
    ) async {
      if (!state.audioState.isRecording) {
        timer.cancel();
        return;
      }

      try {
        // Get amplitude from the recorder (returns value between -160 and 0 dB)
        final amplitude = await _audioRecorder.getAmplitude();
        final normalizedAmplitude = ((amplitude.current + 160) / 160).clamp(
          0.0,
          1.0,
        );

        final amplitudeData = List.generate(28, (index) {
          final variation = (math.sin(index * 0.3) + 1) / 2;
          return (normalizedAmplitude * 0.7 + variation * 0.3).clamp(0.0, 1.0);
        });

        add(UpdateAudioAmplitude(amplitudeData));
      } catch (e) {
        final amplitudeData = List.generate(28, (index) {
          final basePattern = (index % 2 == 0) ? 0.7 : 0.3;
          final timeVariation =
              (DateTime.now().millisecondsSinceEpoch % 2000) / 2000.0;
          final sineWave =
              (math.sin(timeVariation * math.pi * 2 + index * 0.3) + 1) / 2;
          final random = (math.Random().nextDouble() - 0.5) * 0.2;
          return (basePattern * 0.6 + sineWave * 0.3 + random + 0.2).clamp(
            0.0,
            1.0,
          );
        });
        add(UpdateAudioAmplitude(amplitudeData));
      }
    });
  }

  @override
  Future<void> close() async {
    _recordingTimer?.cancel();
    _amplitudeTimer?.cancel();

    try {
      if (await _audioRecorder.isRecording()) {
        await _audioRecorder.stop();
      }
      await _audioRecorder.dispose();
    } catch (e) {
      print('Error disposing audio recorder: $e');
    }

    if (_cameraController != null) {
      try {
        if (_cameraController!.value.isRecordingVideo) {
          await _cameraController!.stopVideoRecording();
        }
        await _cameraController!.dispose();
        _cameraController = null;
      } catch (e) {
        print('Error disposing camera controller: $e');
      }
    }

    if (_audioPlayer != null) {
      try {
        await _audioPlayer!.stop();
        await _audioPlayer!.dispose();
      } catch (e) {
        print('Error disposing audio player: $e');
      } finally {
        _audioPlayer = null;
      }
    }

    return super.close();
  }
}
