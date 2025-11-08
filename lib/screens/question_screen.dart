import '../res/app_imports.dart';
import 'thank_you_screen.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isKeyboardVisible = false;
  bool _isWordLimitExceeded = false;
  bool _isUpdatingFromState = false;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      final keyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
      if (_isKeyboardVisible != keyboardVisible) {
        setState(() {
          _isKeyboardVisible = keyboardVisible;
        });
      } else {
        setState(() {});
      }
    });

    _textController.addListener(() {
      if (_isUpdatingFromState) return;

      final isExceeded = AppValidations.isWordLimitExceeded(
        _textController.text,
        AppValidations.questionTextMaxWords,
      );

      setState(() {
        _isWordLimitExceeded = isExceeded;
      });

      if (isExceeded) {
        _textController.text = AppValidations.truncateToMaxWords(
          _textController.text,
          AppValidations.questionTextMaxWords,
        );
        _textController.selection = TextSelection.fromPosition(
          TextPosition(offset: _textController.text.length),
        );
      }

      context.read<QuestionBloc>().add(
        UpdateQuestionText(_textController.text),
      );
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _startAudioRecording() {
    context.read<QuestionBloc>().add(StartAudioRecording());
  }

  void _stopAudioRecording() {
    final state = context.read<QuestionBloc>().state;
    // The actual audio path will be set by the bloc from the recorder
    context.read<QuestionBloc>().add(
      StopAudioRecording(
        state.audioState.duration,
        null, // Will be set by bloc from actual recording
      ),
    );
  }

  void _startVideoRecording() {
    context.read<QuestionBloc>().add(StartVideoRecording());
  }

  void _stopVideoRecording() {
    final state = context.read<QuestionBloc>().state;
    // The actual video and thumbnail paths will be set by the bloc from the recorder
    context.read<QuestionBloc>().add(
      StopVideoRecording(
        state.videoState.duration,
        null, // Will be set by bloc from actual recording
        null, // Will be set by bloc from thumbnail generation
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  void _onNextPressed(QuestionState state) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ThankYouScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(progress: 0.66),
      resizeToAvoidBottomInset: true,
      body: WavyBackground(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
              return BlocBuilder<QuestionBloc, QuestionState>(
                builder: (context, state) {
                  if (_textController.text != state.questionText) {
                    _isUpdatingFromState = true;
                    _textController.text = state.questionText;
                    _isUpdatingFromState = false;

                    final wordCount = AppValidations.getWordCount(
                      _textController.text,
                    );
                    setState(() {
                      _isWordLimitExceeded =
                          wordCount > AppValidations.questionTextMaxWords;
                    });
                  }

                  return GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: keyboardHeight),
                      child: SizedBox(
                        height: constraints.maxHeight - keyboardHeight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Spacer(),

                            Padding(
                              padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppStrings.step02,
                                    style: AppTextStyles.stepIndicator,
                                  ),

                                  const SizedBox(height: 16),

                                  Text(
                                    AppStrings.questionScreenQuestion,
                                    style: AppTextStyles.questionHeading,
                                  ),

                                  const SizedBox(height: 12),

                                  Text(
                                    AppStrings.questionScreenDescription,
                                    style: AppTextStyles.description,
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(
                              height: Responsive.getSpacing(context, 24),
                            ),

                            Flexible(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: Responsive.getHorizontalPadding(
                                    context,
                                  ),
                                ),
                                child: _buildTextInputField(state),
                              ),
                            ),

                            if (_isWordLimitExceeded)
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                  Responsive.getHorizontalPadding(context),
                                  Responsive.getSpacing(context, 8),
                                  Responsive.getHorizontalPadding(context),
                                  0,
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: Responsive.getSpacing(context, 16),
                                    ),
                                    child: Text(
                                      AppStrings.questionTextWordLimitExceeded,
                                      style: AppTextStyles.inputText.copyWith(
                                        color: Colors.red[400],
                                        fontSize: Responsive.getFontSize(
                                          context,
                                          12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            else
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                  Responsive.getHorizontalPadding(context),
                                  Responsive.getSpacing(context, 8),
                                  Responsive.getHorizontalPadding(context),
                                  0,
                                ),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      right: Responsive.getSpacing(context, 16),
                                    ),
                                    child: Text(
                                      AppValidations.getWordCountText(
                                        AppValidations.getWordCount(
                                          _textController.text,
                                        ),
                                        AppValidations.questionTextMaxWords,
                                      ),
                                      style: AppTextStyles.inputText.copyWith(
                                        color:
                                            AppValidations.isApproachingWordLimit(
                                              AppValidations.getWordCount(
                                                _textController.text,
                                              ),
                                              AppValidations
                                                  .questionTextMaxWords,
                                            )
                                            ? Colors.orange[400]
                                            : Colors.grey[600],
                                        fontSize: Responsive.getFontSize(
                                          context,
                                          12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                            if (state.audioState.isRecording ||
                                state.audioState.hasRecorded)
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                  Responsive.getHorizontalPadding(context),
                                  Responsive.getSpacing(context, 16),
                                  Responsive.getHorizontalPadding(context),
                                  0,
                                ),
                                child: AudioRecordingWidget(
                                  audioState: state.audioState,
                                  onStopRecording: _stopAudioRecording,
                                  formatDuration: _formatDuration,
                                ),
                              ),
                            if (state.videoState.isRecording ||
                                state.videoState.hasRecorded)
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                  Responsive.getHorizontalPadding(context),
                                  Responsive.getSpacing(context, 16),
                                  Responsive.getHorizontalPadding(context),
                                  0,
                                ),
                                child: VideoRecordingWidget(
                                  videoState: state.videoState,
                                  onStopRecording: _stopVideoRecording,
                                  formatDuration: _formatDuration,
                                ),
                              ),

                            SizedBox(
                              height: Responsive.getSpacing(context, 24),
                            ),

                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                Responsive.getHorizontalPadding(context),
                                0,
                                Responsive.getHorizontalPadding(context),
                                Responsive.getVerticalPadding(context),
                              ),
                              child: _buildBottomActionBar(state),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTextInputField(QuestionState state) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _focusNode.hasFocus
              ? AppColors.primary
              : Colors.grey.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: TextField(
        controller: _textController,
        focusNode: _focusNode,
        maxLines: 25,
        minLines: 8,
        cursorColor: Colors.white,
        style: AppTextStyles.inputText.copyWith(
          fontSize: Responsive.getFontSize(context, 16),
        ),
        decoration: InputDecoration(
          hintText: AppStrings.questionInputPlaceholder,
          hintStyle: AppTextStyles.inputPlaceholder.copyWith(
            fontSize: Responsive.getFontSize(context, 16),
          ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.all(Responsive.getSpacing(context, 16)),
          counterText: '',
        ),
      ),
    );
  }

  Widget _buildBottomActionBar(QuestionState state) {
    final hasContent = state.hasContent;
    final isRecording =
        state.audioState.isRecording || state.videoState.isRecording;
    final bothRecorded =
        state.audioState.hasRecorded && state.videoState.hasRecorded;
    final showButtons = !bothRecorded;

    return Row(
      children: [
        if (showButtons)
          Container(
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.withOpacity(0.4), width: 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.mic,
                    color: isRecording
                        ? Colors.grey.withOpacity(0.5)
                        : Colors.white,
                    size: 24,
                  ),
                  onPressed: isRecording ? null : _startAudioRecording,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 40,
                    minHeight: 40,
                  ),
                ),
                Container(
                  width: 1,
                  height: 24,
                  color: Colors.grey.withOpacity(0.3),
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                ),
                IconButton(
                  icon: Icon(
                    Icons.videocam,
                    color: isRecording
                        ? Colors.grey.withOpacity(0.5)
                        : Colors.white,
                    size: 24,
                  ),
                  onPressed: isRecording ? null : _startVideoRecording,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 40,
                    minHeight: 40,
                  ),
                ),
              ],
            ),
          ),
        if (showButtons) const SizedBox(width: 16),
        Expanded(
          child: CommonNextButton(
            onPressed: () => _onNextPressed(state),
            isEnabled: hasContent,
            isExpanded: false,
          ),
        ),
      ],
    );
  }
}
