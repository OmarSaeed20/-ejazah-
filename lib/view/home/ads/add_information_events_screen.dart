import 'dart:developer';
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
import 'package:ejazah/controller/auth/user_controller.dart';
import 'package:ejazah/utils/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/add_information_tavel_groups_controller.dart';
import '../../../controller/add_service_controller/add_ads_controller.dart';
import '../../../model/event_type_model.dart';
import 'add_condetions_screen.dart';

class AddInfoEventsScreen extends StatefulWidget {
  AddInfoEventsScreen({super.key});

  @override
  State<AddInfoEventsScreen> createState() => _AddInfoEventsScreenState();
}

class _AddInfoEventsScreenState extends State<AddInfoEventsScreen> {
  final TextEditingController fromController = TextEditingController(),
      toController = TextEditingController();
  late DateTime to;
  late DateTime from;
  late DateTime initFrom;
  TimeOfDay? startHour, endHour;
  int difference = 0;
  Duration? differenceHours;
  int? to_hours;
  int? from_hours;
  TextEditingController eventNameController = TextEditingController();
  TextEditingController iBANController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController ticketNumbersController = TextEditingController();
  TextEditingController ticketPriceController = TextEditingController();

  final ImagePicker picker = ImagePicker();

  XFile? backIDImage, forwardIDImage;
  String? value = CurrentUser.cityId;
  String? value0;
  List<XFile>? images;
  List<XFile> addImages = [];
  String? dateTime, startTime, endTime;

  RequestState requestState = RequestState.waiting;

  EventTypeModel? eventTypeModel;
  String? _selectedOption = '1';

  getData() {
    requestState = RequestState.loading;
    AddInformationTravelGroupsController.getEventType().then((value) {
      if (value) {
        eventTypeModel = AddInformationTravelGroupsController.eventTypeModel;
        requestState = RequestState.success;
      } else {
        requestState = RequestState.error;
      }

      setState(() {});
    });
  }

