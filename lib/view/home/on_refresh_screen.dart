import 'package:cached_network_image/cached_network_image.dart';
import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/app_svg.dart';
import 'package:ejazah/Widgets/customBottomNavBar.dart';
import 'package:ejazah/Widgets/myNavigate.dart';
import 'package:ejazah/components/extentions.dart';
import 'package:ejazah/view/search_details/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../controller/get_orders_controller.dart';
import '../../model/get_order_model.dart';
import '../../model/search_models/search_result_model.dart';
import '../../utils/enums.dart';

class OnRefreshScreen extends StatefulWidget {
  const OnRefreshScreen({super.key});

  @override
  State<OnRefreshScreen> createState() => _OnRefreshScreenState();
}

class _OnRefreshScreenState extends State<OnRefreshScreen> {
  final TextEditingController searchController = TextEditingController();
  RequestState requestState = RequestState.waiting;

  OrdersModel? ordersModel;

  String? lastWord, lastDate;

  getSearch({String? word, String? date}) async {
    lastWord = word;
    lastDate = date;
    requestState = RequestState.loading;
    setState(() {});
    final res =
        await GetOrdersController.searchOrders(word: lastWord, date: lastDate);
    if (res) {
      ordersModel = GetOrdersController.ordersModel;
      requestState = RequestState.success;
    } else {
      requestState = RequestState.error;
    }
    Future<void>.delayed(Duration(seconds: 3)).then((value) {
      // getData();
    });

    setState(() {});
  }

  Future<void> getData() async {
    requestState = RequestState.loading;
    setState(() {});
    final res = await GetOrdersController.getOrders();
    if (res) {
      ordersModel = GetOrdersController.ordersModel;
      requestState = RequestState.success;
    } else {
      requestState = RequestState.error;
    }
    Future<void>.delayed(Duration(seconds: 3)).then((value) {});

    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      bottomNavigationBar: CustomBottomNavBar(
        navigationTabsIndex: 1,
      ),
      body: SafeArea(
        child: Builder(builder: (context) {
          if (requestState == RequestState.loading && ordersModel == null)
            return Center(child: CircularProgressIndicator());
          if (requestState == RequestState.error || ordersModel == null)
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'برجاء اعادة الحاولة لاحقا',
                    style: context.textTheme.titleLarge!
                        .copyWith(color: Colors.red),
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.amber[800])),
                      onPressed: () {
                        getData();
                      },
                      child: Text('اعادة المحاولة الأن'))
                ],
              ),
            );
          return RefreshIndicator(
            onRefresh: () async {
              searchController.clear();
              requestState = RequestState.loading;
              await GetOrdersController.getOrders().then((value) {
                if (value) {
                  ordersModel = GetOrdersController.ordersModel;
                  requestState = RequestState.success;
                } else {
                  requestState = RequestState.error;
                }
              });
              setState(() {});
            },
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                top: size.height * 0.025,
                bottom: size.height * 0.02,
                left: size.height * 0.015,
                right: size.height * 0.015,
              ),
              physics: BouncingScrollPhysics(),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'حجوزاتي',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: AppFonts.t1),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          width: size.width * 0.75,
                          height: 7.h,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 245, 245, 245),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              border: Border(),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade400,
                                  offset: const Offset(0, 2.0),
                                  blurRadius: 6.0,
                                )
                              ]),
                          child: TextFormField(
                            controller: searchController,
                            enableInteractiveSelection: true,
                            cursorHeight: 25,
                            cursorWidth: 2,
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(5),
                                child: SvgPicture.asset(
                                  'assets/svg/search-normal.svg',
                                  width: 5.w,
                                  height: 5.h,
                                ),
                              ),
                              hintText: 'ابحث عن المدينة',
                              hintStyle: TextStyle(color: Colors.black54),
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              getSearch(word: value.toString());
                            },
                          ),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Container(
                          width: 15.w,
                          height: 7.0.h,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              border: Border(),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade400,
                                  offset: const Offset(0, 2.0),
                                  blurRadius: 6.0,
                                )
                              ]),
                          child: IconButton(
                            icon: SvgPicture.asset(
                              AppSvgImages.calendarIc,
                              width: 40,
                              height: 40,
                            ),
                            onPressed: () async {
                              final date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                lastDate: DateTime(2100),
                              );
                              if (date == null) {
                                getSearch(date: '');
                                return;
                              }
                              // String birthday = DateFormat.yMd().format(date);
                              String birthday = date.year.toString() +
                                  '-' +
                                  date.month.toString() +
                                  '-' +
                                  date.day.toString();
                              print(birthday);
                              getSearch(date: birthday.toString());
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: ordersModel!.data!.favourites!.length,
                      itemBuilder: (context, index) {
                        Ads item = ordersModel!.data!.favourites![index];
                        return buildFavourites(item);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 1.h,
                        );
                      },
                    ),
                    if (ordersModel!.data!.categories!.isEmpty)
                      Container(
                          height: 50.h,
                          child: Center(
                              child: Text(
                            'لا توجد حجوزات في الوقت الحالي..',
                            style: context.textTheme.titleMedium!
                                .copyWith(color: Colors.amber[900]),
                          )))
                  ]),
            ),
          );
        }),
      ),
    );
  }

  Widget buildFavourites(Ads item) {
    return GestureDetector(
      onTap: () {
        myNavigate(
            screen: DetailsScreen(ads: item, isCheckOrder: true),
            context: context);
      },
      child: Card(
          elevation: 3,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white70, borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.name!,
                      style: TextStyle(
                          fontSize: AppFonts.t3, fontWeight: FontWeight.normal),
                    ),
                    Text(
                      item.payment_type!,
                      style: TextStyle(
                          fontSize: AppFonts.t3, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '${item.price}',
                              style: TextStyle(
                                  fontSize: AppFonts.t4_2,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 18.w,
                            ),
                            // Text(
                            //   'كود الوحده ( ${item.orderId} )',
                            //   style: TextStyle(
                            //       fontSize: AppFonts.t4_2, fontWeight: FontWeight.bold),
                            // ),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'الإجمالي ${item.totalPrice} ',
                              style: TextStyle(
                                  fontSize: AppFonts.t4_2,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 6.w,
                            ),
                            Text(
                              item.city ?? '',
                              style: TextStyle(
                                  fontSize: AppFonts.t4_2,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    CachedNetworkImage(
                      imageUrl: item.payment_icon ?? '',
                      width: 40,
                      height: 40,
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
