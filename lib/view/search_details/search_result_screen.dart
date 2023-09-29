// ignore_for_file: deprecated_member_use, must_be_immutable

import 'package:ejazah/Widgets/Custom_TextField.dart';
import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/app_images.dart';
import 'package:ejazah/Widgets/customBtn.dart';
import 'package:ejazah/Widgets/custom_text.dart';
import 'package:ejazah/Widgets/myNavigate.dart';
import 'package:ejazah/controller/auth/get_streets_controller.dart';
import 'package:ejazah/controller/home_controller/home_controller.dart';
import 'package:ejazah/utils/enums.dart';
import 'package:ejazah/view/search_details/details_screen.dart';
import 'package:ejazah/view/search_details/widgets/searchResultWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../controller/favourite_controller/favourite_controller.dart';
import '../../controller/search_controller/category_result_controller.dart';
import '../../model/search_models/search_result_model.dart';

class SearchResultScreen extends StatefulWidget {
  int categoryId;
  int selectedIndex = 0;

  String? title;
  SearchResultScreen({
    super.key,
    required this.selectedIndex,
    required this.categoryId,
    this.title,
  });

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  List<String> taps = ['الكل', 'العروض', 'السعر', 'الحي', 'التقيم'];
  List<String> taps2 = ['مخيمات', 'شاليهات'];
  SfRangeValues _values = SfRangeValues(100, 9900);
  Map<String, bool> isCheckedList = {};
  bool isSelectLocation = false;
  bool showDeails = false;
  CategoryModel? categorySearchModel;

  RequestState requestState = RequestState.waiting;

  int lastIndex = 0;
  bool isEmpty = true;

  getSearchData(index,
      {word,
      offers,
      privace,
      min,
      max,
      street_id,
      rate,
      categoryId,
      chalets,
      camp}) {
    if (taps.length > 5) {
      if (index > 3)
        index -= 2;
      else if (index == 1)
        camp = 'camp';
      else if (index == 2) chalets = 'chalets =';
    }
    if (index == 1) offers = 'true';
    if (index == 2) {
      min = '${_values.start.toInt()}';
      max = '${_values.end.toInt()}';
    }
    if (index == 3) {
      final res = GetStreetsController.getStreetsModel!.data!.streets!;
      if (res.isEmpty)
        street_id = '';
      else
        street_id = res[0].id.toString();
    }
    if (index == 4) rate = '1';
    lastIndex = index;
    setState(() => requestState = RequestState.loading);
    CategoryResultController.getFilterResult(
      widget.categoryId,
      word: word,
      max: max,
      min: min,
      offers: offers,
      privace: privace,
      rate: rate,
      street_id: street_id,
      camp: camp,
      chalets: chalets,
    ).then((value) {
      if (value) {
        categorySearchModel = CategoryResultController.categorySearchModel;
        setState(() => requestState = RequestState.success);
      } else {
        setState(() => requestState = RequestState.error);
      }
    });
  }

  @override
  void initState() {
    if (widget.categoryId == 5) {
      taps.insertAll(2, taps2);
    }
    getSearchData(lastIndex);
    super.initState();
  }