  @override
  void initState() {
    AddAdsController.lat = '';
    AddAdsController.long = '';
    getData();
    super.initState();
  }

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
                                      'يمكنك إضافة صور بحد أقصي 4 صورة في الإعلان الواحد',
                                  maxLines: 2,
                                  fontSize: AppFonts.t3),
                            ),
                          )
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
                                        EdgeInsets.symmetric(horizontal: 1.0.w),
                                  ),
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
                        height: 2.h,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: CustomText(
                            text: 'برجاء اختيار نوع الفعالية',
                            fontSize: AppFonts.t3,
                            fontweight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      customContainerTextFormField(
                        TFF: customTextFormField(
                          context: context,
                          controller: eventNameController,
                          hintText: 'إسم الفعالية (فعاليات ترفيهية)',
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
                      /* Stack(
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
                                                            AppColor
                                                                .buttonColor)),
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
                        height: 3.h,
                      ), */
                      Container(
                        alignment: Alignment.centerRight,
                        child: CustomText(
                            text: 'برجاء اختيار أوقات العمل',
                            fontSize: AppFonts.t3,
                            fontweight: FontWeight.w600),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 45.w,
                              height: 6.h,
                              child: TextFormField(
                                controller: fromController,
                                readOnly: true,
                                validator: (value) =>
                                    value!.isEmpty ? 'Is Required' : null,
                                decoration: InputDecoration(
                                  prefixText: '',
                                  hintText: 'من',
                                  prefixIcon:
                                      Icon(Icons.calendar_today_rounded),
                                  border: OutlineInputBorder(),
                                ),
                                onTap: () async {
                                  final date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    lastDate: DateTime(2100),
                                  );
                                  if (date == null) {
                                    fromController.clear();
                                    return;
                                  }
                                  from = date;
                                  initFrom = DateTime(
                                      from.year, from.month, from.day + 1);
                                  String dateTime = date.year.toString() +
                                      '-' +
                                      date.month.toString() +
                                      '-' +
                                      date.day.toString();
                                  print(dateTime);
                                  difference = from.difference(from).inDays;
                                  setState(() {});

                                  fromController.text = dateTime;
                                },
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                final TimeOfDay? newTime = await showTimePicker(
                                  confirmText: 'تم',
                                  cancelText: 'إلغاء',
                                  context: context,
                                  helpText: 'متي تريد بدأ العمل؟',
                                  initialTime: TimeOfDay(hour: 12, minute: 00),
                                );
                                setState(() {
                                  if (newTime != null) {
                                    newTime.format(context);
                                    startTime = newTime.format(context);
                                    startHour = newTime;
                                    to_hours = startHour!.hour;
                                    print(to_hours);
                                  }
                                });
                                log("start hour ==> " + startHour.toString());

                                if (endHour != null) {
                                  var format = DateFormat("hh:mm");
                                  DateTime one = format.parse(
                                      '${startHour!.hour}:${startHour!.minute}');
                                  DateTime two = format.parse(
                                      '${endHour!.hour}:${endHour!.minute}');
                                  differenceHours = two.difference(one);
                                  print('differenceHours');
                                  log(differenceHours.toString());
                                  if (differenceHours!.isNegative)
                                    differenceHours = one.difference(two);
                                  log(differenceHours.toString());
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding:
                                    EdgeInsets.symmetric(horizontal: 1.5.h),
                                height: 6.0.h,
                                width: 45.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: AppColor.buttonColor, width: 2)),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.timer_rounded,
                                      color: AppColor.orangeColor,
                                    ),
                                    CustomText(
                                        text: startTime ?? 'وقت بدأ العمل',
                                        padding: EdgeInsets.symmetric(
                                            vertical: 3.w, horizontal: 2.w),
                                        fontSize: AppFonts.t3,
                                        color: AppColor.grayColor),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 45.w,
                            height: 6.h,
                            child: TextFormField(
                              controller: toController,
                              readOnly: true,
                              validator: (value) =>
                                  value!.isEmpty ? 'Is Required' : null,
                              decoration: InputDecoration(
                                prefixText: ' ',
                                hintText: 'إلى',
                                prefixIcon: Icon(Icons.calendar_today_rounded),
                                border: OutlineInputBorder(),
                              ),
                              onTap: () async {
                                final date = await showDatePicker(
                                  context: context,
                                  initialDate: initFrom,
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime(2100),
                                );
                                if (date == null) {
                                  toController.clear();
                                  return;
                                }
                                to = date;
                                difference = to.difference(from).inDays;
                                setState(() {});
                                // String birthday = DateFormat.yMd().format(date);
                                String dateTime = date.year.toString() +
                                    '-' +
                                    date.month.toString() +
                                    '-' +
                                    date.day.toString();
                                print(dateTime);
                                toController.text = dateTime;
                              },
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              final TimeOfDay? newTime = await showTimePicker(
                                confirmText: 'تم',
                                cancelText: 'إلغاء',
                                context: context,
                                helpText: 'متي تريد إنهاء العمل؟',
                                initialTime: TimeOfDay(hour: 12, minute: 00),
                              );
                              setState(() {
                                if (newTime != null) {
                                  newTime.format(context);
                                  endTime = newTime.format(context);
                                  endHour = newTime;
                                  from_hours = endHour!.hour;
                                  print(from_hours.toString());
                                }
                              });
                              log("end hour ==> " + startHour.toString());
                              if (startHour != null) {
                                var format = DateFormat("HH:mm");
                                DateTime one = format.parse(
                                    '${startHour!.hour}:${startHour!.minute}');
                                DateTime two = format.parse(
                                    '${endHour!.hour}:${endHour!.minute}');
                                differenceHours = two.difference(one);
                                log(differenceHours.toString());
                                if (differenceHours!.isNegative)
                                  differenceHours = one.difference(two);
                                log(differenceHours.toString());
                                log(dateTime.toString());
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(horizontal: 1.2.h),
                              height: 6.0.h,
                              width: 45.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: AppColor.buttonColor, width: 2)),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.timer_rounded,
                                    color: AppColor.orangeColor,
                                  ),
                                  CustomText(
                                      text: endTime ?? 'وقت إنتهاء العمل',
                                      padding: EdgeInsets.symmetric(
                                          vertical: 3.w, horizontal: 1.w),
                                      fontSize: AppFonts.t3,
                                      color: AppColor.grayColor),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: CustomText(
                        text: 'تصنيف الفعالية',
                        fontSize: AppFonts.t3,
                        fontweight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 1.h,
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
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: value0,
                          hint: Text(
                            'اختر الفاعلية',
                            style: TextStyle(
                                fontSize: AppFonts.t3,
                                fontWeight: FontWeight.bold),
                          ),
                          isExpanded: true,
                          items: eventTypeModel!.data!.eventType!.map(
                            (element) {
                              return DropdownMenuItem<String>(
                                value: element.id.toString(),
                                child: Text(element.name!),
                              );
                            },
                          ).toList(),
                          onChanged: (value) {
                            value0 = value;
                            log("----------> ${value}");
                            AddInformationTravelGroupsController
                                .travel_type_id = value0;
                            /* CurrentUser.countryId = countryValue00.toString(); */
                            setState(() {});
                          },
                        ),
                      )),
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
                      controller: desController,
                      hintText: 'يرجي كتابة وصف واضح',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'برجاء تحديد عدد التذاكر',
                        fontweight: FontWeight.w600,
                        fontSize: AppFonts.t3,
                      ),
                      CustomTextFormField(
                        controller: ticketNumbersController,
                        contentPadding: EdgeInsets.only(right: 30, top: 12),
                        onChangedFun: () {},
                        hintText: '5',
                        width: 45.w,
                        radius: 2.w,
                        keyBoardType: TextInputType.phone,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'برجاء تحديد سعر التذكرة',
                        fontweight: FontWeight.w600,
                        fontSize: AppFonts.t3,
                      ),
                      CustomTextFormField(
                        controller: ticketPriceController,
                        contentPadding: EdgeInsets.only(right: 20, top: 12),
                        onChangedFun: () {},
                        hintText: '1000',
                        width: 45.w,
                        radius: 2.w,
                        keyBoardType: TextInputType.phone,
                      )
                    ],
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
                          if (_selectedOption == null) {
                            toastShow(text: 'برجاء اختيار نوع الغعالية');
                            return;
                          }
                          if (differenceHours == null) {
                            toastShow(text: 'برجاء تحديد وقت العمل');
                            return;
                          }
                          if (fromController.text.isEmpty ||
                              toController.text.isEmpty) {
                            toastShow(text: 'برجاء التأكد من التاريخ');
                            return;
                          }
                          if (images == null || images!.isEmpty) {
                            toastShow(
                                text:
                                    'برجاء اختيار صورة واحدة على الأقل للفعالية');
                            return;
                          }
                          if (iBANController.text.length < 7) {
                            toastShow(text: 'برجاء كتابة الأيبان بطريقة صحيحة');
                            return;
                          }
                          if (desController.text.length < 10) {
                            toastShow(
                                text:
                                    'يتكون وصف الأعلان  من 10 احرف علي الأقل');
                            return;
                          }
                          try {
                            if (int.parse(ticketPriceController.text) > 99999) {
                              toastShow(
                                  text: 'برجاء كتابة سعر التذكرة بطريقة صحيحة');
                              return;
                            }
                          } catch (e) {
                            toastShow(
                                text: 'برجاء كتابة سعر التذكرة بطريقة صحيحة');
                            return;
                          }
                          try {
                            if (int.parse(ticketNumbersController.text) >
                                99999) {
                              toastShow(
                                  text: 'برجاء كتابة عدد التذاكر بطريقة صحيحة');
                              return;
                            }
                          } catch (e) {
                            toastShow(
                                text: 'برجاء كتابة عدد التذاكر بطريقة صحيحة');
                            return;
                          }
                          AddInformationTravelGroupsController.event_name =
                              eventNameController.text;
                          AddInformationTravelGroupsController.images = images;
                          AddInformationTravelGroupsController.from =
                              fromController.text;
                          AddInformationTravelGroupsController.to =
                              toController.text;
                          AddInformationTravelGroupsController.iban =
                              iBANController.text;
                          AddInformationTravelGroupsController.desc =
                              desController.text;
                          AddInformationTravelGroupsController.lat =
                              AddAdsController.lat;
                          AddInformationTravelGroupsController.long =
                              AddAdsController.long;
                          AddInformationTravelGroupsController.hour_work =
                              differenceHours!.inHours.toString();
                          AddInformationTravelGroupsController.to_hours =
                              to_hours.toString();
                          AddInformationTravelGroupsController.from_hours =
                              from_hours.toString();
                          AddInformationTravelGroupsController.price =
                              ticketPriceController.text;
                          AddInformationTravelGroupsController.ticket_count =
                              ticketNumbersController.text;
                          if (differenceHours!.inHours < 0) {
                            differenceHours =
                                Duration(hours: 24 + differenceHours!.inHours);
                          }
                          log("------------->${AddInformationTravelGroupsController.hour_work}");
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
