import 'dart:async';
import 'dart:math';

import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/customAppBar.dart';
import 'package:ejazah/controller/auth/user_controller.dart';
import 'package:ejazah/utils/enums.dart';
import 'package:ejazah/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:slide_countdown/slide_countdown.dart';

import '../../controller/wheel_spin_controller.dart';
import '../../model/wheel_spin_model.dart';

class WheelSpinScreen extends StatefulWidget {
  @override
  _WheelSpinScreenState createState() => _WheelSpinScreenState();
}

class _WheelSpinScreenState extends State<WheelSpinScreen>
    with SingleTickerProviderStateMixin {
  RequestState requestState = RequestState.waiting;
  RequestState requestPostState = RequestState.waiting;
  double turns = 0.0;
  Random random = Random();
  int loop = 1;
  int count = 4;
  double controller = 1;
  double playController = 1.5;

  Future<void> updateTextAnime() async {
    await Future.delayed(Duration(seconds: 5));
    isReset = false;
    playController = 1;
    setState(() {});
    while (count-- > 0) {
      await Future.delayed(Duration(milliseconds: 350));
      if (controller == 1)
        setState(() => controller = 1.5);
      else
        setState(() => controller = 1);
    }
    count = 4;
    startNewTimer();
  }

  bool canShowTime = true;
  bool isReset = true;
  Wheels? wheels;
  Future<void> resetController() async {
    playController = 1.5;
    controller = 1;
    setState(() {});
    await Future.delayed(Duration(milliseconds: 500));
    isReset = true;
    setState(() {});
  }

  Future<void> rotateWheel(id) async {
    setState(() => requestPostState = RequestState.loading);
    final res = await WheelSpinController.postWheel(id.toString());
    if (!res) {
      setState(() => requestPostState = RequestState.error);
      return;
    }
    print(CurrentUser.token);
    savedDateTime = DateTime.now().add(Duration(days: 1));
    getTime();
    wheels?.canTry = false;
    setState(() => requestPostState = RequestState.success);

    int result = wheels!.id!;
    if (loop == 80 * 2 + 1)
      loop = 1;
    else
      loop = 80 * 2 + 1;
    turns = (result * 0.125) * loop - (0.125 / 2);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: AppColor.backGroundColor,
            /*  decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Color.fromRGBO(68, 151, 173, 1),
                Color.fromRGBO(6, 49, 60, 1),
              ],
            )), */
            child: Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.05,
                bottom: size.height * 0.05,
                left: size.height * 0.015,
                right: size.height * 0.015,
              ),
              child: Stack(
                children: [
                  Column(
                    children: [
                      CustomAppBar(
                          pageTitle: 'العب و اكسب', titleColor: Colors.black),
                      SizedBox(height: 6.h),
                      if (!(wheels?.canTry ?? false) && myDuration != null)
                        SlideCountdown(
                          decoration: BoxDecoration(
                            color: AppColor.buttonColor,
                            borderRadius: BorderRadius.circular(100),
                            // gradient: LinearGradient(
                            //   colors: [
                            //     Color.fromRGBO(68, 151, 173, .5),
                            //     Color.fromRGBO(6, 49, 60, .1),
                            //   ],
                            // ),
                          ),
                          showZeroValue: true,
                          shouldShowDays: (_) => false,
                          duration: myDuration,
                          padding: EdgeInsets.all(15),
                          icon: Padding(
                            padding: const EdgeInsets.only(bottom: 8, right: 8),
                            child: Icon(Icons.timer, color: Colors.white),
                          ),
                          textDirection: TextDirection.rtl,
                          textStyle:
                              TextStyle(fontSize: 25, color: Colors.white),
                          separatorStyle:
                              TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      SizedBox(height: 8.h),
                      /* AnimatedContainer(
                      duration: Duration(milliseconds: 350),
                      width: playController * 2 * 50.w,
                      height: playController * 50.w,
                      child: Stack(
                        children: [
                          Positioned(
                            child: Align(
                              alignment: Alignment.center,
                              child: AnimatedRotation(
                                curve: Curves.easeInOutQuint,
                                duration: Duration(seconds: 4),
                                turns: turns,
                                child: Image(
                                    image: AssetImage(
                                        'assets/images/roulette-8-300.png')),
                              ),
                            ),
                          ),
                          Positioned(
                              child: Align(
                            alignment: Alignment.topCenter,
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 350),
                              width: playController * 5.w,
                              height: playController * 5.w,
                              child: RotatedBox(
                                quarterTurns: 2,
                                child: Image(
                                    width: 50,
                                    height: 50,
                                    image: AssetImage(
                                        'assets/images/roulette-center-300.png')),
                              ),
                            ),
                          ))
                        ],
                      ),
                    ),
                     */
                    ],
                  ),
                  Visibility(
                    visible: !isReset,
                    child: Transform.translate(
                      offset: Offset(0, -17.5.h),
                      child: Align(
                        alignment: AlignmentDirectional.bottomCenter,
                        child: AnimatedScale(
                          onEnd: () {
                            wheels!.canTry = true;
                            setState(() {});
                          },
                          scale: 1.0,
                          duration: Duration(milliseconds: 350),
                          curve: Curves.bounceInOut,
                          child: Text(
                            isNumeric('${wheels?.value}')
                                ? 'لقد ربحت ${wheels?.value ?? ''} من ال${(wheels?.key ?? '') == "money" ? "نقود" : "نقاط"}'
                                : "${wheels?.value ?? ""}",
                            style: context.textTheme.headlineLarge!.copyWith(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: requestState == RequestState.loading
                        ? SizedBox(
                            width: 25,
                            height: 25,
                            child: CircularProgressIndicator(),
                          )
                        : Container(
                            height: playController * 60.w,
                            width: playController * 2 * 60.w,
                            child: FortuneWheel(
                              selected: WheelSpinController.selected,
                              animateFirst: false,
                              onAnimationEnd: () {
                                debugPrint(
                                    "====> ${WheelSpinController.wheelSpinModel!.data!.wheels![WheelSpinController.selected.value].value}");
                              },
                              items: [
                                for (int i = 0;
                                    i <
                                        WheelSpinController.wheelSpinModel!
                                            .data!.wheels!.length;
                                    i++) ...<FortuneItem>{
                                  FortuneItem(
                                    child: Text(
                                      WheelSpinController.wheelSpinModel!.data!
                                          .wheels![i].value
                                          .toString(),
                                      style: TextStyle(
                                        fontFamily: "Tajawal",
                                        fontSize: AppFonts.h2,
                                      ),
                                    ),
                                  ),
                                }
                              ],
                            ),
                          ),
                  ),
                  if (wheels?.canTry ?? false)
                    Align(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: Container(
                        width: 50.w,
                        height: 6.5.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: AppColor.buttonColor,
                              alignment: Alignment.center,
                              elevation: 1.5),
                          onPressed: () {
                            canShowTime = false;
                            /*  if (!isReset) {
                              resetController();
                            }
 */
                            WheelSpinController.selected.add(
                              Fortune.randomInt(
                                0,
                                WheelSpinController
                                    .wheelSpinModel!.data!.wheels!.length,
                              ),
                            );
                            if (requestPostState == RequestState.loading)
                              return;
                            rotateWheel(
                              WheelSpinController
                                  .wheelSpinModel!
                                  .data!
                                  .wheels![WheelSpinController.selected.value]
                                  .id,
                            ).then((_) {

                              WheelSpinController.getWheel().then((res) {
                                if (res) {
                                  wheels = WheelSpinController
                                          .wheelSpinModel!.data!.wheels![
                                      WheelSpinController.selected.value];
                                  savedDateTime =
                                      DateTime.parse(wheels!.timetotryagain!);
                                  getTime();
                                  setState(() => isReset = false);
                                }
                              });
                            });
                          },
                          child: Builder(
                            builder: (context) {
                              if (requestPostState == RequestState.loading)
                                return SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: CircularProgressIndicator(
                                    color: AppColor.whiteColor,
                                  ),
                                );
                              return Text(
                                'دور العجلة',
                                style: TextStyle(
                                  fontSize: AppFonts.t2,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  /* if (requestState == RequestState.loading)
                    Align(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ) */
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    requestState = RequestState.loading;
    setState(() {});
    WheelSpinController.getWheel().then((res) {
      if (res) {
        requestState = RequestState.success;
        wheels = WheelSpinController.wheelSpinModel!.data!.wheels![0];
        savedDateTime = DateTime.parse(wheels!.timetotryagain!);
        print(wheels?.canTry);
        getTime();
      } else {
        requestState = RequestState.error;
      }
    });
    setState(() {});
    super.initState();
  }

  late Timer? countdownTimer;
  Duration? myDuration;
  late DateTime? savedDateTime;
  late DateTime now;

  // Future<void> checkTryAgain() async {
  //   // savedDateTime = DateTime.tryParse(CacheHelper.getData(key: 'savedDateTime') ?? '');
  //   now = DateTime.now();
  //   if (savedDateTime == null) return setState(() => canTryAgain = true);
  //   if (now.isAfter(savedDateTime!)) {
  //     print('canTryAgain = true');
  //     setState(() => canTryAgain = true);
  //     await CacheHelper.clearData(key: 'savedDateTime');
  //   } else {
  //     setState(() => canTryAgain = false);
  //     getTime();
  //   }
  //   // print(savedDateTime);
  // }
  //
  Future<void> startNewTimer() async {
    canShowTime = true;
    // savedDateTime = DateTime.tryParse(CacheHelper.getData(key: 'savedDateTime') ?? '');
    now = DateTime.now();
    setState(() => wheels?.canTry = false);
    savedDateTime = DateTime.parse(wheels!.timetotryagain!);
    // print(savedDateTime);
    // print(tomorrow);
    // await CacheHelper.saveData(key: 'savedDateTime', value: tomorrow.toString());
    print('startNewTimer');
    getTime();
  }

  Duration timeBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day, from.hour, from.minute,
        from.second, from.millisecond);
    to = DateTime(to.year, to.month, to.day, to.hour, to.minute, to.second,
        to.millisecond);
    return to.difference(from);
  }

  void getTime() {
    now = DateTime.now();
    setState(() => myDuration = timeBetween(now, savedDateTime!));
    print('myDuration');
    print(myDuration);
    setState(() {});
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }

// Step 6
  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration!.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        print('clearData(key: savedDateTime');
        myDuration = null;
        // CacheHelper.clearData(key: 'savedDateTime');

        setState(() => savedDateTime = null);
        // canTryAgain = true;
        countdownTimer!.cancel();
        wheels!.canTry = true;
        setState(() {});
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }
}

bool isNumeric(String? str) {
  if (str == null) {
    return false;
  }
  return double.tryParse(str) != null;
}
