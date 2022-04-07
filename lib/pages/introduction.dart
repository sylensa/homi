import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homi/pages/index.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:homi/helper/helper.dart';


class IntroductionPage extends StatefulWidget {
  const IntroductionPage({Key? key}) : super(key: key);

  @override
  _IntroductionPageState createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {

  }



  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/images/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration =  PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      globalHeader: Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16, right: 16),
            child: _buildImage('404.png', 100),
          ),
        ),
      ),
      globalFooter: GestureDetector(
        onTap: (){
          goTo(context, Index(initialIndex: 0,));
        },
        child: Container(
          padding: appPadding(20),
          width: appWidth(context),
          color: dPurple,
          child:  sText('Let\'s go right away!',size: 16,weight: FontWeight.bold,color: Colors.white,align: TextAlign.center),
        ),
      ),
      pages: [
        PageViewModel(
          title: "Fractional shares",
          body:
          "Instead of having to buy an entire share, invest any amount you want.",
          image: _buildImage('img1.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Learn as you go",
          body:
          "Download the Stockpile app and master the market with our mini-lesson.",
          image: _buildImage('img2.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Kids and teens",
          body:
          "Kids and teens can track their stocks 24/7 and place trades that you approve.",
          image: _buildImage('img3.png'),
          decoration: pageDecoration,
        ),

        PageViewModel(
          title: "Another title page",
          body: "Another beautiful body text for this example onboarding",
          image: _buildImage('img4.png'),
          footer: ElevatedButton(
            onPressed: () {
              goTo(context, Index(initialIndex: 0,));
            },
            child: const Text(
              'Done',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              primary: dPurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          decoration: pageDecoration,
        ),

      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: false,
      skipFlex: 0,
      nextFlex: 0,
      color: Colors.white,
      //rtl: true, // Display as right-to-left
      skip: Container(
        padding: appPadding(5),
        decoration: BoxDecoration(
            color: dPurple,
            borderRadius: BorderRadius.circular(30)
        ),
        child: Icon(Icons.skip_next,color: Colors.white),
      ),
      showNextButton: false,

      next: Container(
        padding: appPadding(5),
        decoration: BoxDecoration(
          color: dPurple,
          borderRadius: BorderRadius.circular(30)
        ),
          child: Icon(Icons.arrow_forward_ios,color: Colors.white),
          ),
      done:  sText('', weight: FontWeight.w600,color: Colors.black),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        activeColor: dPurple,
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),

    );
  }
}

