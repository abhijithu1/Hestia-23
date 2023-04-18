import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:hestia_23/Schedule/controller/schedule_controller.dart';
import 'package:hestia_23/events/models/event.dart';
import 'package:intl/intl.dart';

class Schedule extends StatelessWidget {
  Schedule({super.key});

  final ScheduleController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: h * 0.08,
              width: double.infinity,
            ),
            Text(
              "Schedule",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              height: h * 0.05,
              width: double.infinity,
            ),
            SizedBox(
              height: h * 0.09,
              child: Center(
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Dates(
                    date: controller.dates[index],
                    index: index,
                    controller: controller,
                  ),
                  itemCount: 4,
                ),
              ),
            ),
            SizedBox(
              height: h * 0.07,
              width: double.infinity,
            ),
            Obx(
              () => Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) => TimeLineofEvents(
                    event: controller.events[index],
                  ),
                  itemCount: controller.events.length,
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: SizedBox(
          height: h * 0.1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.home_outlined),
                color: Colors.white,
                disabledColor: Colors.grey,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.format_list_bulleted),
                color: Colors.white,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.menu),
                color: Colors.white,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.person),
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Full EventSchedule with Line and images
class TimeLineofEvents extends StatelessWidget {
  const TimeLineofEvents({super.key, required this.event});

  final EventModel event;

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTimeLine(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${DateFormat('h:mm a').format(event.eventStart!)}",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(
                height: h * 0.03,
              ),
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                height: h * 0.2,
                width: w * 0.6,
                child: Image(
                  image: NetworkImage(event.image!),
                  fit: BoxFit.fill,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

//Conatiner for date box
class Dates extends StatelessWidget {
  const Dates(
      {super.key,
      required this.date,
      required this.index,
      required this.controller});
  final int index;
  final ScheduleDate date;
  final ScheduleController controller;

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        controller.setdate(index);
      },
      child: Obx(
        () => Container(
          margin: EdgeInsets.symmetric(horizontal: w * 0.04),
          height: h * 0.09,
          width: w * 0.15,
          decoration: BoxDecoration(
              color: controller.selectedDateIndex.value == index
                  ? Colors.white
                  : null,
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "${date.date}",
                style: TextStyle(
                    color: controller.selectedDateIndex.value == index
                        ? Colors.black
                        : Colors.white),
              ),
              Text(
                "${date.day}",
                style: TextStyle(
                    color: controller.selectedDateIndex.value == index
                        ? Colors.black
                        : Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//Custom Line with circular end
class CustomTimeLine extends StatelessWidget {
  const CustomTimeLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Container(
      height: h * 0.3,
      width: w * 0.2,
      child: CustomPaint(
        painter: LineCircle(),
      ),
    );
  }
}

class LineCircle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 3
      ..color = Colors.grey
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
        Offset(size.width / 2, size.height * 0.03), size.height * 0.03, paint);
    canvas.drawLine(Offset(size.width / 2, 2 * size.height * 0.01),
        Offset(size.width / 2, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
