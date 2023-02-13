import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracker/Models/Model.dart';
import 'package:tracker/ReUse/Assets.dart';
import 'package:tracker/View/Screens/CostEfficiency.dart';
import 'package:tracker/View/Screens/Dashboard.dart';
import 'package:tracker/View/Screens/Digitization.dart';
import 'package:tracker/View/Screens/PeopleDevelopment.dart';
import 'package:tracker/View/Screens/ReBranding.dart';
import 'package:tracker/View/Screens/Sustainability.dart';
import 'dart:async';
import 'dart:math' as Math;

import '../ReUse/Data.dart';
import '../ReUse/ReUse.dart';

class View extends StatefulWidget {
  const View({Key? key}) : super(key: key);
  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<View> with TickerProviderStateMixin {
  List<ScreenModel> screens = [
    ScreenModel(id: 0, widget: const Dashboard()),
    ScreenModel(id: 1, widget: const ReBranding()),
    ScreenModel(id: 2, widget: const CostEfficiency()),
    ScreenModel(id: 3, widget: const Sustainability()),
    ScreenModel(id: 4, widget: const PeopleDevelopment()),
    ScreenModel(id: 5, widget: const Digitization()),
  ];

  Widget child = Container();

  /// declare a cound variable with initial value
  // int count = 0;

  /// declare a timer
  Timer? timer;

  bool loading = false;
  UniqueKey key = UniqueKey();

  late List<AnimationController> _controller;

  @override
  void initState() {
    // TODO: implement initState
    child = screens.first.widget;
    screen = screens.first.id;
    super.initState();

    // flip animations
    _controller = List.generate(
        6,
        (i) => AnimationController(
            vsync: this,
            duration: const Duration(milliseconds: 300),
            value: 0));

    // // first run getData
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncGetData();
    });

    /// Initialize a periodic timer with 1 unit(hour/minutes/second) duration
    timer = Timer.periodic(
      const Duration(seconds: 30),
      (timer) async {
        /// callback will be executed every 1 unit(hour/minutes/seconds), increament a count value
        /// on each callback
        _asyncGetData();
      },
    );
  }

  _asyncGetData() async {
    setState(() {
      loading = true;
    });

    await getData();
    key = UniqueKey();

    setState(() {
      loading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 200.w,
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              color: tealColor,
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 20.h),
                  padding: EdgeInsets.only(left: 30.w),
                  alignment: Alignment.center,
                  height: 70.h,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(color: lightGreyColor, width: 5.w))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: 40.h,
                          alignment: Alignment.center,
                          child: Image.asset(
                            Assets.logo,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Strategies Tracking',
                          style:
                              TextStyle(color: Colors.white, fontSize: 14.sp),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      listItems('Dashboard', Assets.dashboard, screen == 0, 0),
                      listItems('Re-Branding', Assets.branding, screen == 1, 1),
                      listItems('Cost Efficiency', Assets.cost, screen == 2, 2),
                      listItems(
                          'Sustainability', Assets.sustain, screen == 3, 3),
                      listItems('People Development and Engagement ',
                          Assets.employee, screen == 4, 4),
                      listItems('Digitalization', Assets.digitization,
                          screen == 5, 5),
                    ],
                  ),
                ),
                // Container(
                //   margin: EdgeInsets.symmetric(vertical: 5.h),
                //   alignment: Alignment.center,
                //   child: ElevatedButton(
                //       onPressed: () async {
                //         loading = true;
                //         setState(() {});
                //         await getData();
                //         loading = false;
                //         key = UniqueKey();
                //         setState(() {});
                //       },
                //       style: ElevatedButton.styleFrom(
                //           backgroundColor: Colors.white,
                //           disabledBackgroundColor: Colors.grey,
                //           shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(15.sp))),
                //       child: Text(
                //         models.isEmpty ? 'Add Data' : 'Refresh Data',
                //         style: TextStyle(color: tealColor, fontSize: 10.sp),
                //       )),
                // )
              ],
            ),
          ),
          Container(
            key: key,
            width: 760.w,
            padding: EdgeInsets.only(left: 2.w),
            alignment: Alignment.topLeft,
            child: //models.isEmpty
                // ? Center(
                //     child: Text(
                //       'Connecting to the Server... \n \n If it does not appear after 30 seconds, know that the server is down or has changed and contact us.',
                //       textAlign: TextAlign.center,
                //       style: TextStyle(color: darkGreyColor, fontSize: 13.sp),
                //     ),
                //   )
                //:
                child,
          )
        ],
      ),
    );
  }

  Widget listItems(String title, String asset, bool selected, int id) {
    return InkWell(
      onTap: () async {
        if (screens.any((element) => element.id == id)) {
          screen = id;
          child = screens.firstWhere((element) => element.id == id).widget;
          setState(() {});

          await _controller[id].forward();
          await _controller[id].reverse();
        }
      },
      child: Container(
        height: 55.h,
        margin: EdgeInsets.only(left: 10.w, bottom: 10.h),
        decoration: BoxDecoration(
            color: selected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.sp),
                bottomLeft: Radius.circular(30.sp))),
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
                animation: _controller[id],
                builder: (context, child) {
                  return Transform(
                      transform: Matrix4.rotationY(
                          (_controller[id].value) * Math.pi / 2),
                      alignment: Alignment.center,
                      child: Container(
                          alignment: Alignment.center,
                          height: 45.h,
                          width: 45.w,
                          padding: EdgeInsets.all(10.sp),
                          decoration: BoxDecoration(
                              color: tealColor, shape: BoxShape.circle),
                          child: selected
                              ? Image.asset(
                                  asset,
                                  fit: BoxFit.contain,
                                  color: Colors.white,
                                )
                              : Image.asset(
                                  asset,
                                  fit: BoxFit.contain,
                                  color: Colors.white,
                                )));
                }),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 5.w),
                child: Text(
                  title,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                      color: selected ? greyColor : Colors.white,
                      fontSize: 12.sp,
                      fontWeight:
                          selected ? FontWeight.bold : FontWeight.normal),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget topBar() {
    return Container(
      margin: EdgeInsets.only(bottom: 5.h, right: 10.w),
      height: 40.h,
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: lightGreyColor, width: 2.w))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          loading
              ? Expanded(
                  child: LinearProgressIndicator(
                      color: tealColor, backgroundColor: lightGreyColor))
              : Container(),
          Container(
            margin: EdgeInsets.only(left: 50.w),
            child: ElevatedButton(
              onPressed: loading
                  ? null
                  : () async {
                      loading = true;
                      setState(() {});
                      await getData();
                      loading = false;
                      key = UniqueKey();
                      setState(() {});
                    },
              style: ElevatedButton.styleFrom(
                  backgroundColor: tealColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.sp))),
              child: Text(
                'Get Data',
                style: TextStyle(color: Colors.white, fontSize: 10.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
