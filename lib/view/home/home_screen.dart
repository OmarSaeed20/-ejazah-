// ignore_for_file: deprecated_member_use
import 'dart:developer';
import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/customBottomNavBar.dart';
import 'package:ejazah/Widgets/custom_slider.dart';
import 'package:ejazah/Widgets/myNavigate.dart';
import 'package:ejazah/components/components.dart';
import 'package:ejazah/controller/auth/get_countries_controller.dart';
import 'package:ejazah/controller/auth/user_controller.dart';
import 'package:ejazah/view/auth/choose_country_screen.dart';
import 'package:ejazah/view/home/CitiesTrips/rehala_cities_trips_screen.dart';
import 'package:ejazah/view/home/contact_us_screen.dart';
import 'package:ejazah/view/home/driver_Screens/choose_address_driver_screen.dart';
import 'package:ejazah/view/home/driver_Screens/order_driver.dart';
import 'package:ejazah/view/home/notifications_screen.dart';
import 'package:ejazah/view/search_details/details_screen.dart';
import 'package:ejazah/view/search_details/search_result_screen.dart';
import 'package:ejazah/widgets/app_images.dart';
import 'package:ejazah/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../controller/auth/get_streets_controller.dart';
import '../../controller/home_controller/home_controller.dart';
import '../../database/local/cache_helper.dart';
import '../../model/add_service_models/get_cities_model.dart';
import '../../model/add_service_models/get_streets_model.dart';
import '../../model/home/get_home_model.dart';
import '../../model/register_models/get_countries_model.dart';
import '../../model/search_models/search_result_model.dart';
import '../../utils/enums.dart';
import 'marketing_and_resturant_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String HomeRoute = 'home_screen';

  const HomeScreen({super.key, this.isChanged = false});

  final bool isChanged;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RequestState requestState = RequestState.waiting;
  GetHomeModel? getHomeModel;
  GetCountriesModel? getCountriesModel;
  CategoryModel? getAdsByCityModel;
  GetStreetsModel? getStreetsModel;
  GetCitiesModel? getCitiesModel;

  Future<void> getData() async {
    requestState = RequestState.loading;
    setState(() {});
    final homeRes = await HomeController.getHomeData();
    final countryRes = await GetCountries.getCountries();
    final adsRes = await HomeController.getAdsByCityData();
    final streetsRes = await GetStreetsController.getStreets();
    if (homeRes && adsRes && countryRes && streetsRes) {
      getHomeModel = HomeController.getHomeModel;
      getCountriesModel = GetCountries.getCountriesModel;
      getAdsByCityModel = HomeController.getAdsByCityModel;
      getStreetsModel = GetStreetsController.getStreetsModel;
      requestState = RequestState.success;
    } else {
      requestState = RequestState.error;
      Future<void>.delayed(Duration(seconds: 3)).then((value) {
        getData();
      });
    }

    setState(() {});
  }

  Future<void> getAdsCity() async {
    requestState = RequestState.loading;
    setState(() {});
    final adsRes = await HomeController.getAdsByCityData();
    if (adsRes) {
      getAdsByCityModel = HomeController.getAdsByCityModel;
      setState(() {});
    } else {
      requestState = RequestState.error;
      setState(() {});
    }
  }

  int selected = 0;

  @override
  void initState() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    if (widget.isChanged == true) {
      getData();
    }
    if (HomeController.getHomeModel != null &&
        GetCountries.getCountriesModel != null &&
        GetStreetsController.getStreetsModel != null) {
      getHomeModel = HomeController.getHomeModel;
      getCountriesModel = GetCountries.getCountriesModel;
      getAdsByCityModel = HomeController.getAdsByCityModel;
      getStreetsModel = GetStreetsController.getStreetsModel;
      return;
    } else {
      getData();
    }
    super.initState();
  }

  String? value = CurrentUser.cityId;

  final TextEditingController searchController = TextEditingController();

  List<String> selectedCountList = [];

  DateTime? backbuttonpressedTime;

  Future<bool> onWillPop() async {
    DateTime currentTime = DateTime.now();
    bool backButton = backbuttonpressedTime == null ||
        currentTime.difference(backbuttonpressedTime!) > Duration(seconds: 3);

    if (backButton) {
      backbuttonpressedTime = currentTime;
      Fluttertoast.showToast(
          msg: "Double Click to exit app".tr,
          backgroundColor: Colors.black,
          textColor: Colors.white);
      return false;
    }
    if (Platform.isAndroid) {
      SystemNavigator.pop();
      return true;
    } else if (Platform.isIOS) {
      exit(0);
    } else {
      return false;
    }
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: AppColor.backGroundColor,
        bottomNavigationBar: CustomBottomNavBar(
          navigationTabsIndex: 0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () =>
              myNavigate(screen: ContactUsScreen(), context: context),
          backgroundColor: AppColor.backGroundColor,
          child: Image.asset(
            AppImages.support,
            width: 3.80.h,
            height: 3.80.h,
            color: AppColor.orangeColor,
          ),
        ),
        body: SafeArea(
          child: Builder(builder: (context) {
            if (requestState == RequestState.loading)
              return Center(child: CircularProgressIndicator());
            if (requestState == RequestState.error &&
                requestState != RequestState.loading)
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'برجاء اعادة المحاولة لاحقا',
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
                requestState = RequestState.loading;
                getData();
                // await HomeController.getHomeData().then((value) {
                //   if (value) {
                //     homeModel = HomeController.getHomeModel;
                //     requestState = RequestState.success;
                //   } else {
                //     requestState = RequestState.error;
                //   }
                // });
                setState(() {});
              },
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.only(
                  top: size.height * 0.025,
                  bottom: size.height * 0.03,
                  left: size.height * 0.02,
                  right: size.height * 0.02,
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            InkWell(
                              borderRadius: BorderRadius.circular(2.w),
                              onTap: () => myNavigate(
                                  screen: ChooseCountryScreen(),
                                  context: context),
                              child: Container(
                                padding: EdgeInsets.all(1.5.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2.w),
                                  color: AppColor.whiteColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade300,
                                      offset: const Offset(0, 1.0),
                                      blurRadius: 3.0,
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.arrow_back,
                                  color: AppColor.grayColor,
                                  size: 5.w,
                                ),
                              ),
                            ),
                            SizedBox(width: 5.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'مرحبا بك  ${CurrentUser.name}',
                                  style: TextStyle(
                                      color: Color.fromRGBO(
                                        234,
                                        145,
                                        78,
                                        1,
                                      ),
                                      fontSize: AppFonts.t2,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Text(
                                  'وجهتك عندنا سكن ورحلات وتنقل',
                                  style: TextStyle(fontSize: AppFonts.t4_2),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: GestureDetector(
                                  onTap: () {
                                    myNavigate(
                                        screen: NotificationScreen(),
                                        context: context);
                                  },
                                  child: Badge(
                                    alignment: AlignmentDirectional.topStart,
                                    backgroundColor: HomeController.getHomeModel
                                                ?.data?.countNotification
                                                .toString() ==
                                            '0'
                                        ? Colors.transparent
                                        : Color(0xffE24255),
                                    label: HomeController.getHomeModel?.data
                                                ?.countNotification
                                                .toString() ==
                                            '0'
                                        ? null
                                        : Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Text(HomeController
                                                    .getHomeModel
                                                    ?.data
                                                    ?.countNotification
                                                    .toString() ??
                                                '0'),
                                          ),
                                    textStyle: TextStyle(fontSize: 10),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: SvgPicture.asset(
                                        'assets/svg/bell.svg',
                                        color: Colors.black87,
                                      ),
                                    ),
                                  )),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 1.5.h,
                      ),
                      if (getHomeModel!.data!.sliders != null)
                        Container(
                            child: CustomSlider(
                          slider: getHomeModel!.data!.sliders!,
                        )),
                      SizedBox(
                        height: 3.h,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        margin: EdgeInsets.all(4),
                        width: size.width,
                        height: 7.h,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 0.5),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: (getHomeModel!.data!.cities!.isNotEmpty)
                            ? DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: value,
                                  hint: Text(
                                    'اختر المدينة',
                                    style: TextStyle(
                                        fontSize: AppFonts.t3,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  isExpanded: true,
                                  items: getHomeModel!.data!.cities!.map(
                                    (e) {
                                      return DropdownMenuItem<String>(
                                        value: e.id.toString(),
                                        child: Text(e.title),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (value) {
                                    log(value.toString());
                                    CurrentUser.cityId = value;
                                    getData();
                                    CacheHelper.saveData(
                                      key: 'city_id',
                                      value: CurrentUser.cityId,
                                    ).then((value) {
                                      log('done saved');
                                    });
                                    // CurrentUser.countryId = value;
                                    setState(() => this.value = value);
                                  },
                                ),
                              )
                            : SizedBox.shrink(),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Container(
                        height: size.height * 0.215,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            ...getHomeModel!.data!.categories!.map((e) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 8),
                                child: getCategoryContainer(e),
                              );
                            })
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(getHomeModel!.data!.homeText!),
                      SizedBox(height: size.height * 0.02),
                      Text(getHomeModel!.data!.descText!),
                      SizedBox(height: size.height * 0.02),
                      Container(
                          child: CustomSlider(
                        slider: getHomeModel!.data!.adspace!,
                      )),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      if (HomeController.getAdsByCityModel != null)
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: HomeController
                              .getAdsByCityModel!.data!.ads!.length,
                          itemBuilder: (context, index) {
                            final Ads item = HomeController
                                .getAdsByCityModel!.data!.ads![index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  child: Text(
                                    'أحدث ${item.categoryName}',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: AppFonts.t4_2,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: GestureDetector(
                                    onTap: () async {
                                      final ads = item;

                                      if (item.categoryId == "7") {
                                        if (item.is_pay == "1") {
                                          return;
                                        }
                                        if (CurrentUser.id ==
                                            item.ads_user_id) {
                                          toastShow(
                                              text: "لا يمـكنك حجز الاعلان",
                                              state: ToastStates.warning);
                                          return;
                                        } else {
                                          myNavigate(
                                              screen: ChooseAddressDriverScreen(
                                                  ads: ads),
                                              context: context);
                                        }
                                      } else {
                                        final fav = await myNavigate(
                                            screen: DetailsScreen(ads: ads),
                                            context: context);
                                        item.favourite = fav;
                                        print(fav);
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade400,
                                              offset: const Offset(0, 2.0),
                                              blurRadius: 6.0,
                                            )
                                          ]),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      width: size.width,
                                      height: 18.5.h,
                                      child: Row(
                                        children: [
                                          Stack(
                                            children: [
                                              CachedNetworkImage(
                                                height: 30.h,
                                                width: 38.w,
                                                imageUrl:
                                                    item.images![0].image!,
                                                fit: BoxFit.cover,
                                              ),
                                              if (item.is_pay == '1')
                                                Container(
                                                  padding:
                                                      EdgeInsets.all(1.0.w),
                                                  color: Colors.red.shade600,
                                                  child: CustomText(
                                                    text: 'محـجوز',
                                                    color: AppColor.whiteColor,
                                                  ),
                                                ),
                                            ],
                                          ),
                                          SizedBox(width: 1.5.w),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 1.5.h,
                                                ),
                                                Text(
                                                  item.name == "null"
                                                      ? item.travel_name!
                                                      : item.name!,
                                                  style: TextStyle(
                                                    fontSize: AppFonts.t4_2,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(height: 1.5.h),
                                                /*  Text(
                                                  'التاريخ والوقت : ${item.date}',
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                    fontSize: AppFonts.t6,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.normal,
                                                  ),
                                                ), */
                                                Text(
                                                  '${item.desc}',
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                    fontSize: AppFonts.t4,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 1.5.h,
                                                ),
                                                if (item.categoryId != "7" &&
                                                    item.categoryId != "8")
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'المدينة : ${item.city}',
                                                        style: TextStyle(
                                                          fontSize: AppFonts.t6,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                      ),
                                                      SizedBox(width: 1.5.w),
                                                      if (item.street_name!
                                                          .isNotEmpty)
                                                        Text(
                                                          'الحي : ${item.street_name}',
                                                          style: TextStyle(
                                                            fontSize:
                                                                AppFonts.t6,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                if (item.categoryId == "6")
                                                  Text(
                                                    'عدد التذاكر المتبقية : ${item.ticket_count!.isEmpty ? "0" : item.ticket_count}',
                                                    style: TextStyle(
                                                      fontSize: AppFonts.t6,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                SizedBox(
                                                  height: 1.0.h,
                                                ),
                                                if (item.categoryId != "9")
                                                  Text(
                                                    'السعر : ${item.totalPrice} ',
                                                    style: TextStyle(
                                                      fontSize: AppFonts.t4_2,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                          physics: NeverScrollableScrollPhysics(),
                        ),
                    ]),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget getCategoryContainer(Categories category) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 1.5.w),
      width: size.width * .34,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          new BoxShadow(
            color: Colors.grey.shade400,
            offset: const Offset(0, 2.0),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: size.height * 0.10,
            width: size.width * 0.8,
            child: IconButton(
              icon: CachedNetworkImage(
                imageUrl: category.image!,
              ),
              onPressed: () {
                if (category.title == "تسوق و مطاعم") {
                  myNavigate(
                      screen: MarketingAndResturantScreen(), context: context);
                }
                if (category.title == "بيوت العطلات" ||
                    category.title == "سكن مشترك" ||
                    category.title == "فعاليات" ||
                    category.title == "مخيمات وشاليهات" ||
                    category.title == "مجموعات السفر") {
                  print(category.id);
                  String? title;
                  if (category.id == 6 || category.id == 8)
                    title = category.title;
                  myNavigate(
                      screen: SearchResultScreen(
                        selectedIndex: 0,
                        categoryId: int.parse("${category.id}"),
                        title: title,
                      ),
                      context: context);
                } else if (category.title == "مجموعات السفر") {
                  myNavigate(screen: RehalaCitiesScreen(), context: context);
                } else if (category.title == "مرشد سياحي") {
                  myNavigate(screen: OrderDeriverScreen(), context: context);
                }
              },
            ),
          ),
          Text(
            category.title!,
            style:
                TextStyle(fontSize: AppFonts.t4_2, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
