// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:ejazah/Widgets/Custom_TextField.dart';
import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/app_svg.dart';
import 'package:ejazah/Widgets/customAppBar.dart';
import 'package:ejazah/Widgets/custom_text.dart';
import 'package:ejazah/Widgets/myNavigate.dart';
import 'package:ejazah/components/components.dart';
import 'package:ejazah/components/extentions.dart';
import 'package:ejazah/utils/enums.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import '../../../controller/add_information_tavel_groups_controller.dart';
import '../../../model/gideType_model.dart';
import '../../../model/languages_model.dart';
import 'add_condetions_screen.dart';

class AddTourGuideAdsScreen extends StatefulWidget {
  AddTourGuideAdsScreen({super.key});

  @override
  State<AddTourGuideAdsScreen> createState() => _AddTourGuideAdsScreenState();
}

class _AddTourGuideAdsScreenState extends State<AddTourGuideAdsScreen> {
  final TextEditingController fromController = TextEditingController(),
      toController = TextEditingController();
  late DateTime to;
  late DateTime from;
  int difference = 0;
  TextEditingController iBANController = TextEditingController();
  TextEditingController license_number = TextEditingController();
  TextEditingController carNameController = TextEditingController();
  TextEditingController carModelController = TextEditingController();
  TextEditingController maximumPassengersController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController langController = TextEditingController();

  final ImagePicker picker = ImagePicker();

  RequestState requestState = RequestState.waiting;
  GideTypeModel? gideTypeModel;
  XFile? backIDImage, forwardIDImage;
  String? country;
  String? lang;
  List<String> countries = ['فيراري', 'كيا', 'مرسيديس'];
  List<String> languages = ['الفرنسية', 'العربية', 'الانجليزية'];
  List<XFile>? images;

  File? img, img2, img3;
  LanguagesModel? languagesModel;

  getData() async {
    requestState = RequestState.loading;

    final res = await AddInformationTravelGroupsController.getLanguages();
    if (!res) {
      setState(() {
        requestState = RequestState.error;
      });
      return;
    }
    languagesModel = AddInformationTravelGroupsController.languagesModel;

    AddInformationTravelGroupsController.getGideType().then((value) {
      if (value) {
        gideTypeModel = AddInformationTravelGroupsController.gideTypeModel;
        requestState = RequestState.success;
      } else {
        requestState = RequestState.error;
      }

      setState(() {});
    });
  }

