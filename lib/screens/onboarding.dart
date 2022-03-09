// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:tuc/constants/color.dart';
import 'dart:math';

import 'package:tuc/screens/index.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  PageController pageController = new PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
            child: PageView(
                controller: pageController,
                physics: NeverScrollableScrollPhysics(),
                children: [
              Slide(
                  hero: Image.asset(
                    "./assets/images/hero-1.png",
                    height: 395,
                    width: 340,
                  ),
                  title: "Recrutement de proximité",
                  subtitle: "Trouvez le candidat qui vous correspond",
                  onNext: nextPage),
              Slide(
                  hero: Image.asset(
                    "./assets/images/hero-2.png",
                    height: 395,
                    width: 340,
                  ),
                  title: "Explorez des milliers d'offres",
                  subtitle:
                      "Comment trouver l'offre qui correspond à vos attentes ? ",
                  onNext: nextPage),
              Slide(
                  hero: Image.asset(
                    "./assets/images/hero-3.png",
                    height: 395,
                    width: 340,
                  ),
                  title: "Se Faire Référencer",
                  subtitle:
                      "Bénéficiez de la meilleure visibilité en ligne grâce à un référencement naturel ",
                  onNext: nextPage),
              Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                    child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 10,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.width / 3,
                      child: Image.asset("assets/images/logo.png"),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      'Recevez des offres qui vous correspondent dans votre localisation',
                      style: kTitleStyle,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => OnboardingScreen()));
                      },
                      child: Text(
                        'Back',
                        style: kSubtitleStyle,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: ProgressButton(
                        onNext: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => RootPage()));
                        },
                      ),
                    )
                  ],
                )),
              )
            ])),
      ),
    );
  }

  void nextPage() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 200), curve: Curves.ease);
  }
}

class Slide extends StatelessWidget {
  final Widget hero;
  final String title;
  final String subtitle;
  final VoidCallback onNext;

  const Slide(
      {Key? key,
      required this.hero,
      required this.title,
      required this.subtitle,
      required this.onNext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: hero),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  title,
                  style: kTitleStyle,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  subtitle,
                  style: kSubtitleStyle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 35,
                ),
                ProgressButton(onNext: onNext),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => RootPage()));
            },
            child: Text(
              "Skip",
              style: kSubtitleStyle,
            ),
          ),
          SizedBox(
            height: 4,
          )
        ],
      ),
    );
  }
}

class ProgressButton extends StatelessWidget {
  final VoidCallback onNext;
  const ProgressButton({Key? key, required this.onNext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 75,
      height: 75,
      child: Stack(children: [
        AnimatedIndicator(
          duration: const Duration(seconds: 10),
          size: 75,
          callback: onNext,
        ),
        Center(
          child: GestureDetector(
            child: Container(
              height: 60,
              width: 60,
              child: Center(
                  child: Padding(
                padding: EdgeInsets.all(1.0),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 30,
                  color: Colors.white,
                ),
              )),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(99),
                  color: mButtonEmailColor),
            ),
            onTap: onNext,
          ),
        )
      ]),
    );
  }
}

class AnimatedIndicator extends StatefulWidget {
  final Duration duration;
  final double size;
  final VoidCallback callback;
  const AnimatedIndicator(
      {Key? key,
      required this.duration,
      required this.size,
      required this.callback})
      : super(key: key);

  @override
  _AnimatedIndicatorState createState() => _AnimatedIndicatorState();
}

class _AnimatedIndicatorState extends State<AnimatedIndicator>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(duration: widget.duration, vsync: this);
    animation = Tween(begin: 0.0, end: 100.0).animate(controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reset();
          widget.callback();
        }
      });
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return CustomPaint(
              size: Size(widget.size, widget.size),
              painter: ProgressPainter(animation.value));
        });
  }
}

class ProgressPainter extends CustomPainter {
  final double progress;
  ProgressPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    // setup
    var linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = mButtonEmailColor;

    var circlePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = mButtonEmailColor;

    final radians = (progress / 100) * 2 * pi;
    _drawArc(canvas, linePaint, circlePaint, -pi / 2, radians, size);
  }

  void _drawArc(
    Canvas canvas,
    Paint linePaint,
    Paint circlePaint,
    double startRadian,
    double sweepRadian,
    Size size,
  ) {
    final centerX = size.width / 2, centerY = size.height / 2;
    final centerOffset = Offset(centerX, centerY);
    final double radius = min(size.width, size.height) / 2;

    canvas.drawArc(Rect.fromCircle(center: centerOffset, radius: radius),
        startRadian, sweepRadian, false, linePaint);

    final x = radius * (1 + sin(sweepRadian)),
        y = radius * (1 - cos(sweepRadian));
    final circleOffset = Offset(x, y);
    canvas.drawCircle(circleOffset, 5, circlePaint);
  }

  @override
  bool shouldRepaint(CustomPainter old) => true;
}
