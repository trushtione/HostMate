import 'app_imports.dart';
import 'waveform_widget.dart';

class AudioRecordingWidget extends StatefulWidget {
  final AudioRecordingState audioState;
  final VoidCallback onStopRecording;
  final String Function(Duration) formatDuration;

  const AudioRecordingWidget({
    super.key,
    required this.audioState,
    required this.onStopRecording,
    required this.formatDuration,
  });

  @override
  State<AudioRecordingWidget> createState() => _AudioRecordingWidgetState();
}

class _AudioRecordingWidgetState extends State<AudioRecordingWidget> {
  bool _isMicTapped = false;
  bool _isCheckmarkTapped = false;
  Duration? _pausedDuration;

  @override
  void didUpdateWidget(AudioRecordingWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.audioState.isRecording && !widget.audioState.isRecording) {
      _isMicTapped = false;
      _pausedDuration = null;
      _isCheckmarkTapped = false;
    }
    if (oldWidget.audioState.hasRecorded && !widget.audioState.hasRecorded) {
      _isCheckmarkTapped = false;
      _pausedDuration = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.audioState.isRecording) {
      return _buildRecordingAudioWidget();
    } else if (widget.audioState.hasRecorded) {
      return _buildRecordedAudioWidget();
    }
    return const SizedBox.shrink();
  }

  Widget _buildRecordingAudioWidget() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(AppStrings.recordingAudio, style: AppTextStyles.recordingTitle),
          const SizedBox(height: 12),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (!_isMicTapped) {
                    setState(() {
                      _isMicTapped = true;
                      _pausedDuration = widget.audioState.duration;
                    });
                    context.read<QuestionBloc>().add(PauseAudioRecording());
                  } else {
                    widget.onStopRecording();
                  }
                },
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: _isMicTapped
                        ? const Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 20,
                          )
                        : Image.asset(
                            AppAssets.mic,
                            width: 20,
                            height: 20,
                            fit: BoxFit.contain,
                          ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: WaveformWidget(
                  amplitudeData: widget.audioState.amplitudeData,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                widget.formatDuration(
                  _isMicTapped
                      ? (_pausedDuration ?? widget.audioState.duration)
                      : widget.audioState.duration,
                ),
                style: AppTextStyles.recordingDuration,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecordedAudioWidget() {
    if (_isCheckmarkTapped) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                context.read<QuestionBloc>().add(ToggleAudioPlayback());
              },
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  widget.audioState.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(AppStrings.audioRecorded, style: AppTextStyles.recordingTitle),
            const SizedBox(width: 4),
            Text(
              '•',
              style: AppTextStyles.recordingTitle.copyWith(
                color: Colors.grey[400],
              ),
            ),
            const SizedBox(width: 4),
            Text(
              widget.formatDuration(widget.audioState.duration),
              style: AppTextStyles.recordingTitle.copyWith(
                color: Colors.grey[400],
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                context.read<QuestionBloc>().add(DeleteAudioRecording());
              },
              child: Image.asset(
                AppAssets.bin,
                width: 16,
                height: 16,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  '${AppStrings.audioRecorded} - ${widget.formatDuration(widget.audioState.duration)}',
                  style: AppTextStyles.recordingTitle,
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    context.read<QuestionBloc>().add(DeleteAudioRecording());
                  },
                  child: Image.asset(
                    AppAssets.bin,
                    width: 16,
                    height: 16,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isCheckmarkTapped = true;
                    });
                  },
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(Icons.check, color: Colors.white, size: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: WaveformWidget(
                    amplitudeData: widget.audioState.amplitudeData,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }
}
