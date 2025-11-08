import 'dart:math' as math;

import '../res/app_imports.dart';

class ThankYouScreen extends StatefulWidget {
  const ThankYouScreen({super.key});

  @override
  State<ThankYouScreen> createState() => _ThankYouScreenState();
}

class _ThankYouScreenState extends State<ThankYouScreen>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _fadeController;
  late AnimationController _pulseController;
  late AnimationController _particleController;
  late AnimationController _gradientController;
  late AnimationController _emoji1Controller;
  late AnimationController _emoji2Controller;
  late AnimationController _emoji3Controller;
  late AnimationController _textController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _gradientAnimation;
  late Animation<double> _emoji1Animation;
  late Animation<double> _emoji2Animation;
  late Animation<double> _emoji3Animation;
  late Animation<double> _textAnimation;

  final List<Particle> _particles = [];

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _particleController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat();

    _gradientController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();

    _emoji1Controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _emoji2Controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _emoji3Controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _textController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeIn));

    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _gradientAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _gradientController, curve: Curves.linear),
    );

    _emoji1Animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _emoji1Controller, curve: Curves.bounceOut),
    );

    _emoji2Animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _emoji2Controller, curve: Curves.bounceOut),
    );

    _emoji3Animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _emoji3Controller, curve: Curves.bounceOut),
    );

    _textAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOutCubic),
    );

    _initializeParticles();
    _startAnimations();
  }

  void _initializeParticles() {
    final random = math.Random();
    for (int i = 0; i < 30; i++) {
      _particles.add(
        Particle(
          x: random.nextDouble(),
          y: random.nextDouble(),
          size: random.nextDouble() * 4 + 2,
          speed: random.nextDouble() * 0.5 + 0.2,
          opacity: random.nextDouble() * 0.5 + 0.3,
        ),
      );
    }
  }

  void _startAnimations() {
    _emoji1Controller.forward();
    Future.delayed(const Duration(milliseconds: 150), () {
      _emoji2Controller.forward();
    });
    Future.delayed(const Duration(milliseconds: 300), () {
      _emoji3Controller.forward();
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      _scaleController.forward();
    });
    Future.delayed(const Duration(milliseconds: 700), () {
      _fadeController.forward();
      _textController.forward();
    });
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _fadeController.dispose();
    _pulseController.dispose();
    _particleController.dispose();
    _gradientController.dispose();
    _emoji1Controller.dispose();
    _emoji2Controller.dispose();
    _emoji3Controller.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: WavyBackground(
        child: SafeArea(
          child: Stack(
            children: [
              AnimatedBuilder(
                animation: _particleController,
                builder: (context, child) {
                  return CustomPaint(
                    painter: ParticlePainter(
                      particles: _particles,
                      progress: _particleController.value,
                    ),
                    size: screenSize,
                  );
                },
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.getHorizontalPadding(context),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ScaleTransition(
                        scale: _pulseAnimation,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildAnimatedEmoji('🎉', _emoji1Animation, 0),
                            SizedBox(width: Responsive.getSpacing(context, 12)),
                            _buildAnimatedEmoji('✨', _emoji2Animation, 1),
                            SizedBox(width: Responsive.getSpacing(context, 12)),
                            _buildAnimatedEmoji('🙏', _emoji3Animation, 2),
                          ],
                        ),
                      ),
                      SizedBox(height: Responsive.getSpacing(context, 50)),
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: ScaleTransition(
                          scale: _scaleAnimation,
                          child: AnimatedBuilder(
                            animation: _textController,
                            builder: (context, child) {
                              return ShaderMask(
                                shaderCallback: (bounds) {
                                  return LinearGradient(
                                    colors: [
                                      AppColors.primary,
                                      AppColors.primary.withValues(alpha: 0.5),
                                      AppColors.primary,
                                    ],
                                    stops: [
                                      (_gradientAnimation.value - 0.3).clamp(
                                        0.0,
                                        1.0,
                                      ),
                                      _gradientAnimation.value,
                                      (_gradientAnimation.value + 0.3).clamp(
                                        0.0,
                                        1.0,
                                      ),
                                    ],
                                  ).createShader(bounds);
                                },
                                child: Column(
                                  children: [
                                    _buildAnimatedText(
                                      AppStrings.thankYou,
                                      AppTextStyles.headingH1Bold.copyWith(
                                        fontSize: Responsive.getFontSize(
                                          context,
                                          32,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: Responsive.getSpacing(
                                        context,
                                        20,
                                      ),
                                    ),
                                    _buildAnimatedText(
                                      AppStrings.thankYouMessage,
                                      AppTextStyles.bodyB1Regular.copyWith(
                                        fontSize: Responsive.getFontSize(
                                          context,
                                          16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedEmoji(
    String emoji,
    Animation<double> animation,
    int index,
  ) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final rotation = math.sin(animation.value * math.pi * 2) * 0.1;
        final scale = animation.value;
        final opacity = animation.value;
        return Transform.rotate(
          angle: rotation,
          child: Transform.scale(
            scale: scale,
            child: Opacity(
              opacity: opacity,
              child: Text(
                emoji,
                style: TextStyle(
                  fontSize: Responsive.getFontSize(
                    context,
                    index == 1 ? 60 : 80,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedText(String text, TextStyle style) {
    return AnimatedBuilder(
      animation: _textAnimation,
      builder: (context, child) {
        final characters = text.split('');
        final visibleCount = (characters.length * _textAnimation.value).ceil();
        return Text(
          characters.take(visibleCount).join(),
          style: style.copyWith(color: Colors.white),
          textAlign: TextAlign.center,
        );
      },
    );
  }
}

class Particle {
  double x;
  double y;
  double size;
  double speed;
  double opacity;

  Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.opacity,
  });
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final double progress;

  ParticlePainter({required this.particles, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = AppColors.primary;

    for (final particle in particles) {
      final x = (particle.x + progress * particle.speed) % 1.0 * size.width;
      final y =
          (particle.y + progress * particle.speed * 0.5) % 1.0 * size.height;

      paint.color = AppColors.primary.withValues(
        alpha:
            particle.opacity * (0.5 + 0.5 * math.sin(progress * math.pi * 2)),
      );

      canvas.drawCircle(Offset(x, y), particle.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