  bool isSearchable = false;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.backGroundColor,
      body: SafeArea(
        child: Container(
            margin: EdgeInsets.only(top: 2.5.h, left: 0, right: 0),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          // myNavigate(
                          //   screen: HomePageScreen(), context: context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(1.5.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.w),
                              color: AppColor.whiteColor),
                          child: Icon(
                            Icons.arrow_back,
                            color: AppColor.grayColor,
                            size: 4.5.w,
                          ),
                        ),
                      ),
                      CustomText(
                        textAlign: TextAlign.center,
                        text: widget.title ?? 'نتائج البحث',
                        fontSize: AppFonts.t1,
                        fontweight: FontWeight.bold,
                        color: AppColor.blackColor,
                        fontFamily: 'Tajawal',
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.0.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          controller: searchController,
                          onChangedFun: () {
                            if (searchController.text.isNotEmpty)
                              getSearchData(0, word: searchController.text);
                            else
                              getSearchData(0);
                          },
                          // width: widget.categoryId != 6 && widget.categoryId != 8 ? 80.w : 90.w,
                          width: double.infinity,
                          hintText: 'بحث',
                          prefixIcon: SvgPicture.asset(
                            'assets/svg/search-normal.svg',
                            fit: BoxFit.fitWidth,
                            color: AppColor.orangeColor,
                          ),
                        ),
                      ),
                      // if (widget.categoryId != 6 && widget.categoryId != 8)
                      //   InkWell(
                      //   borderRadius: BorderRadius.circular(2.w),
                      //   onTap: () {
                      //     setState(() {
                      //       isSelectLocation = !isSelectLocation;
                      //     });
                      //   },
                      //   child: Container(
                      //       padding: EdgeInsets.all(3.w),
                      //       decoration: BoxDecoration(
                      //           color: isSelectLocation == true
                      //               ? AppColor.orangeColor.withOpacity(.2)
                      //               : AppColor.whiteColor,
                      //           borderRadius: BorderRadius.circular(2.w),
                      //           border: Border.all(
                      //               color: isSelectLocation == true
                      //                   ? AppColor.orangeColor
                      //                   : Colors.transparent)),
                      //       child: SvgPicture.asset(
                      //         'assets/svg/location-linear.svg',
                      //         fit: BoxFit.fitWidth,
                      //       )),
                      // ),
                    ],
                  ),
                ),
                if (widget.categoryId != 8)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: SizedBox(
                      height: 5.h,
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView.builder(
                          itemCount: taps.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.w),
                              child: ChoiceChip(
                                selectedColor: AppColor.orangeColor,
                                backgroundColor: AppColor.whiteColor,
                                selected: widget.selectedIndex == index,
                                label: CustomText(text: taps[index]),
                                onSelected: (selected) {
                                  getSearchData(index,
                                      categoryId: widget.categoryId.toString());
                                  setState(() {
                                    // widget.isEmpty = true;
                                    widget.selectedIndex = index;
                                  });
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                Builder(
                  builder: (context) {
                    if (requestState == RequestState.loading)
                      return CircularProgressIndicator();
                    if (requestState == RequestState.error &&
                            !isSelectLocation ||
                        categorySearchModel == null)
                      return Center(
                          child: Column(
                        children: [
                          Text('تأكد من اتصالك بالأنترنت'),
                          ElevatedButton(
                              onPressed: () {
                                getSearchData(lastIndex);
                              },
                              child: Text('اعادة المحاولة'),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.amber[900]))),
                        ],
                      ));
                    if (searchController.text.isNotEmpty) {
                      isSearchable = true;
                      if (categorySearchModel != null &&
                          categorySearchModel!.data!.ads!.isNotEmpty) {
                        return Expanded(
                          child: Stack(
                            children: [
                              RefreshIndicator(
                                onRefresh: () async {
                                  await getSearchData(lastIndex);
                                },
                                child: Builder(builder: (context) {
                                  if (categorySearchModel!.data!.ads!.isEmpty)
                                    return Center(
                                        child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text('لا يوجد نتائج حاليا'),
                                        SizedBox(height: 15),
                                        MaterialButton(
                                          elevation: 0,
                                          color: AppColor.orangeColor,
                                          onPressed: () {
                                            getSearchData(lastIndex);
                                          },
                                          child: Text('انقر لإعادة المحاولة',
                                              style: context
                                                  .textTheme.titleMedium!
                                                  .copyWith(
                                                color: Colors.white,
                                              )),
                                        )
                                      ],
                                    ));
                                  return ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      itemCount: categorySearchModel!
                                          .data!.ads!.length,
                                      shrinkWrap: true,
                                      itemBuilder: (ctx, index) {
                                        final item = categorySearchModel!
                                            .data!.ads![index];
                                        return SearchResultWidget(
                                          onTapFav: () async {
                                            setState(() => item.favourite =
                                                !item.favourite!);
                                            final res =
                                                await FavouriteController
                                                    .postFav('${item.id}');
                                            if (!res)
                                              setState(() => item.favourite =
                                                  !item.favourite!);
                                          },
                                          onTap: () => showModalBottomSheet(
                                            isScrollControlled: true,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(30),
                                                  topRight:
                                                      Radius.circular(30)),
                                            ),
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Padding(
                                                padding: EdgeInsets.all(2.h),
                                                child: Container(
                                                  height: size.height * 0.65,
                                                  child: Column(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        height: 3.h,
                                                      ),
                                                      Center(
                                                        child: SvgPicture.asset(
                                                          'assets/svg/Group 36770.svg',
                                                          width: 20.w,
                                                          height: 20.h,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5.h,
                                                      ),
                                                      Center(
                                                        child: Text(
                                                          'ضمان إجازة',
                                                          style: TextStyle(
                                                            fontSize:
                                                                AppFonts.t2,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 2.h,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'نضمن لك صحة المعلومات في هذه الصفحه ونضمن لك نظافة المكان وفي حال لم تطابق المعلومات 80% نوفر لك أحد الخيارات',
                                                            style: TextStyle(
                                                              fontSize:
                                                                  AppFonts.t4_2,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 2.5.h,
                                                          ),
                                                          Text(
                                                            'حجز بديل بنفس المواصفات والسعر',
                                                            style: TextStyle(
                                                              fontSize:
                                                                  AppFonts.t4_2,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 2.h,
                                                          ),
                                                          Text(
                                                            'الغاء الحجز واسترداد المبلغ بالكامل بغض النظر عن ساسة الاسترجاع والخصوصيه',
                                                            style: TextStyle(
                                                              fontSize:
                                                                  AppFonts.t4_2,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 3.h,
                                                      ),
                                                      Container(
                                                        width: size.width,
                                                        height: 7.h,
                                                        decoration: BoxDecoration(
                                                            gradient: AppColor
                                                                .btnColor),
                                                        child: ElevatedButton(
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .transparent),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                              myNavigate(
                                                                  screen: DetailsScreen(
                                                                      ads:
                                                                          item),
                                                                  context:
                                                                      context);
                                                            },
                                                            child: Text(
                                                              'حسنـاّ',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                          priceDay: '${item.price}',
                                          address:
                                              "${item.city} , ${item.street_name}",
                                          code: '${item.offer}',
                                          title: item.name,
                                          title_travel_name: item.travel_name,
                                          image: item.images!.first.image,
                                          totalPrice: '${item.totalPrice}',
                                          isFavourite: item.favourite,
                                          isPay:
                                              item.is_pay == "1" ? true : false,
                                        );
                                      });
                                }),
                              ),
                              // Positioned(
                              //     bottom: 2.h,
                              //     left: 30.w,
                              //     right: 30.w,
                              //     child: InkWell(
                              //       onTap: () {
                              //         ShowArrangedBottomSheet(context);
                              //       },
                              //       child: Container(
                              //         alignment: Alignment.center,
                              //         padding: EdgeInsets.all(3.w),
                              //         decoration: BoxDecoration(
                              //           borderRadius:
                              //               BorderRadius.circular(1.w),
                              //           color: AppColor.orangeColor,
                              //         ),
                              //         child: Row(
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.center,
                              //           children: [
                              //             SvgPicture.asset(
                              //               'assets/svg/arrow-3-linear.svg',
                              //               color: Colors.white,
                              //               width: 4.w,
                              //               height: 4.w,
                              //             ),
                              //             CustomText(
                              //                 padding: EdgeInsets.symmetric(
                              //                     horizontal: 2.w),
                              //                 text: "ترتيب",
                              //                 overflow: TextOverflow.ellipsis,
                              //                 color: AppColor.whiteColor,
                              //                 fontSize: AppFonts.t2),
                              //           ],
                              //         ),
                              //       ),
                              //     ))
                            ],
                          ),
                        );
                      } else {
                        return Center(child: Text('لا يوجد نتائج بهذا البحث'));
                      }
                    }
                    return Expanded(
                      child: Stack(
                        children: [
                          RefreshIndicator(
                            onRefresh: () async {
                              await getSearchData(lastIndex);
                            },
                            child: Builder(builder: (context) {
                              if (categorySearchModel!.data!.ads!.isEmpty)
                                return Center(
                                    child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('لا يوجد نتائج حاليا'),
                                    SizedBox(height: 15),
                                    MaterialButton(
                                      elevation: 0,
                                      color: AppColor.orangeColor,
                                      onPressed: () {
                                        getSearchData(lastIndex);
                                      },
                                      child: Text('انقر لإعادة المحاولة',
                                          style: context.textTheme.titleMedium!
                                              .copyWith(
                                            color: Colors.white,
                                          )),
                                    )
                                  ],
                                ));
                              return ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemCount:
                                      categorySearchModel!.data!.ads!.length,
                                  shrinkWrap: true,
                                  itemBuilder: (ctx, index) {
                                    final item =
                                        categorySearchModel!.data!.ads![index];

                                    return SearchOfferResultWidget(
                                      travel_type: item.travel_type,
                                      offerPrice: item.offer.toString() == '0'
                                          ? null
                                          : item.offer.toString(),
                                      onTapFav: () async {
                                        setState(() =>
                                            item.favourite = !item.favourite!);
                                        final res =
                                            await FavouriteController.postFav(
                                                '${item.id}');
                                        if (!res)
                                          setState(() => item.favourite =
                                              !item.favourite!);
                                      },
                                      onTap: () => showModalBottomSheet(
                                        isScrollControlled: true,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              topRight: Radius.circular(30)),
                                        ),
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Padding(
                                            padding: EdgeInsets.all(2.h),
                                            child: Container(
                                              height: size.height * 0.65,
                                              child: Column(
                                                children: <Widget>[
                                                  SizedBox(
                                                    height: 3.h,
                                                  ),
                                                  Center(
                                                    child: SvgPicture.asset(
                                                      'assets/svg/Group 36770.svg',
                                                      width: 20.w,
                                                      height: 20.h,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5.h,
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      'ضمان إجازة',
                                                      style: TextStyle(
                                                        fontSize: AppFonts.t2,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 2.h,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'نضمن لك صحة المعلومات في هذه الصفحه ونضمن لك نظافة المكان وفي حال لم تطابق المعلومات 80% نوفر لك أحد الخيارات',
                                                        style: TextStyle(
                                                          fontSize:
                                                              AppFonts.t4_2,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 2.5.h,
                                                      ),
                                                      Text(
                                                        'حجز بديل بنفس المواصفات والسعر',
                                                        style: TextStyle(
                                                          fontSize:
                                                              AppFonts.t4_2,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 2.h,
                                                      ),
                                                      Text(
                                                        'الغاء الحجز واسترداد المبلغ بالكامل بغض النظر عن ساسة الاسترجاع والخصوصيه',
                                                        style: TextStyle(
                                                          fontSize:
                                                              AppFonts.t4_2,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 3.h,
                                                  ),
                                                  Container(
                                                    width: size.width,
                                                    height: 7.h,
                                                    decoration: BoxDecoration(
                                                        gradient:
                                                            AppColor.btnColor),
                                                    child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                          myNavigate(
                                                              screen:
                                                                  DetailsScreen(
                                                                      ads:
                                                                          item),
                                                              context: context);
                                                        },
                                                        child: Text(
                                                          'حسنـاّ',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      priceDay: '${item.price}',
                                      address:
                                          "${item.city}  ${item.street_name!.isEmpty ? "" : ",${item.street_name}"}",
                                      code: '${item.offer}',
                                      title: item.name,
                                      title_travel_name: item.travel_name,
                                      image: item.images!.first.image,
                                      totalPrice: '${item.totalPrice}',
                                      isFavourite: item.favourite,
                                      isPay: item.is_pay == "1" ? true : false,
                                    );
                                  });
                            }),
                          ),
                          Builder(builder: (context) {
                            int add = widget.selectedIndex;
                            if (widget.categoryId == 5) {
                              add -= 2;
                            }
                            switch (add) {
                              case 2:
                                return Positioned(
                                    bottom: 2.h,
                                    left: 25.w,
                                    right: 20.w,
                                    child: InkWell(
                                      onTap: () {
                                        ShowPriceBottomSheet(context);
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(3.w),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(1.w),
                                          color: AppColor.orangeColor,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/svg/arrow-3-linear.svg',
                                              color: Colors.white,
                                              width: 4.w,
                                              height: 4.w,
                                            ),
                                            CustomText(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 2.w),
                                                text: "ترتيب حسب السعر",
                                                overflow: TextOverflow.ellipsis,
                                                color: AppColor.whiteColor,
                                                fontSize: AppFonts.t2),
                                          ],
                                        ),
                                      ),
                                    ));
                              case 3:
                                return Positioned(
                                    bottom: 2.h,
                                    left: 25.w,
                                    right: 20.w,
                                    child: InkWell(
                                      onTap: () {
                                        ShowArrangedAreasBottomSheet(context);
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(3.w),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(1.w),
                                          color: AppColor.orangeColor,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/svg/arrow-3-linear.svg',
                                              color: Colors.white,
                                              width: 4.w,
                                              height: 4.w,
                                            ),
                                            CustomText(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 2.w),
                                                text: "ترتيب حسب الحي",
                                                overflow: TextOverflow.ellipsis,
                                                color: AppColor.whiteColor,
                                                fontSize: AppFonts.t2),
                                          ],
                                        ),
                                      ),
                                    ));
                              case 4:
                                return Positioned(
                                    bottom: 2.h,
                                    left: 25.w,
                                    right: 20.w,
                                    child: InkWell(
                                      onTap: () {
                                        ShowRattingBottomSheet(context);
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(3.w),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(1.w),
                                          color: AppColor.orangeColor,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/svg/arrow-3-linear.svg',
                                              color: Colors.white,
                                              width: 4.w,
                                              height: 4.w,
                                            ),
                                            CustomText(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 2.w),
                                                text: "ترتيب حسب التقيم",
                                                overflow: TextOverflow.ellipsis,
                                                color: AppColor.whiteColor,
                                                fontSize: AppFonts.t2),
                                          ],
                                        ),
                                      ),
                                    ));
                            }
                            return Container();
                          })
                        ],
                      ),
                    );
                  },
                ),
              ],
            )),
      ),
    );
  }

  Future<dynamic> ShowArrangedBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          // <-- SEE HERE
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CustomText(
                    padding: EdgeInsets.symmetric(vertical: 2.w),
                    text: 'الترتيب علي حسب',
                    fontweight: FontWeight.bold),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                        width: 45.w,
                        height: 6.h,
                        radius: 1.w,
                        color: AppColor.primaryOpacityColor,
                        text: 'تطبيق',
                        onPressed: () => Navigator.pop(context)),
                    CustomButton(
                        radius: 1.w,
                        height: 6.h,
                        width: 45.w,
                        color: AppColor.whiteColor,
                        textColor: AppColor.blackColor,
                        text: 'مسح',
                        onPressed: () => Navigator.pop(context)),
                  ],
                )
              ],
            ),
          );
        });
  }

  Future<dynamic> ShowArrangedSakaanBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CustomText(
                        padding: EdgeInsets.symmetric(vertical: 6.w),
                        text: 'تصفية بنوع السكن',
                        fontweight: FontWeight.bold,
                        fontSize: AppFonts.t3),
                    ListView.builder(
                      itemCount:
                          HomeController.getHomeModel!.data!.categories!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final item = HomeController
                            .getHomeModel!.data!.categories![index];

                        return InkWell(
                          onTap: () {
                            setState(() {
                              // UserController.languageId = languageNum;
                              lastCheckIdItem = item.id.toString();
                              getSearchData(lastIndex,
                                  categoryId: lastCheckIdItem);
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                item.title!,
                                style: TextStyle(
                                    fontSize: AppFonts.t3,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                              Radio(
                                value: item.id.toString(),
                                groupValue: lastCheckIdItem,
                                onChanged: (val) {
                                  setState(() {
                                    lastCheckIdItem = val.toString();
                                    getSearchData(lastIndex,
                                        categoryId: lastCheckIdItem);
                                  });
                                },
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.green),
                                focusColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.green),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButton(
                            width: 45.w,
                            height: 6.h,
                            radius: 1.w,
                            color: AppColor.primaryOpacityColor,
                            text: 'تطبيق',
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                        CustomButton(
                            radius: 1.w,
                            height: 6.h,
                            width: 45.w,
                            color: AppColor.whiteColor,
                            textColor: AppColor.blackColor,
                            text: 'مسح',
                            onPressed: () => Navigator.pop(context)),
                      ],
                    )
                  ],
                ),
              );
            },
          );
        });
  }

  Future<dynamic> ShowArrangedAreasBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          // <-- SEE HERE
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 4.w),
            // height: 50.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CustomText(
                    padding: EdgeInsets.symmetric(vertical: 2.w),
                    text: 'تصفية النتائج بالحي',
                    fontweight: FontWeight.bold,
                    fontSize: AppFonts.t3),
                if (GetStreetsController
                        .getStreetsModel!.data!.streets!.length ==
                    0)
                  Center(child: Text('لا توجد نتائج حاليا...')),
                if (GetStreetsController
                        .getStreetsModel!.data!.streets!.length !=
                    0)
                  StatefulBuilder(
                    builder: (context, setState) {
                      return ListView.builder(
                        itemCount: GetStreetsController
                            .getStreetsModel!.data!.streets!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final item = GetStreetsController
                              .getStreetsModel!.data!.streets![index];

                          return InkWell(
                            onTap: () {
                              setState(() {
                                lastCheckIdItem = item.id.toString();
                                getSearchData(lastIndex,
                                    street_id: item.id!.toString());
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item.name!,
                                  style: TextStyle(
                                      fontSize: AppFonts.t3,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                                Radio(
                                  value: item.id.toString(),
                                  groupValue: lastCheckIdItem,
                                  onChanged: (val) {
                                    setState(() {
                                      lastCheckIdItem = val.toString();
                                      getSearchData(lastIndex,
                                          street_id: item.id!);
                                    });
                                  },
                                  fillColor: MaterialStateColor.resolveWith(
                                      (states) => Colors.green),
                                  focusColor: MaterialStateColor.resolveWith(
                                      (states) => Colors.green),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                        width: 45.w,
                        height: 6.h,
                        radius: 1.w,
                        color: AppColor.primaryOpacityColor,
                        text: 'تطبيق',
                        onPressed: () => Navigator.pop(context)),
                    CustomButton(
                        radius: 1.w,
                        height: 6.h,
                        width: 45.w,
                        color: AppColor.whiteColor,
                        textColor: AppColor.blackColor,
                        text: 'مسح',
                        onPressed: () => Navigator.pop(context)),
                  ],
                )
              ],
            ),
          );
        });
  }

  Future<dynamic> ShowPriceBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 4.w),
              height: 38.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CustomText(
                      padding: EdgeInsets.symmetric(vertical: 2.w),
                      text: 'تصفية النتائج بالسعر',
                      fontweight: FontWeight.bold),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SfRangeSlider(
                      min: 100.0,
                      max: 10000.0,
                      values: _values,
                      showLabels: true,
                      interval: 9900,
                      activeColor: AppColor.orangeColor,
                      labelFormatterCallback:
                          (dynamic actualValue, String formattedText) {
                        return actualValue != 10000
                            ? '${_values.start.toInt()}  / ليله'
                            : '${_values.end.toInt()}  / ليله';
                      },
                      onChanged: (SfRangeValues newValues) {
                        setState(() {
                          _values = newValues;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                          width: 45.w,
                          height: 6.h,
                          radius: 1.w,
                          color: AppColor.primaryOpacityColor,
                          text: 'تطبيق',
                          onPressed: () {
                            getSearchData(lastIndex);
                            Navigator.pop(context);
                          }),
                      CustomButton(
                          radius: 1.w,
                          height: 6.h,
                          width: 45.w,
                          color: AppColor.whiteColor,
                          textColor: AppColor.blackColor,
                          text: 'مسح',
                          onPressed: () => Navigator.pop(context)),
                    ],
                  )
                ],
              ),
            );
          });
        });
  }

  Future<dynamic> ShowRattingBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          // <-- SEE HERE
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              // height: 50.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 2.h,
                  ),
                  CustomText(
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      text: 'تصفية النتائج بالتقيم',
                      fontweight: FontWeight.bold,
                      fontSize: AppFonts.t3),
                  SizedBox(
                    height: 2.h,
                  ),
                  Column(
                    children: [
                      ListView.builder(
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              print(index + 1);
                              getSearchData(lastIndex,
                                  rate: (index + 1).toString());
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 4.h,
                                    child: ListView.builder(
                                        itemCount: index + 1,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return Image.asset(
                                            AppImages.starIc,
                                            width: 6.w,
                                            height: 6.w,
                                          );
                                        }),
                                  ),
                                  CustomText(
                                      text: ' (تقيم مقبول) ',
                                      fontSize: AppFonts.t3)
                                ],
                              ),
                            ),
                          );
                        },
                        shrinkWrap: true,
                        itemCount: 5,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                          width: 45.w,
                          height: 6.h,
                          radius: 1.w,
                          color: AppColor.primaryOpacityColor,
                          text: 'تطبيق',
                          onPressed: () => Navigator.pop(context)),
                      CustomButton(
                          radius: 1.w,
                          height: 6.h,
                          width: 45.w,
                          color: AppColor.whiteColor,
                          textColor: AppColor.blackColor,
                          text: 'مسح',
                          onPressed: () => Navigator.pop(context)),
                    ],
                  )
                ],
              ),
            );
          });
        });
  }

  String? lastCheckIdItem;
}

