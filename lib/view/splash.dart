import 'package:cached_network_image/cached_network_image.dart';
import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/custom_text.dart';
import 'package:ejazah/Widgets/myNavigate.dart';
import 'package:ejazah/controller/home_controller/home_controller.dart';
import 'package:ejazah/view/auth/choose_language_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../core/global.dart';
import '../database/local/cache_helper.dart';
import '../model/splash_model.dart';
import '../utils/enums.dart';
import 'home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String splashRoute = 'splash_screen';

  const SplashScreen();

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  // late AnimationController _controller;
  // late Animation<double> _animation;
  PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  SplashModel? splashModel;
  RequestState requestState = RequestState.waiting;
  Future<void> getData() async {
    setState(() => requestState = RequestState.loading);
    final res = await HomeController.getSplash();
    if (res) {
      splashModel = HomeController.splashModel;
      setState(() => requestState = RequestState.success);
    } else {
      setState(() => requestState = RequestState.error);
    }
  }

  // List<Widget> _screens = [
  //   WelcomeScreen(
  //     title: 'احجز وحدتك بطريقة بسيطة',
  //     description:
  //         'يوجد لدينا شاليهات و سكن خاص و مشترك و يوجد لدينا مرشدين سياحين',
  //     imagePath: AppImages.ReyadIc,
  //   ),
  //   WelcomeScreen(
  //     title: 'احجز وحدتك بطريقة بسيطة',
  //     description:
  //         'يوجد لدينا شاليهات و سكن خاص و مشترك و يوجد لدينا مرشدين سياحين',
  //     imagePath: AppImages.restaurant,
  //   ),
  //   WelcomeScreen(
  //     title: 'احجز وحدتك بطريقة بسيطة',
  //     description:
  //         'يوجد لدينا شاليهات و سكن خاص و مشترك و يوجد لدينا مرشدين سياحين',
  //     imagePath: AppImages.slider1,
  //   ),
  // ];

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
    // _controller = AnimationController(duration: const Duration(seconds: 5), vsync: this);
    // _animation = CurvedAnimation(
    //   parent: _controller,
    //   curve: Curves.elasticOut,
    // );
    // _controller.repeat(reverse: true);
    // isLoading();
    // fetchDataAndNavigate();
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: AppColor.backGroundColor,
        body: SafeArea(
          child: Builder(builder: (context) {
            if (requestState == RequestState.loading)
              return Center(child: CircularProgressIndicator());

            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: splashModel!.data!.splachs!.length,
                  onPageChanged: _onPageChanged,
                  itemBuilder: (BuildContext context, int index) {
                    final item = splashModel!.data!.splachs![index];
                    return WelcomeScreen(
                        title: item.title!,
                        description: item.desc!,
                        imagePath: item.image!);
                  },
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildPageIndicator(),
                  ),
                ),
              ],
            );
          }),
        ),
        bottomSheet: Builder(
          builder: (context) {
            if (requestState == RequestState.loading)
              return Center(child: CircularProgressIndicator());
            return _currentPage == splashModel!.data!.splachs!.length - 1
                ? TextButton.icon(
                    onPressed: () async {
                      await CacheHelper.saveData(key: 'onboard', value: true);
                      if (!isUserDateSaved) {
                        myNavigate(
                            screen: ChooseLanguageScreen(),
                            context: context,
                            withBackButton: false);
                      } else {
                        myNavigate(
                            screen: HomeScreen(),
                            context: context,
                            withBackButton: false);
                      }
                    },
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: AppColor.buttonColor,
                    ),
                    label: CustomText(
                      text: 'ابدأ الان',
                      color: AppColor.blackColor,
                    ),
                  )
                : SizedBox();
          },
        ),
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < splashModel!.data!.splachs!.length; i++) {
      indicators.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return indicators;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 9.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.blue : Colors.grey[400],
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  const WelcomeScreen({
    Key? key,
    required this.title,
    required this.description,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CachedNetworkImage(
            imageUrl: imagePath,
            height: 60.h,
          ),
          SizedBox(height: 2.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
