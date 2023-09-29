import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/myNavigate.dart';
import 'package:ejazah/components/components.dart';
import 'package:ejazah/view/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../controller/rate_owner_controller.dart';
import '../../utils/enums.dart';

class RateOwnerScreen extends StatefulWidget {
  final String ads_id;
  const RateOwnerScreen({super.key, required this.ads_id});

  @override
  State<RateOwnerScreen> createState() => _RateOwnerScreenState();
}

class _RateOwnerScreenState extends State<RateOwnerScreen> {
  String rating = '3';
  String comment = '';
  TextEditingController commentController = TextEditingController();
  RequestState requestState = RequestState.waiting;

  postComment() async {
    comment = commentController.text;
    if (requestState == RequestState.loading) return;
    requestState = RequestState.loading;
    setState(() {});
    final res = await RateOwnerController.addComment(
        ads_id: widget.ads_id, commenet: comment, rate: rating);
    if (res) {
      requestState = RequestState.success;
      myNavigate(screen: HomeScreen(), context: context);
    } else {
      requestState = RequestState.error;
    }
    Future<void>.delayed(Duration(seconds: 3)).then((value) {
      // getData();
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: AppColor.backGroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              top: size.height * 0.11,
              bottom: size.height * 0.02,
              left: size.height * 0.02,
              right: size.height * 0.02,
            ),
            child: Column(children: [
              SvgPicture.asset(
                'assets/svg/Online Review-cuate.svg',
                width: 180,
                height: 200,
              ),
              SizedBox(
                height: 6.h,
              ),
              Text(
                'برحاء قم بتقيم صاحب السكن, هذا يساعدنا علي التحسين \n من تجربة المستخدم داخل التطبيق',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: AppFonts.t3,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              RatingBar.builder(
                initialRating: 3,
                itemPadding: EdgeInsets.all(5),
                allowHalfRating: true,
                minRating: 1,
                itemSize: 12.w,
                unratedColor: Colors.black,
                itemBuilder: (context, _) => SvgPicture.asset(
                  'assets/svg/star.svg',
                  width: 50,
                  height: 50,
                ),
                onRatingUpdate: (rating) {
                  this.rating = rating.toString();
                  print(rating);
                },
              ),
              SizedBox(
                height: 4.h,
              ),
              Container(
                padding: EdgeInsets.only(right: 10),
                alignment: Alignment.topRight,
                width: size.width,
                height: 18.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(210, 211, 212, 0.392)),
                child: TextFormField(
                  controller: commentController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'قم بوصف التجربه (إجباري)',
                    hintStyle: TextStyle(
                      fontSize: AppFonts.t3,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onChanged: (value) {},
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 150,
                    height: 7.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.buttonColor),
                        onPressed: () {
                          if (commentController.text.isEmpty) {
                            toastShow(
                                text: 'قم بوصف التجربة من فضلك',
                                state: ToastStates.warning);
                            return;
                          }
                          postComment();
                        },
                        child: Builder(builder: (context) {
                          if (requestState == RequestState.loading)
                            return Center(
                                child: CircularProgressIndicator(
                              color: Colors.white,
                            ));
                          return Text(
                            'قيم',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: AppFonts.t3,
                                fontWeight: FontWeight.bold),
                          );
                        })),
                  ),
                  Container(
                    width: 150,
                    height: 7.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color.fromRGBO(234, 145, 78, 1),
                        border: Border.all(
                          color: Color.fromRGBO(234, 145, 78, 1),
                        )),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white),
                        onPressed: () {
                          myNavigate(screen: HomeScreen(), context: context);
                        },
                        child: Text(
                          'ليس الان',
                          style: TextStyle(
                              color: Color.fromRGBO(234, 145, 78, 1),
                              fontSize: AppFonts.t3,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              ),
            ]),
          ),
        ));
  }
}
