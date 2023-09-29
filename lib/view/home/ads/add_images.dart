import 'dart:io';
import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/app_svg.dart';
import 'package:ejazah/Widgets/customAppBar.dart';
import 'package:ejazah/Widgets/custom_text.dart';
import 'package:ejazah/Widgets/myNavigate.dart';
import 'package:ejazah/components/components.dart';
import 'package:ejazah/controller/add_service_controller/add_ads_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import 'accept_pets_screen.dart';

class AddImagesScreen extends StatefulWidget {
  const AddImagesScreen({super.key});

  @override
  State<AddImagesScreen> createState() => _AddImagesScreenState();
}

class _AddImagesScreenState extends State<AddImagesScreen> {
  final ImagePicker picker = ImagePicker();

  List<XFile> addImages = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: size.height * 0.025,
            bottom: size.height * 0.02,
            left: size.height * 0.02,
            right: size.height * 0.02,
          ),
          child: Column(
            children: [
              CustomAppBar(pageTitle: ''),
              SizedBox(
                height: 8.h,
              ),
              Container(
                alignment: Alignment.topRight,
                child: Text(
                  'من فضلك قم بإضافة بيانات صحيحة',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: AppFonts.t3,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 6.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () async {
                          await AddAdsController.getAdsImages();
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.all(25),
                          width: 25.w,
                          height: 12.h,
                          decoration: BoxDecoration(
                            border: Border.all(
                              style: BorderStyle.solid,
                              color: AppColor.orangeColor,
                            ),
                          ),
                          child: SvgPicture.asset(
                            AppSvgImages.takePice,
                            width: 5.h,
                            height: 5.h,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 22),
                          child: CustomText(
                            text:
                                'يمكنك إضافة صور بحد أقصي 12 صورة في الإعلان الواحد',
                            maxLines: 2,
                            fontSize: AppFonts.t3,
                          ),
                        ),
                      )
                    ],
                  ),
                  if (AddAdsController.images.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 100,
                            width: size.width - 100,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final file = AddAdsController.images[index];
                                return Stack(
                                  alignment: AlignmentDirectional.topStart,
                                  children: [
                                    Image.file(
                                      File(file.path),
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ),
                                    Container(
                                      width: 4.0.h,
                                      height: 4.0.h,
                                      decoration: BoxDecoration(
                                        color: Colors.red.shade800,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: IconButton(
                                        icon: Icon(
                                          CupertinoIcons.delete_solid,
                                          color: AppColor.whiteColor,
                                          size: 2.0.h,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            AddAdsController.images
                                                .removeAt(index);
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) => Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 1.w)),
                              itemCount: AddAdsController.images.length,
                              shrinkWrap: true,
                            ),
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () async {
                              addImages = await picker.pickMultiImage();
                              AddAdsController.images.addAll(addImages);
                              addImages.clear();
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.add_circle_outlined,
                              color: AppColor.orangeColor,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              SizedBox(height: 8.h),
              Container(
                width: size.width,
                height: 6.5.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.buttonColor),
                  onPressed: () {
                    if (AddAdsController.images.isEmpty) {
                      toastShow(text: 'برجاء إضافة صورة واحدة على الأقل');
                      return;
                    }
                    myNavigate(screen: AcceptPetsScreen(), context: context);
                  },
                  child: Text(
                    'التالي',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: AppFonts.t2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
