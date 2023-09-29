// ignore_for_file: must_be_immutable
import 'dart:io';
import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/app_svg.dart';
import 'package:ejazah/Widgets/customAppBar.dart';
import 'package:ejazah/Widgets/custom_text.dart';
import 'package:ejazah/Widgets/myNavigate.dart';
import 'package:ejazah/components/components.dart';
import 'package:ejazah/components/extentions.dart';
import 'package:ejazah/components/map_screen.dart';
import 'package:ejazah/utils/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import '../../../controller/add_information_tavel_groups_controller.dart';
import '../../../controller/add_service_controller/add_ads_controller.dart';
import '../../../model/marketing_type_model.dart';
import 'add_condetions_screen.dart';

class AddMarketingAndResturantScreen extends StatefulWidget {
  AddMarketingAndResturantScreen({super.key});

  @override
  State<AddMarketingAndResturantScreen> createState() =>
      _AddMarketingAndResturantScreenState();
}

class _AddMarketingAndResturantScreenState
    extends State<AddMarketingAndResturantScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController moneyController = TextEditingController();

  final ImagePicker picker = ImagePicker();

  List<XFile>? images;

  RequestState requestState = RequestState.waiting;

  MarketingTypeModel? marketingTypeModel;
  String? typeId = '2';
  int selection = 0;

  getData() async {
    requestState = RequestState.loading;
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
    AddAdsController.lat = '';
    AddAdsController.long = '';

    getData();
    super.initState();
  }

  List<XFile> addImages = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: AppColor.backGroundColor,
        body: SafeArea(
          child: Builder(builder: (context) {
            if (requestState == RequestState.loading)
              return Center(child: CircularProgressIndicator());
            if (requestState == RequestState.error)
              return Center(child: Text('تأكد من اتصالك بالإنترنت'));
            return SingleChildScrollView(
                padding: EdgeInsets.only(
                  top: size.height * 0.025,
                  bottom: size.height * 0.02,
                  left: size.height * 0.02,
                  right: size.height * 0.02,
                ),
                child: Column(children: [
                  CustomAppBar(pageTitle: 'التسوق والمطاعم'),
                  SizedBox(
                    height: 3.h,
                  ),
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
                                print(typeId);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
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
                    height: 5.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () async {
                              images = await picker.pickMultiImage();
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.all(25),
                              width: 25.w,
                              height: 12.h,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    style: BorderStyle.solid,
                                    color: AppColor.orangeColor),
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
                                  'يمكنك إضافة صور بحد أقصي 4 صورة في الإعلان الواحد',
                              maxLines: 2,
                              fontSize: AppFonts.t3,
                            ),
                          ))
                        ],
                      ),
                      if (images != null && images!.isNotEmpty)
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
                                    final file = images![index];
                                    return Stack(
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
                                                images?.removeAt(index);
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                  separatorBuilder: (context, index) => Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 1.w)),
                                  itemCount: images!.length,
                                  shrinkWrap: true,
                                ),
                              ),
                              IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () async {
                                  addImages = await picker.pickMultiImage();
                                  images!.addAll(addImages);
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
                      SizedBox(
                        height: 3.h,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: CustomText(
                            text: 'برجاء ادخال اسم المكان',
                            fontSize: AppFonts.t3,
                            fontweight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      customContainerTextFormField(
                        TFF: customTextFormField(
                          context: context,
                          controller: nameController,
                          hintText: 'اسم المكان',
                          keyboardType: TextInputType.text,
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Is Required".tr),
                          ]),
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: CustomText(
                        text: 'اضغط هنا لاختيار الموقع ',
                        fontSize: AppFonts.t3,
                        fontweight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Stack(
                    children: [
                      customContainerTextFormField(
                        TFF: customTextFormField(
                          readOnly: true,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  insetPadding: EdgeInsets.zero,
                                  contentPadding: EdgeInsets.zero,
                                  backgroundColor: Colors.white,
                                  elevation: 4,
                                  shadowColor: Colors.grey,
                                  content: Center(
                                      child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      MapScreen(height: size.height * .85),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        height: 50,
                                        width: size.width * .8,
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                                foregroundColor:
                                                    MaterialStatePropertyAll(
                                                        Colors.white),
                                                backgroundColor:
                                                    MaterialStatePropertyAll(
                                                        AppColor.buttonColor)),
                                            onPressed: () {
                                              setState(() {});
                                              Navigator.pop(context);
                                            },
                                            child: Text('حسنا')),
                                      )
                                    ],
                                  )),
                                );
                              },
                            );
                          },
                          context: context,
                          hintText: AddAdsController.lat == ''
                              ? 'قم بتحديد الموقع'
                              : 'تم تحديد الموقع',
                          keyboardType: TextInputType.phone,
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Is Required".tr),
                          ]),
                          onChanged: (value) {},
                          suffixIcon: Icons.map_sharp,
                          controller: null,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: CustomText(
                        text: 'برجاء كتابة وصف الاعلان',
                        fontSize: AppFonts.t3,
                        fontweight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  customContainerTextFormField(
                    TFF: customTextFormField(
                      context: context,
                      maxLines: 3,
                      controller: desController,
                      hintText: 'يرجي كتابة وصف واضح',
                      keyboardType: TextInputType.text,
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Is Required".tr),
                      ]),
                      onChanged: (value) {},
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(vertical: 2.h),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       CustomText(text: 'برجاء تحديد سعر الفعالية'),
                  //       CustomTextFormField(
                  //           controller: moneyController,
                  //           contentPadding: EdgeInsets.only(right: 10, top: 5),
                  //           onChangedFun: () {},
                  //           hintText: '1000 ريال',
                  //           width: 45.w,
                  //           radius: 2.w,
                  //           keyBoardType: TextInputType.phone)
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    width: size.width,
                    height: 7.h,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.buttonColor),
                        onPressed: () async {
                          if (selection == -1) {
                            toastShow(text: 'برجاء اختيار نوع الفعالية');
                            return;
                          }
                          if (images == null || images!.isEmpty) {
                            toastShow(
                                text: 'برجاء اختيار صورة واحدة على الأقل');
                            return;
                          }
                          if (images!.length > 4) {
                            toastShow(
                                text: 'برجاء اختيار الصور بحد أقصى 4 صور');
                            return;
                          }
                          if (nameController.text.isEmpty) {
                            toastShow(text: 'برجاء كتابة الاسم بطريقة صحيحة');
                            return;
                          }
                          if (AddAdsController.lat.isEmpty) {
                            toastShow(text: 'برجاء تحديد الموقع ');
                            return;
                          }

                          if (desController.text.length < 10) {
                            toastShow(text: 'يتكون الوصف من 10 احرف علي الأقل');
                            return;
                          }
                          // try {
                          //   if (int.parse(moneyController.text) > 99999) {
                          //     toastShow(text: 'برجاء كتابة السعر بطريقة صحيحة');
                          //     return;
                          //   }
                          // } catch (e) {
                          //   toastShow(text: 'برجاء كتابة السعر بطريقة صحيحة');
                          //   return;
                          // }
                          AddInformationTravelGroupsController.travel_type_id =
                              typeId;
                          AddInformationTravelGroupsController.images = images;
                          AddInformationTravelGroupsController.name =
                              nameController.text;
                          AddInformationTravelGroupsController.desc =
                              desController.text;
                          // AddInformationTravelGroupsController.price =
                          //     moneyController.text;
                          AddInformationTravelGroupsController.lat =
                              AddAdsController.lat;
                          AddInformationTravelGroupsController.long =
                              AddAdsController.long;
                          myNavigate(
                              screen: AddCondetionsScreen(
                                isAddTravel: true,
                              ),
                              context: context);

                          // myNavigate(
                          //     screen: ChooseHomeTypeScreen(), context: context);
                          // myNavigate(screen: AcceptPetsScreen(), context: context);
                        },
                        child: Text(
                          'التالي',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: AppFonts.t2,
                              fontWeight: FontWeight.bold),
                        )),
                  )
                ]));
          }),
        ));
  }

  Widget customContainerTextFormField({
    required Widget TFF,
    Color? color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      alignment: Alignment.center,
      width: context.getWidth,
      decoration: BoxDecoration(
        color: color ?? AppColor.backGroundColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: color ?? Colors.grey.shade300,
            offset: const Offset(0, 1.0),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: TFF,
    );
  }
}
