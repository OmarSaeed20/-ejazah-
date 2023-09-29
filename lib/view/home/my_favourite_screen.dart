import 'package:cached_network_image/cached_network_image.dart';
import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/customAppBar.dart';
import 'package:ejazah/Widgets/custom_text.dart';
import 'package:ejazah/Widgets/myNavigate.dart';
import 'package:ejazah/controller/favourite_controller/favourite_controller.dart';
import 'package:ejazah/model/get_favourite_model.dart';
import 'package:ejazah/utils/enums.dart';
import 'package:ejazah/view/search_details/details_screen.dart';
import 'package:ejazah/view/search_details/widgets/searchResultWidget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../model/search_models/search_result_model.dart';

class MyFavouriteScreen extends StatefulWidget {
  const MyFavouriteScreen({super.key});

  @override
  State<MyFavouriteScreen> createState() => _MyFavouriteScreenState();
}

class _MyFavouriteScreenState extends State<MyFavouriteScreen> {
  RequestState requestState = RequestState.waiting;

  GetFavouriteModel? getFavouriteModel = FavouriteController.getFavouriteModel;

  Future<void> getData() async {
    setState(() => requestState = RequestState.loading);
    final res = await FavouriteController.getFav();
    if (res) {
      getFavouriteModel = FavouriteController.getFavouriteModel;
      setState(() => requestState = RequestState.success);
    } else {
      setState(() => requestState = RequestState.error);
    }
    await Future<void>.delayed(Duration(seconds: 3));
    getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  Stream<GetFavouriteModel?> generateNumbers = (() async* {
    await Future<void>.delayed(Duration(seconds: 3));
    yield FavouriteController.getFavouriteModel;
  })();

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: size.height * 0.05,
            bottom: size.height * 0.04,
            left: size.width * 0.02,
            right: size.width * 0.02,
          ),
          physics: BouncingScrollPhysics(),
          child: StreamBuilder<GetFavouriteModel?>(
              stream: generateNumbers,
              builder: (context, snapshot) {
                return Builder(builder: (context) {
                  if (getFavouriteModel == null &&
                      requestState == RequestState.loading)
                    return Center(child: CircularProgressIndicator());
                  if (getFavouriteModel == null &&
                      requestState == RequestState.error)
                    return Center(
                        child: CustomText(
                            text: 'تأكد من اتصالك بالانترنت',
                            color: Colors.red));
                  if (getFavouriteModel == null ||
                      getFavouriteModel!.data!.favourites!.isEmpty)
                    return Column(
                      children: [
                        CustomAppBar(pageTitle: 'المفضلة'),
                        SizedBox(
                          height: 40.h,
                        ),
                        Center(
                            child: Text(
                          'المفضلة فارغة',
                          style: TextStyle(
                              color: AppColor.orangeColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )),
                      ],
                    );
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomAppBar(pageTitle: 'المفضلة'),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: size.height * 0.19,
                          child: ListView.builder(
                            itemCount:
                                getFavouriteModel!.data!.categories!.length,
                            // shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final item =
                                  getFavouriteModel!.data!.categories![index];
                              return Container(
                                height: size.height * 0.19,
                                width: size.width * 0.4,
                                child: getCategoryContainer(
                                    item.name!, item.image!, item.id!),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Container(
                            color: Color.fromARGB(255, 245, 245, 245),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  ...getFavouriteModel!.data!.favourites!
                                      .map((e) {
                                    return SearchResultWidget(
                                      onTapFav: () async {
                                        setState(
                                            () => e.favourite = !e.favourite!);
                                        final res =
                                            await FavouriteController.postFav(
                                                '${e.id}');
                                        if (!res)
                                          setState(() =>
                                              e.favourite = !e.favourite!);
                                      },
                                      onTap: () {
                                        Ads ads = Ads();
                                        ads = Ads.fromJson(e.toJson());
                                        // ads.favourite = false;
                                        // ads.isMine = false;
                                        myNavigate(
                                            screen: DetailsScreen(ads: ads),
                                            context: context);
                                      },
                                      priceDay: "${e.price} رس / ليلة",
                                      address: e.address,
                                      code: e.offer,
                                      title: e.name,
                                      image: e.images![0].image,
                                      totalPrice: '${e.totalPrice} رس ',
                                      isFavourite: e.favourite,
                                    );
                                  }).toList(),
                                ],
                              ),
                            )),
                      ]);
                });
              }),
        ),
      ),
    );
  }

  Widget getCategoryContainer(String categoryName, String img, String id) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: size.height * .18,
        width: size.width * .29,
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
              height: size.height * 0.13,
              width: size.width * 0.25,
              child: CachedNetworkImage(
                imageUrl: img,
              ),
            ),
            Text(
              categoryName,
              style: TextStyle(
                  fontSize: AppFonts.t4_2, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
