import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'app_imports.dart';

class VideoRecordingWidget extends StatefulWidget {
  final VideoRecordingState videoState;
  final VoidCallback onStopRecording;
  final String Function(Duration) formatDuration;
  final CameraController? cameraController;

  const VideoRecordingWidget({
    super.key,
    required this.videoState,
    required this.onStopRecording,
    required this.formatDuration,
    this.cameraController,
  });

  @override
  State<VideoRecordingWidget> createState() => _VideoRecordingWidgetState();
}

class _VideoRecordingWidgetState extends State<VideoRecordingWidget> {
  bool _isVideoTapped = false;
  bool _isPlayIconTapped = false;
  Duration? _pausedVideoDuration;
  Timer? _cameraCheckTimer;

  @override
  void initState() {
    super.initState();
    _startCameraCheck();
  }

  @override
  void didUpdateWidget(VideoRecordingWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset states when recording stops
    if (oldWidget.videoState.isRecording && !widget.videoState.isRecording) {
      _isVideoTapped = false;
      _pausedVideoDuration = null;
      _isPlayIconTapped = false;
      _cameraCheckTimer?.cancel();
    }
    // Reset states when video is deleted
    if (oldWidget.videoState.hasRecorded && !widget.videoState.hasRecorded) {
      _isVideoTapped = false;
      _pausedVideoDuration = null;
      _isPlayIconTapped = false;
      _cameraCheckTimer?.cancel();
    }
    // Start checking if camera becomes available
    if (widget.videoState.isRecording && widget.cameraController != null) {
      _startCameraCheck();
    }
  }

  void _startCameraCheck() {
    if (widget.videoState.isRecording && widget.cameraController != null) {
      _cameraCheckTimer?.cancel();
      // Check immediately first
      if (widget.cameraController!.value.isInitialized &&
          widget.cameraController!.value.previewSize != null) {
        if (mounted) setState(() {});
        return;
      }
      // Then check periodically
      _cameraCheckTimer = Timer.periodic(const Duration(milliseconds: 100), (
        timer,
      ) {
        if (mounted &&
            widget.cameraController != null &&
            widget.cameraController!.value.isInitialized &&
            widget.cameraController!.value.previewSize != null) {
          setState(() {});
          timer.cancel();
        }
        // Cancel after 5 seconds to avoid infinite checking
        if (timer.tick > 50) {
          timer.cancel();
        }
      });
    }
  }

  @override
  void dispose() {
    _cameraCheckTimer?.cancel();
    super.dispose();
  }

  Widget _buildCameraPreview() {
    if (widget.cameraController == null) {
      return const Center(
        child: Icon(
          Icons.videocam,
          color: Colors.white,
          size: 32,
        ),
      );
    }

    final controller = widget.cameraController!;
    
    if (!controller.value.isInitialized) {
      return const Center(
        child: Icon(
          Icons.videocam,
          color: Colors.white,
          size: 32,
        ),
      );
    }

    final previewSize = controller.value.previewSize;
    if (previewSize == null) {
      return const Center(
        child: Icon(
          Icons.videocam,
          color: Colors.white,
          size: 32,
        ),
      );
    }

    // Calculate aspect ratio (width/height)
    final aspectRatio = previewSize.width / previewSize.height;
    
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: CameraPreview(controller),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.videoState.isRecording) {
      return _buildRecordingVideoWidget();
    } else if (widget.videoState.hasRecorded) {
      return _buildRecordedVideoWidget();
    }
    return const SizedBox.shrink();
  }

  Widget _buildRecordingVideoWidget() {
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
                AppStrings.recordingVideo,
                style: AppTextStyles.recordingTitle,
              ),
              const Spacer(),
              Text(
                widget.formatDuration(
                  _isVideoTapped
                      ? (_pausedVideoDuration ?? widget.videoState.duration)
                      : widget.videoState.duration,
                ),
                style: AppTextStyles.recordingDuration,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (!_isVideoTapped) {
                    setState(() {
                      _isVideoTapped = true;
                      _pausedVideoDuration = widget.videoState.duration;
                    });
                    context.read<QuestionBloc>().add(PauseVideoRecording());
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
                    child: _isVideoTapped
                        ? const Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 20,
                          )
                        : const Icon(
                            Icons.videocam,
                            color: Colors.white,
                            size: 20,
                          ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: _buildCameraPreview(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecordedVideoWidget() {
    if (_isPlayIconTapped) {
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
                context.read<QuestionBloc>().add(ToggleVideoPlayback());
              },
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  widget.videoState.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(AppStrings.videoRecorded, style: AppTextStyles.recordingTitle),
            const SizedBox(width: 4),
            Text(
              '•',
              style: AppTextStyles.recordingTitle.copyWith(
                color: Colors.grey[400],
              ),
            ),
            const SizedBox(width: 4),
            Text(
              widget.formatDuration(widget.videoState.duration),
              style: AppTextStyles.recordingTitle.copyWith(
                color: Colors.grey[400],
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                context.read<QuestionBloc>().add(DeleteVideoRecording());
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
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _isPlayIconTapped = true;
                });
                context.read<QuestionBloc>().add(ToggleVideoPlayback());
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    IgnorePointer(
                      child: widget.videoState.thumbnailPath != null
                          ? _buildThumbnailImage(
                              widget.videoState.thumbnailPath!,
                            )
                          : const SizedBox.shrink(),
                    ),
                    IgnorePointer(
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD4A574).withValues(alpha: 0.6),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                        child: const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Row(
                children: [
                  Text(
                    AppStrings.videoRecorded,
                    style: AppTextStyles.recordingTitle,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '•',
                    style: AppTextStyles.recordingTitle.copyWith(
                      color: Colors.grey[400],
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    widget.formatDuration(widget.videoState.duration),
                    style: AppTextStyles.recordingTitle.copyWith(
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                context.read<QuestionBloc>().add(DeleteVideoRecording());
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
    }
  }

  Widget _buildThumbnailImage(String thumbnailPath) {
    // Check if it's a mock path
    final isMockPath =
        thumbnailPath.contains('mock') ||
        (!thumbnailPath.startsWith('/') &&
            !thumbnailPath.startsWith('http://') &&
            !thumbnailPath.startsWith('https://'));

    if (isMockPath) {
      return const SizedBox.shrink();
    }

    // Check if it's a file path
    if (thumbnailPath.startsWith('/')) {
      final file = File(thumbnailPath);
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.file(
          file,
          width: 48,
          height: 48,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const SizedBox.shrink();
          },
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        thumbnailPath,
        width: 48,
        height: 48,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
