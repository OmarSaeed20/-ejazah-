import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../model/home/get_home_model.dart';

class CustomSlider extends StatefulWidget {
  final List<Sliders> slider;
  CustomSlider({Key? key, required this.slider}) : super(key: key);

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  @override
  Widget build(BuildContext context) {
    CarouselController _controller = CarouselController();
    List<Widget> imageSliders = widget.slider
        .map((item) => Container(
              child: Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      children: <Widget>[
                        CachedNetworkImage(
                          imageUrl: item.image!,
                          fit: BoxFit.cover,
                          width: 1000.0,
                        ),
                        Positioned(
                          top: 15.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.title!,
                                      style: TextStyle(
                                        color: Color.fromRGBO(
                                          234,
                                          145,
                                          78,
                                          1,
                                        ),
                                        fontSize: AppFonts.t2,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Text(
                                      item.desc!,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: AppFonts.t5,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    // Container(
                                    //   width: 30.w,
                                    //   height: 4.h,
                                    //   alignment: Alignment.center,
                                    //   child: ElevatedButton(
                                    //       style: ElevatedButton.styleFrom(
                                    //         backgroundColor: AppColor
                                    //             .buttonColor
                                    //             .withOpacity(.4),
                                    //       ),
                                    //       onPressed: () {
                                    //         print(item.id);
                                    //         // return;
                                    //         // myNavigate(
                                    //         //     screen: SearchResultScreen(
                                    //         //       categoryId: item.id!,
                                    //         //       selectedIndex: 0,
                                    //         //     ),
                                    //         //     context: context);
                                    //       },
                                    //       child: Padding(
                                    //         padding:
                                    //             const EdgeInsets.only(top: 4.0),
                                    //         child: Text(
                                    //           'عرض المزيد',
                                    //           textAlign: TextAlign.center,
                                    //           style: TextStyle(
                                    //               color: Colors.white,
                                    //               fontSize: AppFonts.t5,
                                    //               fontWeight: FontWeight.bold),
                                    //         ),
                                    //       )),
                                    // ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 70),
                                      child: Container(
                                        alignment: Alignment.topLeft,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.black12),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SvgPicture.asset(
                                            'assets/svg/Group 36771.svg',
                                            width: 75,
                                            height: 75,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ))
        .toList();
    return CarouselSlider(
      items: imageSliders,
      options: CarouselOptions(
        enlargeCenterPage: true,
        aspectRatio: 18 / 8,
        viewportFraction: .85,
        autoPlay: true,
      ),
      carouselController: _controller,
    );
  }
}
