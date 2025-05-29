import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:app/login_register/login_page.dart';
import 'package:easy_localization/easy_localization.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with TickerProviderStateMixin {
  late AnimationController _imageController;
  late AnimationController _textController;
  late AnimationController _buttonController;

  late Animation<Offset> _imageOffset;
  late Animation<Offset> _textOffset;
  late Animation<double> _fadeInImage;
  late Animation<double> _fadeInText;
  late Animation<double> _fadeInButton;

  @override
  void initState() {
    super.initState();

    _imageController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _imageOffset = Tween<Offset>(begin: const Offset(0, -0.3), end: Offset.zero)
        .animate(CurvedAnimation(parent: _imageController, curve: Curves.easeOut));

    _textOffset = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(CurvedAnimation(parent: _textController, curve: Curves.easeOut));

    _fadeInImage = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _imageController, curve: Curves.easeIn));

    _fadeInText = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _textController, curve: Curves.easeIn));

    _fadeInButton = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _buttonController, curve: Curves.easeIn));

    _startAnimations();
  }

  Future<void> _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _imageController.forward();
    await Future.delayed(const Duration(milliseconds: 300));
    _textController.forward();
    await Future.delayed(const Duration(milliseconds: 300));
    _buttonController.forward();
  }

  @override
  void dispose() {
    _imageController.dispose();
    _textController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  void _onLanguageSelected(String languageCode) async {
    final newLocale = Locale(languageCode);
    if (context.locale != newLocale) {
      await context.setLocale(newLocale);
    }
    if (kDebugMode) {
      print("Selected language: $languageCode");
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFFEEF2E3),
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xFF74B625),
                        blurRadius: 10,
                        spreadRadius: 1,
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SlideTransition(
                        position: _imageOffset,
                        child: FadeTransition(
                          opacity: _fadeInImage,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              'assets/images/5ad.jpg',
                              width: 450,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      SlideTransition(
                        position: _textOffset,
                        child: FadeTransition(
                          opacity: _fadeInText,
                          child: Column(
                            children: [
                              Text(
                                'welcome'.tr(),
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26,
                                  color: const Color(0xFF242422),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'subtitle'.tr(),
                                textAlign: TextAlign.center,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      FadeTransition(
                        opacity: _fadeInButton,
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF74B625),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) => const LoginPage()),
                              );
                            },
                            icon: const Icon(IconlyLight.login, color: Colors.white),
                            label: Text(
                              'continue'.tr(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: PopupMenuButton<String>(
                  icon: const Icon(Icons.language, color: Colors.black87),
                  onSelected: _onLanguageSelected,
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'en',
                      child: Text('English'),
                    ),
                    const PopupMenuItem(
                      value: 'ar',
                      child: Text('العربية'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