Widget customStarRating() {
  return InkWell(
    onTap: () {},
    child: Row(
      children: [
        SizedBox(
          height: 5.h,
          child: ListView.builder(
              itemCount: 1,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Image.asset(
                  AppImages.starIc,
                  width: 6.w,
                  height: 6.w,
                );
              }),
        ),
        CustomText(text: ' (تقيم مقبول) ', fontSize: AppFonts.t3)
      ],
    ),
  );
}

Widget mapDeatilsWidge({address, title, priceDay, price, code}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 2.h),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(2.w),
      color: AppColor.whiteColor,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade400,
          offset: const Offset(0, 2.0),
          blurRadius: 6.0,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            text: title,
            fontweight: FontWeight.bold,
            overflow: TextOverflow.ellipsis),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                    text: priceDay,
                    overflow: TextOverflow.ellipsis,
                    fontSize: AppFonts.t4_2),
                CustomText(
                    padding: EdgeInsets.symmetric(vertical: 1.h),
                    text: "الاجمالي : " + price,
                    overflow: TextOverflow.ellipsis,
                    fontSize: AppFonts.t4_2),
              ],
            ),
            SizedBox(
              width: 5.w,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 2.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      text: address,
                      overflow: TextOverflow.ellipsis,
                      fontSize: AppFonts.t4_2),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
