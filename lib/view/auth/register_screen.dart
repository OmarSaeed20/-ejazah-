// ignore_for_file: deprecated_member_use, unnecessary_null_comparison

import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/app_svg.dart';
import 'package:ejazah/Widgets/customAppBar.dart';
import 'package:ejazah/Widgets/custom_text.dart';
import 'package:ejazah/Widgets/myNavigate.dart';
import 'package:ejazah/components/components.dart';
import 'package:ejazah/components/extentions.dart';
import 'package:ejazah/components/year.dart';
import 'package:ejazah/constants/constants.dart';
import 'package:ejazah/controller/auth/get_countries_controller.dart';
import 'package:ejazah/controller/auth/user_controller.dart';
import 'package:ejazah/model/register_models/get_countries_model.dart';
import 'package:ejazah/view/auth/login_screen.dart';
import 'package:ejazah/view/auth/policy_privacy_screen.dart';
import 'package:ejazah/view/auth/rest_password_code.dart';
import 'package:ejazah/view/auth/terms_and_conditions_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sizer/sizer.dart';
import '../../controller/auth/register_controller.dart';
import '../../utils/enums.dart';
import '../../core/global.dart';

class RegisterScreen extends StatefulWidget {
  static const String registerRoute = 'register_screen';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // final _auth = FirebaseAuth.instance;

  TextEditingController nameCtrl = TextEditingController(),
      // nationality = TextEditingController(),
      birth_date = TextEditingController(),
      emailCtrl = TextEditingController(),
      phoneCtrl = TextEditingController(),
      passwordCtrl = TextEditingController(),
      confirmPasswordCtrl = TextEditingController();

  bool showSpinner = false;
  final formGlobalKey = GlobalKey<FormState>();
  bool isVisiblePassword = false;
  // late DateTime from;
  String? year;
  String? selectedNationality;

  RequestState requestState = RequestState.waiting;
  String typeValue = '1';

  @override
  void initState() {
    super.initState();
  }

