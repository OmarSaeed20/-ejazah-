import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/customAppBar.dart';
import 'package:ejazah/Widgets/myNavigate.dart';
import 'package:ejazah/components/components.dart';
import 'package:ejazah/components/extentions.dart';
import 'package:ejazah/controller/add_information_tavel_groups_controller.dart';
import 'package:ejazah/model/home/get_home_model.dart';
import 'package:ejazah/view/home/ads/add_information_events_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../../model/event_type_model.dart';
import '../../../utils/enums.dart';

class AddEventsScreen extends StatefulWidget {
  const AddEventsScreen({super.key});

  @override
  State<AddEventsScreen> createState() => _AddEventsScreenState();
}

class _AddEventsScreenState extends State<AddEventsScreen> {
  GetHomeModel? homeModel;

  final ImagePicker picker = ImagePicker();

  XFile? backIDImage, forwardIDImage;

  String? value = '';
  // List<String> event = ['رحلات برية', 'رحلات بحرية', 'رحلات جوية', 'رحلات صيد'];
  String? _selectedOption;
  EventTypeModel? eventTypeModel;
  RequestState requestState = RequestState.waiting;

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
                  top: size.height * 0.05,
                  bottom: size.height * 0.02,
                  left: size.height * 0.02,
                  right: size.height * 0.02,
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 130),
                            child: CustomAppBar(pageTitle: ''),
                          ),
                          SizedBox(
                            width: 22.w,
                          ),
                          SvgPicture.asset(
                            'assets/svg/Group 36770.svg',
                            width: 20.w,
                            height: 20.h,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        child: Text(
                          'مرحبا بك , لتتمكن من إضافة خدمات واعلانات برجاء امدادنا ببعض  البيانات لاتمام طلبك',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: AppFonts.t3,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            width: size.width,
                            height: 8.h,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 0.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField(
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                isExpanded: true,
                                value: _selectedOption,
                                hint: Text('اختر الفعالية (فعاليات ترفيهية)'),
                                items:
                                    eventTypeModel!.data!.eventType!.map((ele) {
                                  return DropdownMenuItem(
                                    value: ele.id.toString(),
                                    child: Transform.translate(
                                      offset: Offset(0, -7),
                                      child: RadioListTile(
                                        title: Text(
                                          ele.name!,
                                          style: context.textTheme.titleMedium!
                                              .copyWith(
                                            color: Colors.blue,
                                          ),
                                        ),
                                        value: ele.id.toString(),
                                        groupValue: _selectedOption,
                                        onChanged: null,
                                        // hoverColor: Colors.blue,
                                        // fillColor: MaterialStatePropertyAll(Colors.blue),
                                        selectedTileColor: Colors.blue,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  print(value);
                                  setState(
                                      () => _selectedOption = value.toString());

                                  AddInformationTravelGroupsController
                                      .travel_type_id = _selectedOption;
                                  print(AddInformationTravelGroupsController
                                      .travel_type_id);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Container(
                        width: size.width,
                        height: 7.h,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.buttonColor),
                            onPressed: () {
                              if (AddInformationTravelGroupsController
                                      .travel_type_id ==
                                  null) {
                                toastShow(text: 'يرجي اختيار الفعالية اولا');
                                return;
                              }
                              myNavigate(
                                  screen: AddInfoEventsScreen(),
                                  context: context);
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
}
