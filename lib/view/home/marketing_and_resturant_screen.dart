// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ejazah/Widgets/Custom_TextField.dart';
import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/custom_text.dart';
import 'package:ejazah/Widgets/myNavigate.dart';
import 'package:ejazah/view/search_details/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../Widgets/customAppBar.dart';
import '../../controller/add_information_tavel_groups_controller.dart';
import '../../controller/search_controller/category_result_controller.dart';
import '../../model/marketing_type_model.dart';
import '../../model/search_models/search_result_model.dart';
import '../../utils/enums.dart';

class MarketingAndResturantScreen extends StatefulWidget {
  const MarketingAndResturantScreen({super.key});

  @override
  State<MarketingAndResturantScreen> createState() =>
      _MarketingAndResturantScreenState();
}

class _MarketingAndResturantScreenState
    extends State<MarketingAndResturantScreen> {
  bool ischecked = false;

  final searchController = TextEditingController();

  CategoryModel? categorySearchModel;
  RequestState requestState = RequestState.waiting;
  RequestState requestState0 = RequestState.waiting;

  getSearchData({word, travel_type}) {
    setState(() => requestState0 = RequestState.loading);
    CategoryResultController.getFilterResult(
      '9',
      word: word,
      travel_type: travel_type,
    ).then((value) {
      if (value) {
        categorySearchModel = CategoryResultController.categorySearchModel;
        setState(() => requestState0 = RequestState.success);
      } else {
        setState(() => requestState0 = RequestState.error);
      }
    });
  }

  MarketingTypeModel? marketingTypeModel;
  int selection = 0;
  String typeId = '';

  getData() async {
    requestState = RequestState.loading;
    getSearchData();
    final res = await AddInformationTravelGroupsController.getMarketingType();
    if (res) {
      marketingTypeModel =
          AddInformationTravelGroupsController.marketingTypeModel;
      typeId = marketingTypeModel!.data!.markitingType!.first.id!.toString();
      requestState = RequestState.success;
    } else {
      requestState = RequestState.error;
    }
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.backGroundColor,
      body: SafeArea(
        child: Builder(builder: (context) {
          if (requestState == RequestState.loading)
            return Center(child: CircularProgressIndicator());
          return Container(
            margin: EdgeInsets.only(top: 2.5.h, left: 3.w, right: 3.w),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                CustomAppBar(
                  pageTitle: 'تسوق و مطاعم',
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                    controller: searchController,
                    width: MediaQuery.of(context).size.width * 9,
                    hintText: 'بحث',
                    prefixIcon: SvgPicture.asset(
                      'assets/svg/search-normal.svg',
                      fit: BoxFit.fitWidth,
                      color: Color.fromRGBO(234, 146, 78, 1),
                    ),
                    onChangedFun: () {
                      getSearchData(
                          word: searchController.text, travel_type: typeId);
                    }),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: SizedBox(
                    height: 5.h,
                    child: ListView.builder(
                      itemCount:
                          marketingTypeModel!.data!.markitingType!.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        final item =
                            marketingTypeModel!.data!.markitingType![index];
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          child: ChoiceChip(
                            selectedColor: AppColor.orangeColor,
                            backgroundColor: AppColor.whiteColor,
                            selected: selection == index,
                            label: CustomText(text: item.name),
                            onSelected: (selected) {
                              selection = index;
                              setState(() {
                                typeId = item.id.toString();
                              });
                              getSearchData(travel_type: typeId);
                              print(typeId);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Builder(
                  builder: (context) {
                    if (requestState0 == RequestState.loading)
                      return Center(child: CircularProgressIndicator());
                    if (categorySearchModel!.data!.ads!.isEmpty)
                      return Center(
                          child: Column(
                        children: [
                          SizedBox(
                            height: 30.h,
                          ),
                          Text('لا يوجد نتائج حاليا'),
                        ],
                      ));
                    return Container(
                      child: Expanded(
                        child: Stack(
                          children: [
                            ListView.separated(
                              physics: BouncingScrollPhysics(),
                              itemCount: categorySearchModel!.data!.ads!.length,
                              shrinkWrap: true,
                              itemBuilder: (ctx, index) {
                                final item =
                                    categorySearchModel!.data!.ads![index];
                                return CustomListWidget(
                                    ads: item,
                                    context: context,
                                    dataTime: '',
                                    title: '${item.name}',
                                    subtitle1: '${item.desc}',
                                    subtitle2: '',
                                    image: '${item.images!.first.image}',
                                    price: '');
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) => SizedBox(
                                height: 2.h,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}

Widget CustomListWidget(
    {context, image, title, subtitle1, subtitle2, dataTime, price, ads}) {
  return InkWell(
    onTap: () {
      myNavigate(screen: DetailsScreen(ads: ads), context: context);
    },
    child: Container(
      margin: EdgeInsets.only(bottom: 2.w),
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
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(2.w), topRight: Radius.circular(2.w)),
          child: CachedNetworkImage(
            imageUrl: image,
            width: 100.w,
            height: 13.h,
            fit: BoxFit.fill,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  text: title,
                  fontweight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis),
              SizedBox(
                width: 100.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomText(
                          padding: EdgeInsets.symmetric(vertical: 2.h),
                          text: subtitle1,
                          fontSize: AppFonts.t4,
                          fontweight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3),
                    ),
                    CustomText(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        text: subtitle2,
                        fontSize: AppFonts.t4,
                        fontweight: FontWeight.w500,
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              if (dataTime != '')
                CustomText(
                    text: "تاريخ الرحله : " + dataTime,
                    overflow: TextOverflow.ellipsis,
                    fontSize: AppFonts.t4_2),
              if (price != '')
                CustomText(
                    padding: EdgeInsets.symmetric(vertical: 1.h),
                    text: "سعر الرحله : " + price,
                    overflow: TextOverflow.ellipsis,
                    fontSize: AppFonts.t4_2),
            ],
          ),
        ),
      ]),
    ),
  );
}