  bool visible = false;
  String? flag;
  String? code;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: formGlobalKey,
      child: Scaffold(
        backgroundColor: AppColor.backGroundColor,
        body: SafeArea(
          child: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  top: size.height * 0.025,
                  bottom: size.height * 0.05,
                  left: size.height * 0.02,
                  right: size.height * 0.02,
                ),
                child: Column(children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: CustomAppBar(pageTitle: '')),
                  SvgPicture.asset(
                    'assets/svg/Group 36770.svg',
                    width: 20.w,
                    height: 20.h,
                  ),
                  SizedBox(height: 8.h),
                  CustomText(
                    text: 'انشاء حساب جديد',
                    textAlign: TextAlign.center,
                    color: Colors.black,
                    fontSize: AppFonts.t2,
                    fontweight: FontWeight.bold,
                  ),
                  SizedBox(height: 2.h),
                  Column(
                    children: [
                      customContainerTextFormField(
                        TFF: customTextFormField(
                            context: context,
                            controller: nameCtrl,
                            hintText: 'اسم المستخدم',
                            keyboardType: TextInputType.name,
                            validator: MultiValidator([
                              RequiredValidator(errorText: "Is Required".tr),
                            ]),
                            onChanged: (value) {
                              CurrentUser.name = value.toString();
                            },
                            prefixIcon: customSuffixIconIconTextFormField(
                                pathIconSvg: AppSvgImages.profile_boldIc)),
                      ),
                      SizedBox(height: 2.h),
                      customContainerTextFormField(
                        TFF: customTextFormField(
                          enableInteractiveSelection: true,
                          context: context,
                          controller: emailCtrl,
                          hintText: 'البريد الالكتروني',
                          keyboardType: TextInputType.emailAddress,
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Is Required".tr),
                          ]),
                          onChanged: (value) {
                            CurrentUser.email = value.toString();
                          },
                          prefixIcon: customSuffixIconIconTextFormField(
                              pathIconSvg: 'assets/svg/sms-linear.svg'),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      customContainerTextFormField(
                        TFF: customTextFormField(
                          context: context,
                          controller: phoneCtrl,
                          hintText: 'رقم الهاتف',
                          keyboardType: TextInputType.phone,
                          isCountry: true,
                          flag: flag == null
                              ? GetCountries
                                  .getCountriesModel!.data!.countries![0].flag
                              : flag,
                          code: code == null
                              ? GetCountries
                                  .getCountriesModel!.data!.countries![0].code
                              : code,
                          callback: () {
                            visible = !visible;
                            setState(() {});
                          },
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Is Required".tr),
                          ]),
                          onChanged: (value) {
                            CurrentUser.phone = value.toString();
                          },
                          /* prefixIcon: customSuffixIconIconTextFormField(
                              pathIconSvg: 'assets/svg/call-linear.svg'), */
                        ),
                      ),
                      Visibility(
                        visible: visible,
                        replacement: Padding(
                          padding: EdgeInsets.only(top: 2.h),
                          child: customContainerTextFormField(
                            TFF: DropdownButtonHideUnderline(
                              child: Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 3.0.w),
                                child: Row(
                                  children: [
                                    Transform.translate(
                                      offset: Offset(5, 0),
                                      child: Icon(
                                        Icons.flag_outlined,
                                        color: Color.fromRGBO(234, 146, 78, 1),
                                        size: 30,
                                      ),
                                    ),
                                    SizedBox(width: 1.5.w),
                                    Expanded(
                                      child: DropdownButton<String>(
                                        iconEnabledColor: Colors.transparent,
                                        hint: Text(
                                          selectedNationality == null
                                              ? 'الجنسية'
                                              : '${selectedNationality}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                                color: selectedNationality ==
                                                        null
                                                    ? const Color(0xff7A716E)
                                                    : Colors.black,
                                                fontFamily: "Tajawal",
                                              ),
                                        ),
                                        isExpanded: true,
                                        items: nationality.map(
                                          (element) {
                                            return DropdownMenuItem<String>(
                                              value: element,
                                              child: Text('${element}'),
                                            );
                                          },
                                        ).toList(),
                                        onChanged: (value) async {
                                          selectedNationality = value;
                                          CurrentUser.nationality =
                                              selectedNationality;
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        child: Container(
                          margin: EdgeInsets.only(top: 1.0.h),
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5.0),
                          alignment: Alignment.center,
                          width: context.getWidth,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade400,
                                offset: const Offset(0, 1.0),
                                blurRadius: 3.0,
                              ),
                            ],
                          ),
                          child: Column(
                            children: GetCountries
                                .getCountriesModel!.data!.countries!
                                .map(
                              (element) {
                                return DropdownMenuItem<Countries>(
                                  value: element,
                                  child: InkWell(
                                    onTap: () {
                                      CurrentUser.countryId = '${element.id}';
                                      flag = element.flag;
                                      code = element.code;
                                      visible = false;
                                      setState(() {});
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${element.code}',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: Colors.black,
                                            fontFamily: "Tajawal",
                                          ),
                                        ),
                                        SizedBox(width: 1.0.w),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          child: Image.network(
                                            '${element.flag}',
                                            height: 4.0.h,
                                            width: 4.0.h,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      ),

                      /* customContainerTextFormField(
                        TFF: customTextFormField(
                          context: context,
                          controller: nationality,
                          hintText: 'الجنسية',
                          keyboardType: TextInputType.text,
                          // obscureText: isVisiblePassword,
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Is Required".tr),
                          ]),
                          onChanged: (value) {
                            CurrentUser.nationality = value.toString();
                          },
                          prefixIcon: Transform.translate(
                            offset: Offset(5, 0),
                            child: Icon(
                              Icons.flag,
                              color: Color.fromRGBO(234, 146, 78, 1),
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      */
                      SizedBox(height: 2.h),
                      customContainerTextFormField(
                        TFF: DropdownButtonHideUnderline(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3.0.w),
                            child: Row(
                              children: [
                                Transform.translate(
                                  offset: Offset(5, 0),
                                  child: Icon(
                                    Icons.date_range_outlined,
                                    color: Color.fromRGBO(234, 146, 78, 1),
                                    size: 30,
                                  ),
                                ),
                                SizedBox(width: 1.5.w),
                                Expanded(
                                  child: DropdownButton<int>(
                                    iconEnabledColor: Colors.transparent,
                                    hint: Text(
                                      year == null
                                          ? 'تاريخ الميلاد'
                                          : '${year}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            color: year == null
                                                ? const Color(0xff7A716E)
                                                : Colors.black,
                                            fontFamily: "Tajawal",
                                          ),
                                    ),
                                    isExpanded: true,
                                    items: GetCountries.years.map(
                                      (element) {
                                        return DropdownMenuItem<int>(
                                          value: element,
                                          child: Text('${element}'),
                                        );
                                      },
                                    ).toList(),
                                    onChanged: (value) async {
                                      year = '${value}';
                                      CurrentUser.birth_date = year;
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      /* customContainerTextFormField(
                        TFF: customTextFormField(
                          context: context,
                          controller: birth_date,
                          hintText: 'تاريخ الميلاد',
                          keyboardType: TextInputType.datetime,
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Is Required".tr),
                          ]),
                          readOnly: true,
                          onTap: () async {
                            // final date = await showDatePicker(
                            //   context: context,
                            //   initialDate: DateTime.now(),
                            //   firstDate: DateTime(1950),
                            //   lastDate: DateTime(2100),
                            // );
                            // if (date == null) {
                            //   birth_date.clear();
                            //   return;
                            // }
                            // from = date;
                            // // String birthday = DateFormat.yMd().format(date);
                            // String dateTime = date.year.toString() +
                            //     '-' +
                            //     date.month.toString() +
                            //     '-' +
                            //     date.day.toString();
                            // print(dateTime);
                            // setState(() {});

                            // birth_date.text = dateTime;
                            // CurrentUser.birth_date = dateTime;
                          },
                          prefixIcon: Transform.translate(
                            offset: Offset(5, 0),
                            child: Icon(
                              Icons.date_range_outlined,
                              color: AppColor.orangeColor,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                       */
                      SizedBox(height: 2.h),
                      customContainerTextFormField(
                        TFF: customTextFormField(
                            context: context,
                            controller: passwordCtrl,
                            hintText: 'كلمة المرور',
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: isVisiblePassword,
                            validator: MultiValidator([
                              RequiredValidator(errorText: "Is Required".tr),
                            ]),
                            onChanged: (value) {
                              CurrentUser.password = value.toString();
                            },
                            suffixIcon: isVisiblePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            suffixIconOnPressed: () {
                              setState(() {
                                isVisiblePassword = !isVisiblePassword;
                              });
                            },
                            prefixIcon: customSuffixIconIconTextFormField(
                                pathIconSvg:
                                    'assets/svg/vuesax-linear-lock.svg')),
                      ),
                      SizedBox(height: 2.h),
                      customContainerTextFormField(
                        TFF: customTextFormField(
                            context: context,
                            controller: confirmPasswordCtrl,
                            hintText: 'تأكيد كلمة المرور',
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: isVisiblePassword,
                            validator: MultiValidator([
                              RequiredValidator(errorText: "Is Required".tr),
                            ]),
                            onChanged: (value) {
                              CurrentUser.confirmPassword = value.toString();
                            },
                            suffixIcon: isVisiblePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            suffixIconOnPressed: () {
                              setState(() {
                                isVisiblePassword = !isVisiblePassword;
                              });
                            },
                            prefixIcon: customSuffixIconIconTextFormField(
                                pathIconSvg:
                                    'assets/svg/vuesax-linear-lock.svg')),
                      ),
                      SizedBox(height: 2.h),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          height: 5.5.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: CustomRadioButton(
                            title: 'ذكر',
                            typeNum: '1',
                          ),
                        ),
                      ),
                      SizedBox(width: 5.w),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          height: 5.5.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: CustomRadioButton(title: 'انثى', typeNum: '0'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  Container(
                    width: size.width,
                    height: 6.5.h,
                    child: Builder(
                      builder: (context) {
                        if (requestState == RequestState.loading)
                          return Center(
                              child: CircularProgressIndicator(
                                  color: AppColor.buttonColor));
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.buttonColor),
                          onPressed: requestState != RequestState.loading
                              ? () async {
                                  if (year == null) {
                                    toastShow(
                                        text: "برجاء اختيار تاريخ الميلاد");
                                  } else if (nationality == null) {
                                    toastShow(text: "برجاء اختيار الجنسية");
                                  } else {
                                    requestState = RequestState.loading;
                                    setState(() {});
                                    bool status =
                                        await RegisterController.userSignUp();
                                    if (status) {
                                      firebaseAuthUser
                                          .createUserWithEmailAndPassword(
                                              email: emailCtrl.text,
                                              password: passwordCtrl.text)
                                          .then((value) {
                                        requestState = RequestState.success;
                                        setState(() {});
                                        toastShow(
                                            text: "برجاء تفعيل الحساب اولا");
                                        myNavigate(
                                            screen: RestPasswordCodeScreen(
                                              isResetPass: false,
                                              phone: phoneCtrl.text,
                                              nextScreen: LoginScreen(),
                                            ),
                                            context: context);
                                      }).catchError((e) {
                                        requestState = RequestState.error;
                                        setState(() {});
                                        print(e);
                                        toastShow(
                                            text: e.toString().split('] ').last,
                                            state: ToastStates.error);
                                      });
                                    } else {
                                      requestState = RequestState.error;
                                      setState(() {});
                                    }

                                    /*  if (status) {
                                      firebaseAuthUser
                                          .createUserWithEmailAndPassword(
                                        email: emailCtrl.text,
                                        password: passwordCtrl.text,
                                      )
                                          .then((value) {
                                        requestState = RequestState.success;
                                        setState(() {});
                                        toastShow(
                                            text: "برجاء تفعيل الحساب اولا");
                                        myNavigate(
                                            screen: RestPasswordCodeScreen(
                                                isResetPass: false,
                                                phone: phoneCtrl.text,
                                                nextScreen:
                                                    ChooseCountryScreen()),
                                            context: context);
                                      }).catchError((e) {
                                        requestState = RequestState.error;
                                        setState(() {});
                                        print(e);
                                        toastShow(
                                            text: e.toString().split('] ').last,
                                            state: ToastStates.error);
                                      });
                                    } else {
                                      requestState = RequestState.error;
                                      setState(() {});
                                    } */
                                  }
                                }
                              : null,
                          child: Text(
                            'تسجيل الدخـول',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: AppFonts.t2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        ' لديك حسـاب بالفعل ؟',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: AppFonts.t4_2,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          myNavigate(screen: LoginScreen(), context: context);
                        },
                        child: Text(
                          '  تسجيل الدخول',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: AppFonts.t4_2,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Container(
                    padding: EdgeInsets.only(top: 1.6.h),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 0.5),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Text(
                          'من خلال إنشاء حساب ، فإنك تقبل',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: AppFonts.t4_2,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                                onPressed: () {
                                  myNavigate(
                                      screen: TermsAndConditionsScreen(),
                                      context: context);
                                },
                                child: CustomText(
                                    text: 'سياسة الخصوصية',
                                    fontSize: AppFonts.t4_2,
                                    color: Colors.blueAccent,
                                    fontweight: FontWeight.bold)),
                            TextButton(
                                onPressed: () {
                                  myNavigate(
                                      screen: PrivacyAndPolicy(),
                                      context: context);
                                },
                                child: CustomText(
                                    text: 'الشروط والاحكام',
                                    color: Colors.blueAccent,
                                    fontSize: AppFonts.t4_2,
                                    fontweight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ])),
          ),
        ),
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
      // height: 7.h,
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
      child: TFF,
    );
  }

  Widget customSuffixIconIconTextFormField({
    required String pathIconSvg,
  }) {
    return Container(
      padding: EdgeInsets.only(top: 7, left: 10, bottom: 10),
      child: SvgPicture.asset(
        pathIconSvg,
        color: Color.fromRGBO(234, 146, 78, 1),
      ),
    );
  }

  String text(text) => 'برجاء التاكد من $text';

  CustomRadioButton({String title = '', String typeNum = ''}) {
    return InkWell(
      onTap: () {
        setState(() {
          CurrentUser.gender = typeNum;
          typeValue = typeNum;
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: AppFonts.t1,
              color: Colors.black,
              fontFamily: "Tajawal",
              fontWeight: FontWeight.w500,
            ),
          ),
          Radio(
            value: typeNum,
            groupValue: typeValue,
            onChanged: (val) {
              CurrentUser.gender = val.toString();
              setState(() {
                typeValue = val.toString();
              });
            },
            fillColor: MaterialStateColor.resolveWith((states) => Colors.green),
            focusColor:
                MaterialStateColor.resolveWith((states) => Colors.green),
          ),
        ],
      ),
    );
  }

  void showYearPicker(BuildContext context) async {
    final int? selectedYear = await showYearPickerDialog(context);
    if (selectedYear != null) {
      final DateTime selectedDate = DateTime(selectedYear);
      final DateFormat formatter = DateFormat('yyyy');
      final String formatted = formatter.format(selectedDate);
      print(formatted); // Output: Selected year as string
    }
  }
}
