import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:my_recipe/login/loginPage.dart';

class IntroductionWidget extends StatefulWidget {
  const IntroductionWidget({Key? key}) : super(key: key);

  @override
  State<IntroductionWidget> createState() => _IntroductionWidgetState();
}

class _IntroductionWidgetState extends State<IntroductionWidget>
    with SingleTickerProviderStateMixin {
  final introKey = GlobalKey<IntroductionScreenState>();
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => LoginPage()),
    );
  }

  Widget _buildImage(String assetName, [double width = 300]) {
    return Image.asset('images/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.transparent,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.transparent,

      allowImplicitScrolling: true,
      autoScrollDuration: 4500,

      globalHeader: const Align(
        alignment: Alignment.topRight,
      ),
      pages: [
        PageViewModel(
          title: "My Recipes",

          bodyWidget:
              const SizedBox(), // Empty SizedBox to remove the body text
          decoration: pageDecoration.copyWith(
            bodyFlex: 5,
            imageFlex: 8,
            bodyAlignment: Alignment.bottomCenter,
            imageAlignment: Alignment.topCenter,
          ),
          image: SlideTransition(
            position: _slideAnimation,
            child: _buildImage('loginScreen1.jpeg'),
          ),
          reverse: true,
        ),
        PageViewModel(
          title: "Ugly as fuck",
          bodyWidget:
              const SizedBox(), // Empty SizedBox to remove the body text
          decoration: pageDecoration.copyWith(
            bodyFlex: 5,
            imageFlex: 8,
            bodyAlignment: Alignment.bottomCenter,
            imageAlignment: Alignment.topCenter,
          ),
          image: SlideTransition(
            position: _slideAnimation,
            child: _buildImage('loginScreen1.jpeg'),
          ),
          reverse: true,
        ),
        PageViewModel(
          title: "Sarwin you are gay",
          bodyWidget:
              const SizedBox(), // Empty SizedBox to remove the body text
          decoration: pageDecoration.copyWith(
            bodyFlex: 5,
            imageFlex: 8,
            bodyAlignment: Alignment.bottomCenter,
            imageAlignment: Alignment.topCenter,
          ),
          image: SlideTransition(
            position: _slideAnimation,
            child: _buildImage('loginScreen1.jpeg'),
          ),
          reverse: true,
        ),
        PageViewModel(
          title: "same as farhaan, gay",
          bodyWidget:
              const SizedBox(), // Empty SizedBox to remove the body text
          decoration: pageDecoration.copyWith(
            bodyFlex: 5,
            imageFlex: 8,
            bodyAlignment: Alignment.bottomCenter,
            imageAlignment: Alignment.topCenter,
          ),
          image: SlideTransition(
            position: _slideAnimation,
            child: _buildImage('loginScreen1.jpeg'),
          ),
          reverse: true,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      showSkipButton: false,
      showNextButton: false, // Remove the next button
      showBackButton: false, // Remove the back button
      showDoneButton: false, // Remove the done button
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeColor: Color(0xFF575ecb), // Color of active dot
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
