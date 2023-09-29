import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/customAppBar.dart';
import 'package:ejazah/components/extentions.dart';
import 'package:ejazah/model/get_notifications_model.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../controller/notifications_controller.dart';
import '../../utils/enums.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  RequestState requestState = RequestState.waiting;
  GetNotificationsModel? getNotificationsModel;
  Future<void> getData() async {
    setState(() => requestState = RequestState.loading);
    final res = await NotificationsController.getNotifications();
    if (res) {
      getNotificationsModel = NotificationsController.getNotificationsModel;
      setState(() => requestState = RequestState.success);
    } else {
      setState(() => requestState = RequestState.error);
    }
    await Future<void>.delayed(Duration(seconds: 3));
    getData();
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
        child: SingleChildScrollView(
            padding: EdgeInsets.only(
              top: size.height * 0.04,
              bottom: size.height * 0.04,
              left: size.height * 0.015,
              right: size.height * 0.015,
            ),
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                CustomAppBar(pageTitle: 'الإشعارات'),
                SizedBox(
                  height: 2.h,
                ),
                Builder(builder: (context) {
                  if (requestState == RequestState.loading &&
                      getNotificationsModel == null)
                    return Center(child: CircularProgressIndicator());
                  if (getNotificationsModel!.data!.notifications!.isEmpty)
                    return Padding(
                      padding: EdgeInsets.only(top: context.getHeight / 2 - 60),
                      child: Text(
                        'لا توجد اشعارات حتى الأن...',
                        style: context.textTheme.titleMedium!.copyWith(
                          color: Colors.amber.shade900,
                        ),
                      ),
                    );
                  if (requestState == RequestState.error)
                    return Center(
                      child: Text(
                        'تأكد من اتصالك بالانرنت',
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  return Container(child: getNotification());
                })
              ],
            )),
      ),
    );
  }

  getNotification() {
    final notifications = getNotificationsModel!.data!.notifications;
    Size size = MediaQuery.of(context).size;

    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, index) {
        final model = notifications![index];
        return InkWell(
          onTap: () async {
            if (model.status == 0) setState(() => model.status = 1);
            NotificationsController.readNotifications(model.id!);
          },
          child: Container(
            padding: EdgeInsets.all(15),
            height: 18.h,
            width: size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: model.status == 1 ? Colors.white : Colors.orange[300],
              boxShadow: [
                new BoxShadow(
                  color: Colors.grey.shade400,
                  offset: const Offset(0, 2.0),
                  blurRadius: 6.0,
                ),
              ],
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    model.subject ?? 'null',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: AppFonts.t3),
                  ),
                  Text(model.createdAt ?? 'null')
                ],
              ),
              SizedBox(
                height: 1.5.h,
              ),
              Expanded(
                flex: 4,
                child: Text(
                  model.message ?? 'null',
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: AppFonts.t4_2),
                ),
              ),
            ]),
          ),
        );
      },
      itemCount: notifications?.length ?? 5,
      separatorBuilder: (context, index) => SizedBox(
        height: 2.5.h,
      ),
    );
  }
}
