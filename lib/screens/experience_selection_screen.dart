import 'dart:math' as math;

import '../res/app_imports.dart';

class ExperienceSelectionScreen extends StatefulWidget {
  const ExperienceSelectionScreen({super.key});

  @override
  State<ExperienceSelectionScreen> createState() =>
      _ExperienceSelectionScreenState();
}

class _ExperienceSelectionScreenState extends State<ExperienceSelectionScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _descriptionController = TextEditingController();
  final FocusNode _descriptionFocusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  late AnimationController _animationController;
  bool _isCharacterLimitExceeded = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _descriptionController.addListener(() {
      const maxLength = 250;
      final isExceeded = AppValidations.isCharacterLimitExceeded(
        _descriptionController.text,
        maxLength,
      );

      setState(() {
        _isCharacterLimitExceeded = isExceeded;
      });
      if (isExceeded) {
        _descriptionController.text = AppValidations.truncateToMaxLength(
          _descriptionController.text,
          maxLength,
        );
        _descriptionController.selection = TextSelection.fromPosition(
          TextPosition(offset: maxLength),
        );
      }

      context.read<ExperienceBloc>().add(
        UpdateDescription(_descriptionController.text),
      );
    });

    _descriptionFocusNode.addListener(() {
      setState(() {});
    });

    context.read<ExperienceBloc>().add(const LoadExperiences(active: true));
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _descriptionFocusNode.dispose();
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _handleCardSelection(int id) {
    final state = context.read<ExperienceBloc>().state;
    if (state is ExperienceLoaded) {
      final isCurrentlySelected = state.selectedExperienceIds.contains(id);

      // Toggle selection
      context.read<ExperienceBloc>().add(ToggleExperienceSelection(id));

      // If selecting (not deselecting), reorder to first position
      if (!isCurrentlySelected) {
        Future.delayed(const Duration(milliseconds: 100), () {
          context.read<ExperienceBloc>().add(ReorderExperiences(id));
          // Scroll to first position
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        });
      }
    }
  }

  void _onNextPressed(ExperienceLoaded state) {
    debugPrint('Selected IDs: ${state.selectedExperienceIds}');
    debugPrint('Description: ${state.description}');

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const QuestionScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const CommonAppBar(progress: 0.33),
      body: WavyBackground(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
              return BlocBuilder<ExperienceBloc, ExperienceState>(
                builder: (context, state) {
                  if (state is ExperienceLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    );
                  }

                  if (state is ExperienceError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              AppStrings.errorLoadingExperiences,
                              style: TextStyle(color: Colors.red[300]),
                            ),
                            const SizedBox(height: 8),
                            TextButton(
                              onPressed: () {
                                context.read<ExperienceBloc>().add(
                                  const LoadExperiences(active: true),
                                );
                              },
                              child: Text(AppStrings.retry),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  if (state is ExperienceLoaded) {
                    if (_descriptionController.text != state.description) {
                      _descriptionController.text = state.description;
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
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const Spacer(),
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                  Responsive.getHorizontalPadding(context),
                                  0,
                                  Responsive.getHorizontalPadding(context),
                                  0,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppStrings.step01,
                                      style: AppTextStyles.stepIndicator
                                          .copyWith(
                                            fontSize: Responsive.getFontSize(
                                              context,
                                              14,
                                            ),
                                          ),
                                    ),
                                    SizedBox(
                                      height: Responsive.getSpacing(
                                        context,
                                        16,
                                      ),
                                    ),
                                    Text(
                                      AppStrings.experienceSelectionQuestion,
                                      style: AppTextStyles.headingH2Bold
                                          .copyWith(
                                            fontSize: Responsive.getFontSize(
                                              context,
                                              24,
                                            ),
                                          ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(
                                height: Responsive.getSpacing(context, 8),
                              ),

                              SizedBox(
                                height: Responsive.getCardSize(context, 96),
                                child: _buildExperienceCards(
                                  state.displayedExperiences,
                                  state.selectedExperienceIds,
                                ),
                              ),

                              SizedBox(
                                height: Responsive.getSpacing(context, 12),
                              ),

                              Flexible(
                                flex: 0,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: Responsive.getHorizontalPadding(
                                      context,
                                    ),
                                  ),
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxHeight: keyboardHeight > 0
                                          ? 70
                                          : double.infinity,
                                    ),
                                    child: _buildDescriptionField(
                                      keyboardHeight > 0,
                                    ),
                                  ),
                                ),
                              ),
                              if (_isCharacterLimitExceeded)
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                    Responsive.getHorizontalPadding(context),
                                    keyboardHeight > 0
                                        ? 0
                                        : Responsive.getSpacing(context, 8),
                                    Responsive.getHorizontalPadding(context),
                                    0,
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: Responsive.getSpacing(
                                          context,
                                          16,
                                        ),
                                      ),
                                      child: Text(
                                        AppStrings
                                            .experienceDescriptionCharacterLimitExceeded,
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
                                    keyboardHeight > 0
                                        ? 0
                                        : Responsive.getSpacing(context, 8),
                                    Responsive.getHorizontalPadding(context),
                                    0,
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        right: Responsive.getSpacing(
                                          context,
                                          16,
                                        ),
                                      ),
                                      child: Text(
                                        AppValidations.getCharacterCountText(
                                          _descriptionController.text.length,
                                          250,
                                        ),
                                        style: AppTextStyles.inputText.copyWith(
                                          color:
                                              AppValidations.isApproachingLimit(
                                                _descriptionController
                                                    .text
                                                    .length,
                                                250,
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

                              SizedBox(
                                height: keyboardHeight > 0
                                    ? Responsive.getSpacing(context, 6)
                                    : Responsive.getSpacing(context, 12),
                              ),

                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                  Responsive.getHorizontalPadding(context),
                                  0,
                                  Responsive.getHorizontalPadding(context),
                                  Responsive.getVerticalPadding(context),
                                ),
                                child: CommonNextButton(
                                  onPressed: () => _onNextPressed(state),
                                  isEnabled: state.hasContent,
                                  isExpanded: false,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildExperienceCards(
    List<Experience> experiences,
    Set<int> selectedIds,
  ) {
    return ListView.builder(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.getHorizontalPadding(context),
      ),
      itemCount: experiences.length,
      itemBuilder: (context, index) {
        final experience = experiences[index];
        final isSelected = selectedIds.contains(experience.id);
        final rotationPattern = [
          -3.5,
          2.8,
          -1.2,
          3.1,
          -2.4,
          1.7,
          -3.8,
          2.1,
          -1.5,
          3.4,
        ];

        final rotationAngle = rotationPattern[index % rotationPattern.length];

        return Padding(
          padding: EdgeInsets.only(
            right: index < experiences.length - 1
                ? Responsive.getSpacing(context, 16)
                : 0,
          ),
          child: Transform.rotate(
            angle: rotationAngle * math.pi / 180,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (child, animation) {
                return SlideTransition(
                  position:
                      Tween<Offset>(
                        begin: index == 0
                            ? const Offset(-1.0, 0.0)
                            : Offset.zero,
                        end: Offset.zero,
                      ).animate(
                        CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeInOut,
                        ),
                      ),
                  child: ScaleTransition(scale: animation, child: child),
                );
              },
              child: GestureDetector(
                key: ValueKey('${experience.id}_$index'),
                onTap: () => _handleCardSelection(experience.id),
                child: _ExperienceCard(
                  experience: experience,
                  isSelected: isSelected,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDescriptionField([bool isKeyboardOpen = false]) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _descriptionFocusNode.hasFocus
              ? AppColors.primary
              : Colors.grey.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: TextField(
        controller: _descriptionController,
        focusNode: _descriptionFocusNode,
        minLines: isKeyboardOpen ? 1 : 5,
        maxLines: isKeyboardOpen ? 3 : 7,
        maxLength: 250,
        cursorColor: Colors.white,
        style: AppTextStyles.inputText,
        decoration: InputDecoration(
          hintText: AppStrings.experienceDescriptionPlaceholder,
          hintStyle: AppTextStyles.inputPlaceholder,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          contentPadding: const EdgeInsets.all(8),
          counterText: '',
        ),
      ),
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  final Experience experience;
  final bool isSelected;

  const _ExperienceCard({required this.experience, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    final cardSize = Responsive.getCardSize(context, 96);
    return SizedBox(
      width: cardSize,
      height: cardSize,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Stack(
            fit: StackFit.expand,
            children: [
              isSelected
                  ? CachedNetworkImage(
                      imageUrl: experience.imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: const Color(0xFF2A2A2A),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: const Color(0xFF2A2A2A),
                        child: const Icon(Icons.error, color: Colors.white),
                      ),
                    )
                  : ColorFiltered(
                      colorFilter: const ColorFilter.matrix([
                        0.2126,
                        0.7152,
                        0.0722,
                        0,
                        0,
                        0.2126,
                        0.7152,
                        0.0722,
                        0,
                        0,
                        0.2126,
                        0.7152,
                        0.0722,
                        0,
                        0,
                        0,
                        0,
                        0,
                        1,
                        0,
                      ]),
                      child: CachedNetworkImage(
                        imageUrl: experience.imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: const Color(0xFF2A2A2A),
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: const Color(0xFF2A2A2A),
                          child: const Icon(Icons.error, color: Colors.white),
                        ),
                      ),
                    ),
            ],
          ),
          if (isSelected)
            CustomPaint(
              painter: PerforatedBorderPainter(),
              size: const Size(96, 96),
            ),
        ],
      ),
    );
  }
}

class PerforatedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.3)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final width = size.width;
    final height = size.height;
    final borderOffset = 1.0;

    final dashLength = 4.0;
    final gapLength = 3.0;

    _drawPerforatedLine(
      canvas,
      paint,
      Offset(borderOffset, borderOffset),
      Offset(width - borderOffset, borderOffset),
      dashLength,
      gapLength,
    );

    _drawPerforatedLine(
      canvas,
      paint,
      Offset(width - borderOffset, borderOffset),
      Offset(width - borderOffset, height - borderOffset),
      dashLength,
      gapLength,
    );

    _drawPerforatedLine(
      canvas,
      paint,
      Offset(width - borderOffset, height - borderOffset),
      Offset(borderOffset, height - borderOffset),
      dashLength,
      gapLength,
    );

    _drawPerforatedLine(
      canvas,
      paint,
      Offset(borderOffset, height - borderOffset),
      Offset(borderOffset, borderOffset),
      dashLength,
      gapLength,
    );
  }

  void _drawPerforatedLine(
    Canvas canvas,
    Paint paint,
    Offset start,
    Offset end,
    double dashLength,
    double gapLength,
  ) {
    final totalLength = (end - start).distance;
    final direction = (end - start) / totalLength;
    final totalSegments = (totalLength / (dashLength + gapLength)).floor();

    for (int i = 0; i < totalSegments; i++) {
      final dashStart = start + direction * (i * (dashLength + gapLength));
      final dashEnd = dashStart + direction * dashLength;
      canvas.drawLine(dashStart, dashEnd, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
