import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/app_images.dart';
import 'package:ejazah/Widgets/customAppBar.dart';
import 'package:ejazah/Widgets/customBtn.dart';
import 'package:ejazah/Widgets/custom_text.dart';
import 'package:ejazah/components/components.dart';
import 'package:ejazah/controller/auth/user_controller.dart';
import 'package:ejazah/view/home/driver_Screens/reviewAndSrearchScreen.dart';
import 'package:ejazah/widgets/myNavigate.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/tour_guide_controller.dart';
import '../../../model/search_models/search_result_model.dart';
import '../../../utils/enums.dart';

class DriverResultScreen extends StatefulWidget {
  const DriverResultScreen({
    super.key,
    required this.hours_number,
    required this.city_id,
    required this.street_id,
    required this.address,
    required this.lat,
    required this.lng,
  });
  final String hours_number;
  final String city_id;
  final String street_id;
  final String address;
  final String lat;
  final String lng;
  @override
  State<DriverResultScreen> createState() => _DriverResultScreenState();
}

class _DriverResultScreenState extends State<DriverResultScreen> {
  RequestState requestState = RequestState.waiting;

  int currentSelection = 0;
  CategoryModel? categorySearchModel;
  getData() {
    requestState = RequestState.loading;
    TourGuideController.tourGuide().then((value) {
      if (value) {
        categorySearchModel = TourGuideController.categorySearchModel;
        requestState = RequestState.success;
      } else {
        requestState = RequestState.error;
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log("hours_number ---> ${widget.hours_number}");
    log("city_id ---> ${widget.city_id}");
    log("street_id ---> ${widget.street_id}");
    log("address ---> ${widget.address}");
    log("lat ---> ${widget.lat}");
    log("lng ---> ${widget.lng}");

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: size.height * 0.025,
            left: size.width * 0.020,
            right: size.width * 0.020,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomAppBar(pageTitle: 'حجز سائق'),
                SizedBox(height: 5.h),
                Container(
                  alignment: Alignment.centerRight,
                  child: CustomText(
                    text: 'المرشدين المتاحين',
                    padding: EdgeInsets.only(bottom: 2.w),
                    fontSize: AppFonts.t2,
                    fontweight: FontWeight.bold,
                    color: AppColor.blackColor,
                  ),
                ),
                SizedBox(height: 1.h),
                Builder(
                  builder: (context) {
                    if (requestState == RequestState.loading)
                      return Center(child: CircularProgressIndicator());
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: categorySearchModel!.data!.ads!.length,
                      itemBuilder: (ctx, index) {
                        final item = categorySearchModel!.data!.ads![index];
                        return CustomDeriverWidget(
                          onTap: () {
                            log("==============>  ${CurrentUser.id}");
                            log("==============>  ${categorySearchModel!.data!.ads![index].ads_user_id}");

                            if (CurrentUser.id ==
                                categorySearchModel!
                                    .data!.ads![index].ads_user_id) {
                              toastShow(
                                  text: "لا يمـكنك حجز الاعلان",
                                  state: ToastStates.warning);
                              return;
                            } else {
                              setState(() {
                                categorySearchModel!.data!
                                    .ads![currentSelection].isSelected = false;
                                currentSelection = index;
                                item.isSelected = true;
                              });
                            }
                          },
                          isSelected: item.isSelected,
                          capacity: item.passengers,
                          price: item.price.toString(),
                          carName: '${item.name}  ${item.moodle}',
                          description: item.desc,
                          image: item.images != null && item.images!.isNotEmpty
                              ? item.images!.first.image
                              : Image.asset(AppImages.houseIc),
                          rating: item.rate,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
        height: 15.h,
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomButton(
              height: 6.5.h,
              text: 'التالي',
              color: AppColor.buttonColor,
              onPressed: () {
                final ads = categorySearchModel!.data!.ads![currentSelection];
                myNavigate(
                  screen: ReviewAndSearchScreen(
                    ads: ads,
                    hours_number: widget.hours_number,
                    city_id: widget.city_id,
                    street_id: widget.street_id,
                    address: widget.address,
                    lat: widget.lat,
                    lng: widget.lng,
                  ),
                  context: context,
                );
              },
              radius: 2.w,
            )
          ],
        ),
      ),
    );
  }
}

Widget CustomDevider({width}) {
  return Container(
    width: width ?? 13.w,
    margin: EdgeInsets.symmetric(vertical: 2.h),
    padding: EdgeInsets.all(.5.w),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.w), color: AppColor.secondColor),
  );
}

Widget CustomDeriverWidget(
    {carName,
    onTap,
    image,
    isSelected,
    rating,
    description,
    capacity,
    price,
    curr}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.only(bottom: 2.w),
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.w),
        color: AppColor.whiteColor,
        border: Border.all(
            color:
                isSelected == true ? AppColor.orangeColor : Colors.transparent),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            offset: const Offset(0, 3.0),
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Row(
        children: [
          if (image is! Image)
            CachedNetworkImage(
              imageUrl: image,
              width: 26.w,
              height: 20.w,
            ),
          SizedBox(
            width: 2.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                  padding: EdgeInsets.symmetric(vertical: 2.w),
                  text: carName!,
                  fontweight: FontWeight.bold,
                  fontSize: AppFonts.t1,
                  overflow: TextOverflow.ellipsis),
              Row(
                children: [
                  Image.asset(
                    AppImages.starIc,
                    width: 4.w,
                  ),
                  CustomText(
                      text: '($rating)',
                      color: AppColor.orangeColor,
                      fontSize: AppFonts.t4_2)
                ],
              ),
              SizedBox(
                width: 60.w,
                child: CustomText(
                    padding: EdgeInsets.symmetric(vertical: 2.w),
                    text: description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    fontSize: AppFonts.t3),
              ),
              CustomText(
                  padding: EdgeInsets.symmetric(vertical: 2.w),
                  text: 'عدد الركاب  ' + capacity,
                  fontSize: AppFonts.t3),
              CustomText(
                  padding: EdgeInsets.symmetric(vertical: 2.w),
                  text: 'سعر الساعة  ' +
                      price +
                      ' ${CurrentUser.currency.toString()}',
                  fontSize: AppFonts.t3)
            ],
          )
        ],
      ),
    ),
  );
}
