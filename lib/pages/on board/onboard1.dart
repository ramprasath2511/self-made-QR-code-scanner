import 'dart:async';
import 'package:doctor_appointment_booking/pages/introscreen/introduction.dart';
import 'package:doctor_appointment_booking/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';

import '../../utils/app_themes.dart';

class onboard extends StatefulWidget {
  @override
  _onboardState createState() => _onboardState();
}

class _onboardState extends State<onboard> {
  var pageController = PageController(initialPage: 0);
  var pageViewModelData = List<PageViewData>();

  Timer sliderTimer;
  var currentShowIndex = 0;

  @override
  void initState() {
    pageViewModelData.add(PageViewData(
      titleText: 'Place Your Sticker',
      assetsImage: 'assets/images/Ellipse 2.png',
    ));

    pageViewModelData.add(PageViewData(
      titleText: 'Add Your Notes',
      assetsImage: 'assets/images/image.png',
    ));

    pageViewModelData.add(PageViewData(
      titleText: 'Qr Know',
      assetsImage: 'assets/images/mobile.png',
    ));

    sliderTimer = Timer.periodic(Duration(seconds: 4), (timer) {
      if (currentShowIndex == 0) {
        pageController.animateTo(MediaQuery.of(context).size.width,
            duration: Duration(seconds: 3), curve: Curves.fastOutSlowIn);
      } else if (currentShowIndex == 1) {
        pageController.animateTo(MediaQuery.of(context).size.width * 2,
            duration: Duration(seconds: 3), curve: Curves.fastOutSlowIn);
      } else if (currentShowIndex == 2) {
        pageController.animateTo(0,
            duration: Duration(seconds: 3), curve: Curves.fastOutSlowIn);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    sliderTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            Expanded(
              child: PageView(
                controller: pageController,
                pageSnapping: true,
                onPageChanged: (index) {
                  currentShowIndex = index;
                },
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  PagePopup(imageData: pageViewModelData[0]),
                  PagePopup(imageData: pageViewModelData[1]),
                  PagePopup(imageData: pageViewModelData[2]),
                ],
              ),
            ),
            PageIndicator(
              layout: PageIndicatorLayout.WARM,
              size: 10.0,
              controller: pageController,
              space: 5.0,
              count: 3,
              color: Theme.of(context).dividerColor,
              activeColor: Theme.of(context).primaryColor,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 48, right: 48, bottom: 8, top: 32),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(24.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Theme.of(context).dividerColor,
                      blurRadius: 8,
                      offset: Offset(4, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(24.0)),
                    highlightColor: Colors.transparent,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => IntroScreen()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xFFe84c0f),
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Text(
                          'Get Started!',
                          style: Theme.of(context).textTheme.subhead.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30 + MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }
}

class PagePopup extends StatelessWidget {
  final PageViewData imageData;

  const PagePopup({Key key, this.imageData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 0, left: 0, top: 50),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width - 120,
                height: MediaQuery.of(context).size.height,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(
                    imageData.assetsImage,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: <Widget>[
                Text(imageData.titleText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontStyle: FontStyle.normal,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 32)),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: SizedBox(),
          ),
        ],
      ),
    );
  }
}

class PageViewData {
  final String titleText;
  final String assetsImage;

  PageViewData({this.titleText, this.assetsImage});
}
