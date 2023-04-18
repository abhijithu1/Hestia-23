import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hestia_23/Schedule/views/Schedule.dart';
import 'package:hestia_23/events/views/event_details_screen.dart';
import 'package:hestia_23/events/views/events_screen.dart';
import 'package:hestia_23/home/views/home_screen.dart';
import 'package:hestia_23/profile/views/profile_screen.dart';

import '../../home/views/notification_screen.dart';
import '../controllers/navbar_controller.dart';

class NavBarPage extends StatelessWidget {
  NavBarPage({Key? key}) : super(key: key);

  var pages = [HomeScreen(), Schedule(), NotificationScreen(), ProfileScreen()];

  final navController = Get.put(NavBarController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    double navHeight = height * 0.063;

    return Scaffold(
        body: SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          //pageview

          SizedBox(
            width: width,
            height: height,
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: navController.controller,
              children: pages,
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.06, vertical: height * 0.006),
                child: Container(
                  height: height * 0.065,
                  decoration: BoxDecoration(
                    color: const Color(0xff111111),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Obx(
                        () => buildNavIcons(
                          navHeight: navHeight,
                          index: 0,
                          selectedIcon: const Icon(Icons.home_filled),
                          unselectedIcon: const Icon(Icons.home_outlined),
                        ),
                      ),
                      Obx(
                        () => buildNavIcons(
                          navHeight: navHeight,
                          index: 1,
                          selectedIcon:
                              const Icon(Icons.calendar_today_rounded),
                          unselectedIcon:
                              const Icon(Icons.calendar_today_outlined),
                        ),
                      ),
                      Obx(
                        () => buildNavIcons(
                            navHeight: navHeight,
                            index: 2,
                            selectedIcon: const Icon(Icons.notifications),
                            unselectedIcon:
                                const Icon(Icons.notifications_none_outlined)),
                      ),
                      Obx(() => buildNavIcons(
                            navHeight: navHeight,
                            index: 3,
                            selectedIcon: const Icon(Icons.person),
                            unselectedIcon:
                                const Icon(Icons.person_outline_rounded),
                          ))
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    ));
  }

  InkWell buildNavIcons(
      {required double navHeight,
      required Icon selectedIcon,
      required Icon unselectedIcon,
      required int index}) {
    return InkWell(
      onTap: () {
        navController.changePage(index, navController.controller);
        navController.index.value = index;
      },
      child: SizedBox(
          width: navHeight,
          height: navHeight,
          child: (navController.index.value == index)
              ? selectedIcon
              : unselectedIcon),
    );
  }
}

//TODO: this is only a sample nav bar for testing, need to rebuild it ,also need to change the icons and ripple effects
