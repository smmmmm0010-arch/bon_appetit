import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/BonAppetitLoginScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bono',
      home: const BonAppetitSplashScreen(),
    );
  }
}

class BonAppetitSplashScreen extends StatefulWidget {
  const BonAppetitSplashScreen({super.key});

  @override
  State<BonAppetitSplashScreen> createState() => _BonAppetitSplashScreenState();
}

class _BonAppetitSplashScreenState extends State<BonAppetitSplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _chefHatController;
  late AnimationController _loadingController;
  late AnimationController _textController;

  @override
  void initState() {
    super.initState();

    _chefHatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _loadingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _textController.forward();

        _loadingController.forward().then((_) {
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Bonappetitloginscreen(),
              ),
            );
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _chefHatController.dispose();
    _loadingController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String targetText = 'Bono';

    final Animation<double> chefHatScale = Tween<double>(begin: 0.94, end: 1.06)
        .animate(
          CurvedAnimation(parent: _chefHatController, curve: Curves.easeInOut),
        );

    final Animation<double> loadingProgress =
        Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: _loadingController, curve: Curves.linear),
        );

    final Animation<int> textCharacterCount =
        IntTween(begin: 0, end: targetText.length).animate(
          CurvedAnimation(
            parent: _textController,
            curve: const Interval(0.0, 0.75, curve: Curves.linear),
          ),
        );

    final Animation<double> textPulseScale =
        TweenSequence<double>([
          TweenSequenceItem(
            tween: Tween<double>(begin: 1.0, end: 1.12),
            weight: 50,
          ),
          TweenSequenceItem(
            tween: Tween<double>(begin: 1.12, end: 1.0),
            weight: 50,
          ),
        ]).animate(
          CurvedAnimation(
            parent: _textController,
            curve: const Interval(0.75, 1.0, curve: Curves.easeInOut),
          ),
        );

    return Scaffold(
      backgroundColor: const Color(0xFFFFF0EA),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenHeight = constraints.maxHeight;
          double screenWidth = constraints.maxWidth;

          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/images/cooking_bg.png',
                  fit: BoxFit.contain,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 360),
                child: Positioned(
                  top: screenHeight * 0.178,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: AnimatedBuilder(
                      animation: chefHatScale,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: chefHatScale.value,
                          child: Container(
                            width: 65,
                            height: 65,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,

                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFFFF7A85,
                                  ).withOpacity(0.35),
                                  blurRadius: 20,
                                  spreadRadius: 4,
                                ),
                              ],
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                const Positioned(
                                  top: 4,
                                  child: Icon(
                                    Icons.cloud,
                                    size: 42,
                                    color: Color(0xffff6080),
                                  ),
                                ),

                                Positioned(
                                  bottom: 14,
                                  child: Container(
                                    width: 24,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: Color(0xffff6080),
                                      borderRadius: BorderRadius.circular(3),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(
                                            0xffff6080,
                                          ).withOpacity(0.8),
                                          blurRadius: 10,
                                          spreadRadius: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              Positioned(
                top: screenHeight * 0.320,
                left: 0,
                right: 0,
                child: AnimatedBuilder(
                  animation: _textController,
                  builder: (context, child) {
                    String currentString = targetText.substring(
                      0,
                      textCharacterCount.value,
                    );

                    return Transform.scale(
                      scale: textPulseScale.value,
                      child: Text(
                        currentString,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.dancingScript(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 55, 39, 100),
                        ),
                      ),
                    );
                  },
                ),
              ),

              Positioned(
                bottom: screenHeight * 0.200,
                left: 120,
                child: AnimatedBuilder(
                  animation: loadingProgress,
                  builder: (context, child) {
                    double totalAvailableWidth = screenWidth - 250;
                    double dynamicWidth =
                        totalAvailableWidth * loadingProgress.value;

                    return Stack(
                      alignment: Alignment.centerLeft,
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: 4.5,
                          width: dynamicWidth,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFEE72),
                            borderRadius: BorderRadius.circular(2),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFFFEE72).withOpacity(0.6),
                                blurRadius: 10,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: dynamicWidth - 12,
                          top: -11,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFFFF7A85,
                                  ).withOpacity(0.5),
                                  blurRadius: 14,
                                  spreadRadius: 3,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.restaurant_menu,
                              color: Color.fromARGB(255, 236, 233, 80),
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