  List<XFile> addImages = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      body: Builder(
        builder: (context) {
          if (requestState == RequestState.loading)
            return Center(child: CircularProgressIndicator());
          if (requestState == RequestState.error)
            return Text('تأكد من اتصالك بالانترنت');

          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                top: size.height * 0.025,
                bottom: size.height * 0.02,
                left: size.height * 0.02,
                right: size.height * 0.02,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomAppBar(pageTitle: ''),
                  SizedBox(
                    height: 5.h,
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
                    height: 4.h,
                  ),
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
                                'يمكنك إضافة صور بحد أقصي 2 صورة في الإعلان الواحد',
                            maxLines: 2,
                            fontSize: AppFonts.t3,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
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
                                            images?.removeAt(index);
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
                    height: 1.h,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: CustomText(
                        text: 'نوع المركبة',
                        fontSize: AppFonts.t3,
                        fontweight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  customContainerTextFormField(
                    TFF: customTextFormField(
                      context: context,
                      controller: carNameController,
                      hintText: 'PMW',
                      keyboardType: TextInputType.text,
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Is Required".tr),
                      ]),
                      onChanged: (value) {},
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: CustomText(
                        text: 'موديل المركبة',
                        fontSize: AppFonts.t3,
                        fontweight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  customContainerTextFormField(
                    TFF: customTextFormField(
                      context: context,
                      controller: carModelController,
                      hintText: '2010',
                      keyboardType: TextInputType.text,
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Is Required".tr),
                      ]),
                      onChanged: (value) {},
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: CustomText(
                        text: 'الحد الأقصى للركاب',
                        fontSize: AppFonts.t3,
                        fontweight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  customContainerTextFormField(
                    TFF: customTextFormField(
                      context: context,
                      controller: maximumPassengersController,
                      hintText: '4',
                      keyboardType: TextInputType.text,
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Is Required".tr),
                      ]),
                      onChanged: (value) {},
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: CustomText(
                        text: 'اللغة التي أتحدثها',
                        fontSize: AppFonts.t3,
                        fontweight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  customContainerTextFormField(
                    TFF: customTextFormField(
                      context: context,
                      controller: langController,
                      hintText: 'العربية',
                      keyboardType: TextInputType.text,
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Is Required".tr),
                      ]),
                      onChanged: (value) {},
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: CustomText(
                        text: 'رقم الترخيص',
                        fontSize: AppFonts.t3,
                        fontweight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  customContainerTextFormField(
                    TFF: customTextFormField(
                      context: context,
                      controller: license_number,
                      hintText: '00025102',
                      keyboardType: TextInputType.phone,
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Is Required".tr),
                      ]),
                      onChanged: (value) {},
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: CustomText(
                        text: ' إضافة صوره الهوية',
                        fontSize: AppFonts.t3,
                        fontweight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  GestureDetector(
                    onTap: () async {
                      FilePickerResult? result = await FilePicker.platform
                          .pickFiles(
                              type: FileType.custom,
                              allowedExtensions: ['jpg', 'pdf', 'doc'],
                              allowMultiple: false);
                      setState(() {
                        if (result != null && result.files.isNotEmpty) {
                          img = File(result.files.first.path!);
                        }
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                      width: size.width,
                      height: 7.h,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 252, 252, 252),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            offset: const Offset(0, 1.0),
                            blurRadius: 4.0,
                          ),
                        ],
                      ),
                      child: Row(children: [
                        Icon(
                          Icons.cloud_upload_outlined,
                          color: AppColor.orangeColor,
                          size: 35,
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        img == null
                            ? Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  CustomText(
                                      text: 'ارفق ملف',
                                      fontSize: AppFonts.t4_2),
                                  CustomText(
                                      text: 'Pdf , Png , Jpg , Jpeg',
                                      fontSize: AppFonts.t4),
                                ],
                              )
                            : Expanded(
                                child: CustomText(
                                    text: img.toString(), maxLines: 2))
                      ]),
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: CustomText(
                        text: 'برجاء إضافة صوره ترخيص المركبة',
                        fontSize: AppFonts.t3,
                        fontweight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  GestureDetector(
                    onTap: () async {
                      FilePickerResult? result = await FilePicker.platform
                          .pickFiles(
                              type: FileType.custom,
                              allowedExtensions: ['jpg', 'pdf', 'doc'],
                              allowMultiple: false);
                      setState(() {
                        if (result != null && result.files.isNotEmpty) {
                          img2 = File(result.files.first.path!);
                        }
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                      width: size.width,
                      height: 7.h,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 252, 252, 252),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            offset: const Offset(0, 1.0),
                            blurRadius: 4.0,
                          ),
                        ],
                      ),
                      child: Row(children: [
                        Icon(
                          Icons.cloud_upload_outlined,
                          color: AppColor.orangeColor,
                          size: 35,
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        img2 == null
                            ? Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  CustomText(
                                      text: 'ارفق ملف',
                                      fontSize: AppFonts.t4_2),
                                  CustomText(
                                      text: 'Pdf , Png , Jpg , Jpeg',
                                      fontSize: AppFonts.t4),
                                ],
                              )
                            : Expanded(
                                child: CustomText(
                                    text: img2.toString(), maxLines: 2))
                      ]),
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: CustomText(
                        text: 'برجاء إضافة صوره شخصية للمرشد السياحي',
                        fontSize: AppFonts.t3,
                        fontweight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  GestureDetector(
                    onTap: () async {
                      FilePickerResult? result = await FilePicker.platform
                          .pickFiles(
                              type: FileType.custom,
                              allowedExtensions: ['jpg', 'pdf', 'doc'],
                              allowMultiple: false);
                      setState(() {
                        if (result != null && result.files.isNotEmpty) {
                          img3 = File(result.files.first.path!);
                        }
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                      width: size.width,
                      height: 7.h,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 252, 252, 252),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            offset: const Offset(0, 1.0),
                            blurRadius: 4.0,
                          ),
                        ],
                      ),
                      child: Row(children: [
                        Icon(
                          Icons.cloud_upload_outlined,
                          color: AppColor.orangeColor,
                          size: 35,
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        img3 == null
                            ? Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  CustomText(
                                      text: 'ارفق ملف',
                                      fontSize: AppFonts.t4_2),
                                  CustomText(
                                      text: 'Pdf , Png , Jpg , Jpeg',
                                      fontSize: AppFonts.t4),
                                ],
                              )
                            : Expanded(
                                child: CustomText(
                                    text: img3.toString(), maxLines: 2))
                      ]),
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  customContainerTextFormField(
                    TFF: customTextFormField(
                      context: context,
                      controller: iBANController,
                      hintText: 'إضافة رقم الايبان',
                      keyboardType: TextInputType.text,
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Is Required".tr),
                      ]),
                      onChanged: (value) {},
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
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
                      controller: descController,
                      hintText: 'يرجي كتابة وصف واضح',
                      keyboardType: TextInputType.text,
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Is Required".tr),
                      ]),
                      onChanged: (value) {},
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'برجاء تحديد سعر الساعة',
                          fontweight: FontWeight.w600,
                          fontSize: AppFonts.t3,
                        ),
                        CustomTextFormField(
                            controller: priceController,
                            contentPadding: EdgeInsets.only(right: 10, top: 5),
                            onChangedFun: () {},
                            hintText: '1000 ',
                            width: 45.w,
                            radius: 2.w,
                            keyBoardType: TextInputType.phone)
                      ],
                    ),
                  ),
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
                          if (images == null || images!.length < 2) {
                            toastShow(
                                text: 'يرجى إضافة صور بحد أقصى 2 من الصور');
                            return;
                          }
                          if (carNameController.text == null) {
                            toastShow(text: 'تأكد من ادخال نوع المركبة');
                            return;
                          }
                          if (langController.text == null) {
                            toastShow(text: 'تأكد من ادخال اللغة');
                            return;
                          }
                          if (carModelController.text == null) {
                            toastShow(text: 'تأكد من ادخال موديل المركبة');
                            return;
                          }

                          try {
                            int.parse(license_number.text);
                            if (license_number.text.length < 4) {
                              toastShow(
                                  text:
                                      'رقم الترخيص يتكون من 4 ارقام على الأقل');
                              return;
                            }
                          } catch (e) {
                            toastShow(text: 'تأكد من رقم الترخيص');
                            return;
                          }
                          try {
                            if (int.parse(priceController.text) < 0 ||
                                int.parse(priceController.text) > 999999) {
                              toastShow(text: 'تأكد من سعر الفعالية');
                              return;
                            }
                          } catch (e) {
                            toastShow(text: 'تأكد من سعر الفعالية');
                            return;
                          }
                          try {
                            if (int.parse(maximumPassengersController.text) <
                                    0 ||
                                int.parse(maximumPassengersController.text) >
                                    999999) {
                              toastShow(text: 'خطأ في عدد الركاب');
                              return;
                            }
                          } catch (e) {
                            toastShow(text: 'خطأ في عدد الركاب');
                            return;
                          }
                          if (img == null) {
                            toastShow(text: 'تأكد من إضافة صورة الهوية');
                            return;
                          }
                          if (img2 == null) {
                            toastShow(text: 'تأكد من إضافة صورة ترخيص المركبة');
                            return;
                          }
                          if (iBANController.text.length < 7) {
                            toastShow(text: 'تأكد من رقم الايبان');
                            return;
                          }
                          if (descController.text.length < 10) {
                            toastShow(
                                text: 'وصف واضح يتكون من 10 أحرف على الأقل');
                            return;
                          }
                          /*  AddInformationTravelGroupsController.travel_type_id =
                              '7'; */
                          AddInformationTravelGroupsController.passengers =
                              maximumPassengersController.text;
                          AddInformationTravelGroupsController.car_name =
                              carNameController.text;
                          AddInformationTravelGroupsController.moodle =
                              carModelController.text;
                          AddInformationTravelGroupsController.license_number =
                              license_number.text; 
                          AddInformationTravelGroupsController.images = images;
                          AddInformationTravelGroupsController.language_id =
                              langController.text;
                          AddInformationTravelGroupsController.iban =
                              iBANController.text;
                          AddInformationTravelGroupsController.desc =
                              descController.text;
                          AddInformationTravelGroupsController.price =
                              priceController.text;
                          AddInformationTravelGroupsController.national_image =
                              XFile(img!.path);
                          AddInformationTravelGroupsController.license_image =
                              XFile(img2!.path);
                          AddInformationTravelGroupsController.guide_image =
                              XFile(img3!.path);
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
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget customContainerTextFormField({
    required Widget TFF,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      alignment: Alignment.center,
      width: context.getWidth,
      decoration: BoxDecoration(
        color: AppColor.backGroundColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            offset: const Offset(0, 1.0),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: TFF,
    );
  }
}
