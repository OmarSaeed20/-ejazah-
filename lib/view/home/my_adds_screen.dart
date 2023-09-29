// ignore_for_file: must_be_immutable

import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/customAppBar.dart';
import 'package:ejazah/Widgets/custom_text.dart';
import 'package:ejazah/Widgets/myNavigate.dart';
import 'package:ejazah/controller/my_ads_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../model/search_models/search_result_model.dart';
import '../../utils/enums.dart';
import '../search_details/details_screen.dart';
import '../search_details/widgets/searchResultWidget.dart';

class MyAdsScreen extends StatefulWidget {
  int selectedIndex = 0;

  MyAdsScreen({super.key, required this.selectedIndex});

  @override
  State<MyAdsScreen> createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> {
  List<String> taps = [
    'إعلانات تحت اجراء الموافقة',
    'إعلانات تمت الموافقة عليها'
  ];
  List<String> selectedCountList = [];
  Map<String, bool> isCheckedList = {};
  bool isSelectLocation = false;
  bool showDeails = false;

  RequestState requestState = RequestState.waiting;
  List<Ads>? previous, current;

  Future<void> getData() async {
    setState(() => requestState = RequestState.loading);
    final res = await MyAdsController.getMyAds();
    if (res) {
      current = MyAdsController.current;
      previous = MyAdsController.previous;
      setState(() => requestState = RequestState.success);
    } else {
      await Future.delayed(Duration(seconds: 5));
      getData();
      setState(() => requestState = RequestState.error);
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      body: SafeArea(
        child: Builder(
          builder: (context) {
            if (requestState == RequestState.loading)
              return Center(child: CircularProgressIndicator());
            if (requestState == RequestState.error)
              return Center(child: Text('تأكد من اتصالك بالانترنت'));

            return SingleChildScrollView(
              padding: EdgeInsets.only(
                top: size.height * 0.025,
                bottom: size.height * 0.04,
                left: size.width * 0.02,
                right: size.width * 0.02,
              ),
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  CustomAppBar(
                    pageTitle: 'اعلاناتي',
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: size.width,
                    height: 8.h,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade500),
                        borderRadius: BorderRadius.circular(10)),
                    child: SizedBox(
                      height: 5.h,
                      child: ListView.builder(
                        itemCount: taps.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2.w),
                            child: ChoiceChip(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              selectedColor: Color.fromRGBO(68, 151, 173, 100),
                              backgroundColor: AppColor.whiteColor,
                              selected: widget.selectedIndex == index,
                              label: Container(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                width: 34.w,
                                height: 15.h,
                                child: CustomText(
                                    text: taps[index],
                                    textAlign: TextAlign.center),
                              ),
                              onSelected: (selected) {
                                setState(() {
                                  widget.selectedIndex = index;
                                });
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  if (widget.selectedIndex == 0 &&
                      (current == null || current!.isEmpty))
                    Container(
                      height: size.height * .8,
                      child: Center(
                        child: CustomText(
                          text: 'لا توجد اعلانات حالية',
                          color: AppColor.orangeColor,
                          fontSize: AppFonts.h2,
                        ),
                      ),
                    ),
                  if (widget.selectedIndex == 0)
                    ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemCount: current!.length,
                      shrinkWrap: true,
                      itemBuilder: (ctx, index) {
                        final element = current![index];
                        return Stack(
                          children: [
                            SearchResultWidget(
                              isMine: true,
                              onTap: () {
                                myNavigate(
                                  screen:
                                      DetailsScreen(ads: element, isSeller: true),
                                  context: context,
                                );
                              },
                              priceDay: "${element.price} ${element.currency}",
                              address: element.address,
                              code: element.offer,
                              title: element.name == null
                                  ? element.travel_name
                                  : element.name,
                              image: element.images![0].image,
                              totalPrice:
                                  '${element.totalPrice} ${element.currency} ',
                              isFavourite: element.favourite,
                            ),
                            Positioned(
                              left: 8.0.w,
                              bottom: 1.0.h,
                              child: IconButton(
                                icon: Icon(
                                  CupertinoIcons.delete_solid,
                                  color: AppColor.redColor,
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        backgroundColor: Colors.white,
                                        icon: Icon(
                                          CupertinoIcons.delete_solid,
                                          color: AppColor.redColor,
                                          size: 16.h,
                                        ),
                                        elevation: 4,
                                        shadowColor: Colors.grey,
                                        title: Text(
                                          'هل انت متأكد من حذف الإعلان',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: AppFonts.t2,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        actions: [
                                          Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: size.width * 0.33,
                                                  height: 6.5.h,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: TextButton(
                                                      style: TextButton.styleFrom(
                                                          backgroundColor:
                                                              AppColor
                                                                  .secondColor,
                                                          alignment:
                                                              Alignment.center),
                                                      onPressed: () async {
                                                        MyAdsController.deleteAds(
                                                                id: '${element.id}')
                                                            .then((res) {
                                                          if (res) {
                                                            current!.removeWhere(
                                                                (item) =>
                                                                    item.id ==
                                                                    element.id);
                                                            setState(() {});
                                                            Navigator.pop(
                                                                context);
                                                          }
                                                        });
                                                      },
                                                      child: Text(
                                                        'حذف الإعلان',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                AppFonts.t2,
                                                            color:
                                                                Colors.white),
                                                      )),
                                                ),
                                                SizedBox(
                                                  width: 3.w,
                                                ),
                                                Container(
                                                  width: size.width * 0.33,
                                                  height: 7.h,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors
                                                            .grey.shade300,
                                                        blurRadius: 3.0,
                                                      ),
                                                    ],
                                                  ),
                                                  child: TextButton(
                                                    style: TextButton.styleFrom(
                                                        backgroundColor:
                                                            Color.fromARGB(255,
                                                                243, 243, 243),
                                                        alignment:
                                                            Alignment.center),
                                                    onPressed: () async {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      'الغاء',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: AppFonts.t2,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(
                        height: 2.h,
                      ),
                    ),
                  if (widget.selectedIndex == 1 &&
                      (previous == null || previous!.isEmpty))
                    Container(
                      height: size.height * .8,
                      child: Center(
                        child: CustomText(
                          text: 'لا توجد اعلانات سابقة',
                          color: AppColor.orangeColor,
                          fontSize: AppFonts.h2,
                        ),
                      ),
                    ),
                  if (widget.selectedIndex == 1)
                    ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemCount: previous!.length,
                      shrinkWrap: true,
                      itemBuilder: (ctx, index) {
                        final element = previous![index];
                        return Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          clipBehavior: Clip.hardEdge,
                          children: [
                            SearchResultWidget(
                              isMine: true,
                              isPay: element.is_pay == "1" ? true : false,
                              onTap: () {
                                myNavigate(
                                    screen:
                                        DetailsScreen(ads: element, isSeller: true),
                                    context: context);
                              },
                              priceDay: "${element.price} ${element.currency}",
                              address: element.address,
                              code: element.offer,
                              title: element.name == null
                                  ? element.travel_name
                                  : element.name,
                              image: element.images![0].image,
                              totalPrice:
                                  '${element.totalPrice} ${element.currency} ',
                              isFavourite: element.favourite,
                            ),
                            Positioned(
                              left: 8.0.w,
                              bottom: 1.0.h,
                              child: IconButton(
                                icon: Icon(
                                  CupertinoIcons.delete_solid,
                                  color: AppColor.redColor,
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        backgroundColor: Colors.white,
                                        icon: Icon(
                                          CupertinoIcons.delete_solid,
                                          color: AppColor.redColor,
                                          size: 16.h,
                                        ),
                                        elevation: 4,
                                        shadowColor: Colors.grey,
                                        title: Text(
                                          'هل انت متأكد من حذف الإعلان',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: AppFonts.t2,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        actions: [
                                          Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: size.width * 0.33,
                                                  height: 7.h,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: TextButton(
                                                      style: TextButton.styleFrom(
                                                          backgroundColor:
                                                              AppColor
                                                                  .secondColor,
                                                          alignment:
                                                              Alignment.center),
                                                      onPressed: () async {
                                                        MyAdsController.deleteAds(
                                                                id: '${element.id}')
                                                            .then((res) {
                                                          if (res) {
                                                            previous!.removeWhere(
                                                                (item) =>
                                                                    item.id ==
                                                                    element.id);
                                                            setState(() {});
                                                            Navigator.pop(
                                                                context);
                                                          }
                                                        });
                                                      },
                                                      child: Text(
                                                        'حذف الإعلان',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                AppFonts.t2,
                                                            color:
                                                                Colors.white),
                                                      )),
                                                ),
                                                SizedBox(
                                                  width: 3.w,
                                                ),
                                                Container(
                                                  width: size.width * 0.33,
                                                  height: 7.h,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors
                                                            .grey.shade300,
                                                        blurRadius: 3.0,
                                                      ),
                                                    ],
                                                  ),
                                                  child: TextButton(
                                                    style: TextButton.styleFrom(
                                                        backgroundColor:
                                                            Color.fromARGB(255,
                                                                243, 243, 243),
                                                        alignment:
                                                            Alignment.center),
                                                    onPressed: () async {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      'الغاء',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: AppFonts.t2,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(
                        height: 2.h,
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
