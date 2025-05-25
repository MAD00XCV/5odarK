import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class WelcomePage1 extends StatefulWidget {
  const WelcomePage1({super.key});

  @override
  State<WelcomePage1> createState() => _WelcomePage1State();
}

class _WelcomePage1State extends State<WelcomePage1>
    with TickerProviderStateMixin {
  final List<String> fruitImages = [
    'assets/images/con1.png',
    'assets/images/straw.jpg',
    'assets/images/potato.jpg',
    'assets/images/orange.jpg',
    'assets/images/Watermelon.jpg',
    'assets/images/grappe.jpg',
    'assets/images/lemon.jpg',
    'assets/images/carrot.jpg',
    'assets/images/tomato.jpg',
    'assets/images/connnn.png',
    'assets/images/women.png',
    'assets/images/farmland.jpg',
    'assets/images/tablet.jpg',
    'assets/images/9008.jpg',
    'assets/images/79998.jpg',
    'assets/images/ok.jpg',
  ];

  final List<_FruitWidget> activeFruits = [];
  late Timer _timer;
  final Random _random = Random();
  late AnimationController _glowController;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();

    _glowController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);
    _glowAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );

    _timer = Timer.periodic(Duration(milliseconds: 600), (_) {
      _spawnRandomFruits();
    });

    Timer(Duration(seconds: 15), () {
      _timer.cancel();
      Navigator.of(context).pushReplacementNamed('welcome_page');
    });
  }

  void _spawnRandomFruits() {
    int numberOfFruits = _random.nextInt(4) + 1;
    for (int i = 0; i < numberOfFruits; i++) {
      final imagePath = fruitImages[_random.nextInt(fruitImages.length)];
      final startX = _random.nextDouble();
      final startY = _random.nextBool() ? -0.2 : _random.nextDouble();
      final endX = 0.5 + (_random.nextDouble() - 0.5) / 3;
      final duration = Duration(milliseconds: 2000 + _random.nextInt(2000));

      final controller = AnimationController(vsync: this, duration: duration);
      final animation = Tween<Offset>(
        begin: Offset(startX * 2 - 1, startY),
        end: Offset(endX * 2 - 1, 1.2),
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));

      final fruit = _FruitWidget(
        key: UniqueKey(),
        imagePath: imagePath,
        animation: animation,
        controller: controller,
      );

      controller.forward().then((_) {
        controller.dispose();
        setState(() {
          activeFruits.remove(fruit);
        });
      });

      setState(() {
        activeFruits.add(fruit);
      });
    }
  }

  @override
  void dispose() {
    for (var fruit in activeFruits) {
      fruit.controller.dispose();
    }
    _timer.cancel();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green.shade700, Colors.lightGreenAccent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          Opacity(
            opacity: 0.2,
            child: Image.asset(
              'assets/images/farmland.jpg', 
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
          ),

          Center(
            child: AnimatedBuilder(
              animation: _glowAnimation,
              builder: (context, child) => Text(
                '5odarK',
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      // ignore: deprecated_member_use
                      color: Colors.green.withOpacity(_glowAnimation.value),
                      blurRadius: 20,
                    )
                  ],
                ),
              ),
            ),
          ),

          // // السلة
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Padding(
          //     padding: const EdgeInsets.only(bottom: 30.0),
          //     child: Image.asset(
          //       'assets/images/basket.jpg',
          //       width: 160,
          //       height: 140,
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),

          ...activeFruits,
        ],
      ),
    );
  }
}

class _FruitWidget extends StatelessWidget {
  final String imagePath;
  final Animation<Offset> animation;
  final AnimationController controller;

  const _FruitWidget({
    required Key key,
    required this.imagePath,
    required this.animation,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animation,
      child: Align(
        alignment: Alignment.topCenter,
        child: Image.asset(
          imagePath,
          width: (50 + Random().nextInt(30)).toDouble(),
          height: (50 + Random().nextInt(30)).toDouble(),
        ),
      ),
    );
  }
}
