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

  Widget _buildImage(String assetName, [double width = 400]) {
    return Image.asset('assets/images/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    final pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor:
          Colors.transparent, // Use transparent color for the page background
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
          title: "",
          bodyWidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildImage('1.png'), // Place the image widget here
              const SizedBox(height: 30), // Add spacing between image and title
              Column(
                children: [
                  Text(
                    'Ready set go, Time to cook',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Unlock your culinary potential, ignite your passion for flavors, and savor the joy of creating extraordinary dishes ',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ],
          ),
          decoration: pageDecoration.copyWith(
            bodyFlex: 30,
            imageFlex: 0,
            bodyAlignment: Alignment.bottomCenter,
            imageAlignment: Alignment.topCenter,
          ),
          image: SlideTransition(
            position: _slideAnimation,
            child:
                const SizedBox(), // Keep the image widget as an empty SizedBox
          ),
          reverse: true,
        ),
        PageViewModel(
          title: "",
          bodyWidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildImage('3.png'), // Place the image widget here
              const SizedBox(height: 30), // Add spacing between image and title
              Column(
                children: [
                  Text(
                    'Follow the Instruction',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Unleash your culinary creativity and elevate your cooking game with this inspiring recipe app.',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ],
          ),
          decoration: pageDecoration.copyWith(
            bodyFlex: 30,
            imageFlex: 0,
            bodyAlignment: Alignment.bottomCenter,
            imageAlignment: Alignment.topCenter,
          ),
          image: SlideTransition(
            position: _slideAnimation,
            child:
                const SizedBox(), // Keep the image widget as an empty SizedBox
          ),
          reverse: true,
        ),
        PageViewModel(
          title: "",
          bodyWidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildImage('2.png'), // Place the image widget here
              const SizedBox(height: 30), // Add spacing between image and title
              Column(
                children: [
                  Text(
                    'Cook your food',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Unleash the gastronomic adventurer within with our recipe app, guiding you through a world of tantalizing flavors.',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ],
          ),
          decoration: pageDecoration.copyWith(
            bodyFlex: 30,
            imageFlex: 0,
            bodyAlignment: Alignment.bottomCenter,
            imageAlignment: Alignment.topCenter,
          ),
          image: SlideTransition(
            position: _slideAnimation,
            child:
                const SizedBox(), // Keep the image widget as an empty SizedBox
          ),
          reverse: true,
        ),
        PageViewModel(
          title: "",
          bodyWidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildImage('4.png'), // Place the image widget here
              const SizedBox(height: 30), // Add spacing between image and title
              Column(
                children: [
                  Text(
                    'Time to eat',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Treat yourself to a homemade feast, crafted with love and care, ready to satisfy your hunger and delight your senses.',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ],
          ),
          decoration: pageDecoration.copyWith(
            bodyFlex: 30,
            imageFlex: 0,
            bodyAlignment: Alignment.bottomCenter,
            imageAlignment: Alignment.topCenter,
          ),
          image: SlideTransition(
            position: _slideAnimation,
            child:
                const SizedBox(), // Keep the image widget as an empty SizedBox
          ),
          reverse: true,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      showSkipButton: false,
      showNextButton: false, // Remove the next button
      showBackButton: false, // Remove the back button
      showDoneButton: false, // Remove the done button
      dotsDecorator: DotsDecorator(
        size: Size(10.0, 10.0),
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
        activeSize: Size(22.0, 10.0),
        activeColor:
            Theme.of(context).colorScheme.primary, // Color of active dot
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
