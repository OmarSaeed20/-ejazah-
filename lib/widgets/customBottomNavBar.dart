// ignore_for_file: must_be_immutable

import 'package:ejazah/Widgets/app_svg.dart';
import 'package:ejazah/Widgets/myNavigate.dart';
import 'package:ejazah/view/chat/chat_home_screen.dart';
import 'package:ejazah/view/home/ads/add_ads_screen.dart';
import 'package:ejazah/view/home/home_screen.dart';
import 'package:ejazah/view/home/show_more_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../view/home/on_refresh_screen.dart';

class CustomBottomNavBar extends StatefulWidget {
  CustomBottomNavBar({super.key, required this.navigationTabsIndex});

  final int? navigationTabsIndex;

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return CustomBottomNavBar(context, widget.navigationTabsIndex!);
  }

  Widget CustomBottomNavBar(BuildContext context, int navigationTabsIndex) {
    return Container(
      child: BottomNavigationBar(
        onTap: (value) {
          if (value == navigationTabsIndex) return;
          setState(() {
            navigationTabsIndex = value;
          });
          myNavigate(
              screen: Builder(builder: (context) {
                switch (value) {
                  case 0:
                    return HomeScreen();
                  case 1:
                    return OnRefreshScreen();
                  case 2:
                    return AddAdsScreen();
                  case 3:
                    return ChatHomeScreen();
                }
                return ShowMoreScreen();
              }),
              context: context,
              withBackButton: value != 2 ? false : true);
        },
        type: BottomNavigationBarType.fixed,
        currentIndex: navigationTabsIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              navigationTabsIndex == 0
                  ? AppSvgImages.home_boldIc
                  : AppSvgImages.homeIc,
              width: 25,
              height: 25,
            ),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              navigationTabsIndex == 1
                  ? AppSvgImages.myBookingsIc
                  : AppSvgImages.myBookingsIc,
              width: 25,
              height: 25,
              color: navigationTabsIndex == 1 ? Colors.orange.shade900 : null,
            ),
            label: 'حجوزاتي',
          ),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppSvgImages.addIc,
                width: 40,
                height: 40,
              ),
              label: ''),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              navigationTabsIndex == 3
                  ? AppSvgImages.messages_boldIc
                  : AppSvgImages.messagesIc,
              width: 25,
              height: 25,
            ),
            label: 'الرسائل',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              navigationTabsIndex == 4
                  ? AppSvgImages.profile_boldIc
                  : AppSvgImages.profileIc,
              width: 25,
              height: 25,
            ),
            label: 'المزيد',
          ),
        ],
      ),
    );
  }
}
