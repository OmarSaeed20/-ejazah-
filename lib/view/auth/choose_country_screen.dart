import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/customAppBar.dart';
import 'package:ejazah/Widgets/custom_text.dart';
import 'package:ejazah/Widgets/myNavigate.dart';
import 'package:ejazah/components/components.dart';
import 'package:ejazah/constants/api_paths.dart';
import 'package:ejazah/controller/auth/user_controller.dart';
import 'package:ejazah/database/local/cache_helper.dart';
import 'package:ejazah/model/register_models/get_countries_model.dart';
import 'package:ejazah/utils/enums.dart';
import 'package:ejazah/view/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../controller/auth/get_countries_controller.dart';

class ChooseCountryScreen extends StatefulWidget {
  const ChooseCountryScreen({super.key});

  @override
  State<ChooseCountryScreen> createState() => _ChooseCountryScreenState();
}

class _ChooseCountryScreenState extends State<ChooseCountryScreen> {
  bool processing = false;
  bool value = false;
  int countryValue = 1;
  RequestState requestState = RequestState.waiting;
  RequestState requestStateButton = RequestState.waiting;
  late final int len;
  List<Countries>? country;
  @override
  void initState() {
    requestState = RequestState.loading;
    GetCountries.getCountries().then((value) {
      if (value) {
        len = GetCountries.getCountriesModel!.data!.countries!.length;
        country = GetCountries.getCountriesModel!.data!.countries;
        requestState = RequestState.success;
      } else {
        requestState = RequestState.error;
      }

      setState(() {});
    });
    super.initState();
    setState(() {
      CurrentUser.countryId = countryValue.toString();
    });
  }

  Future<bool> onSelectedCountry(String id) async {
    log("-------> ${CurrentUser.token}");
    setState(() {
      processing = true;
    });

    log(CurrentUser.token.toString());
    var url = ApiPath.baseurl + ApiPath.changeCountry;
    var data = {
      "country_id": id,
    };
    try {
      var resbody = await Dio().post(
        url,
        data: data,
        options: Options(
          headers: {'Authorization': CurrentUser.token},
        ),
      );
      setState(() {
        processing = false;
      });

      print(resbody.toString());
      if (resbody.data.isNotEmpty) {
        print(resbody);

        if (resbody.data['status'] == true) {
          toastShow(text: resbody.data['message'], state: ToastStates.black);
        } else {
          toastShow(text: resbody.data['message'], state: ToastStates.black);
          return false;
        }

        return true;
      }
    } catch (e) {
      print("error");
      print(e);
      setState(() {
        processing = false;
      });
    }
    return false;
  }

  String? _countryValue;
  String? code;
  String? flag;
  Countries? selectedCounty;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: size.height * 0.025,
            bottom: size.height * 0.050,
            left: size.height * 0.020,
            right: size.height * 0.020,
          ),
          child: Column(
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: CustomAppBar(pageTitle: '')),
              SvgPicture.asset(
                'assets/svg/Group 36770.svg',
                width: 20.w,
                height: 20.h,
              ),
              SizedBox(
                height: 8.h,
              ),
              CustomText(
                text: 'برجاء اختيار الدولة',
                color: Colors.black,
                fontSize: AppFonts.t2,
                fontweight: FontWeight.bold,
              ),
              SizedBox(height: 2.0.h),
              if (requestState == RequestState.loading)
                CircularProgressIndicator(),
              if (country != null && requestState == RequestState.success)
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    margin: EdgeInsets.all(4),
                    width: size.width,
                    height: 7.0.h,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 0.5),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<Countries>(
                        hint: Text(
                          selectedCounty?.name == null
                              ? 'اختر الدولة'
                              : '${selectedCounty?.name}',
                          style: TextStyle(
                            fontSize: AppFonts.t3,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        isExpanded: true,
                        items: country!.map(
                          (element) {
                            return DropdownMenuItem<Countries>(
                              value: element,
                              child: Row(
                                children: [
                                  Text('${element.name}'),
                                  Spacer(),
                                  Image.network(
                                    '${element.flag}',
                                    height: 4.5.h,
                                    width: 4.5.h,
                                  ),
                                ],
                              ),
                            );
                          },
                        ).toList(),
                        onChanged: (value) async {
                          selectedCounty = value;
                          log('${value?.name}');
                          _countryValue = '${value?.id}';

                          await CacheHelper.saveData(
                              key: "country_id", value: '${value?.id}');
                          await CacheHelper.saveData(
                              key: "flag", value: '${value?.flag}');
                              await CacheHelper.saveData(
                              key: "code", value: '${value?.code}');
                          CurrentUser.countryId = '${_countryValue}';
                          CurrentUser.country = '${value?.name}';
                          log("------------> ${CurrentUser.country}");
                          setState(() {});
                        },
                      ),
                    )),
              if ((country == null && requestState != RequestState.loading) ||
                  requestState == RequestState.error)
                Text(
                  'حدث خطأ يرجى المحاولة مرة اخرى لاحقا...',
                  style: context.textTheme.titleMedium!
                      .copyWith(color: Colors.red),
                ),
              SizedBox(height: 80),
              Container(
                width: size.width,
                height: 6.5.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.buttonColor),
                  onPressed: () async {
                    log("------------> ${CurrentUser.countryId}");

                    if (_countryValue == null) {
                      toastShow(text: 'إختر المدينة أولا');
                    } else {
                      if (processing) return;
                      final isSuccess =
                          await onSelectedCountry(CurrentUser.countryId);
                      if (isSuccess) {
                        myNavigate(
                          screen: HomeScreen(isChanged: true),
                          context: context,
                          withBackButton: false,
                        );
                      }
                    }
                  },
                  child: Builder(
                    builder: (context) {
                      if (processing)
                        return SizedBox(
                          height: 25,
                          width: 25,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        );
                      return CustomText(
                        text: "التـالي",
                        fontSize: AppFonts.t2,
                        color: Colors.white,
                        fontweight: FontWeight.bold,
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  CustomRadioButton(String title, int countryNum) {
    return InkWell(
      onTap: () {
        setState(() {
          countryValue = countryNum;
          CurrentUser.countryId = countryNum.toString();
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: AppFonts.t2,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          Radio(
            value: countryNum,
            groupValue: countryValue,
            onChanged: (val) {
              setState(() {
                countryValue = val!;
                CurrentUser.countryId = countryValue.toString();
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
}
