import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracker/ReUse/Data.dart';

import '../../ReUse/ReUse.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              clipBehavior: Clip.none,
              margin: EdgeInsets.only(bottom: 10.h),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  overAllStatus(title: 'SAPED Overall status', data: models, showAverage: true),
                  // strategicStatus(),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10.h),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  strategicStatus(),
                  // highlights(),
                  // notifications(),
                  // overdueActions(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget overAllStatus() {
  //   List<PieChartSectionData> data = pieChartDataFor(models);
  //   return Card(
  //     elevation: 2.h,
  //     color: Colors.white,
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.sp)),
  //     child: SizedBox(
  //       width: 250.w,
  //       height: 280.h,
  //       child: Column(
  //         children: [
  //           Container(
  //             height: 40.h,
  //             padding: EdgeInsets.only(left: 50.w),
  //             alignment: Alignment.centerLeft,
  //             decoration: BoxDecoration(border: Border(bottom: BorderSide(color: lightGreyColor, width: 1.5.w))),
  //             child: Text('Overall Status', style: TextStyle(color: tealColor, fontSize: 13.sp)),
  //           ),
  //           Expanded(
  //             child: Container(
  //               padding: EdgeInsets.all(5.sp),
  //               alignment: Alignment.topCenter,
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Text('SAPED Overall status', style: TextStyle(color: greyColor, fontSize: 12.sp, fontWeight: FontWeight.bold)),
  //                   Expanded(child: valuedPieChartWidget(sectionData: data)),
  //                 ],
  //               ),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget highlights() {
  //   return Card(
  //     elevation: 2.h,
  //     color: Colors.white,
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.sp)),
  //     child: SizedBox(
  //       width: 250.w,
  //       height: 280.h,
  //       child: Column(
  //         children: [
  //           Container(
  //             margin: EdgeInsets.only(bottom: 10.h),
  //             height: 40.h,
  //             padding: EdgeInsets.only(left: 50.w),
  //             alignment: Alignment.centerLeft,
  //             decoration: BoxDecoration(border: Border(bottom: BorderSide(color: lightGreyColor, width: 1.5.w))),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [Text('Highlights', style: TextStyle(color: tealColor, fontSize: 13.sp)), Icon(Icons.more_vert, color: darkGreyColor)],
  //             ),
  //           ),
  //           Expanded(
  //             child: Column(
  //               children: [
  //                 highlightsTile(number: '#', item: 'Item', strategy: 'Strategy', date: 'Date', filled: true),
  //                 highlightsTile(number: '1', item: '', strategy: '', date: ''),
  //                 highlightsTile(number: '2', item: '', strategy: '', date: ''),
  //                 highlightsTile(number: '3', item: '', strategy: '', date: ''),
  //                 highlightsTile(number: '4', item: '', strategy: '', date: ''),
  //               ],
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget highlightsTile({required String strategy, required String item, required String number, required String date, bool filled = false}) {
  //   return Container(
  //     height: 30.h,
  //     width: 240.w,
  //     decoration: BoxDecoration(color: filled ? fillColor : Colors.transparent),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Container(margin: EdgeInsets.only(left: 5.w), alignment: Alignment.center, width: 40.w, child: Text(number, style: TextStyle(color: Colors.black, fontSize: 12.sp))),
  //         Container(margin: EdgeInsets.only(left: 5.w), width: 50.w, alignment: Alignment.centerLeft, child: Text(strategy, style: TextStyle(color: Colors.black, fontSize: 12.sp))),
  //         Expanded(child: Container(margin: EdgeInsets.only(left: 5.w), alignment: Alignment.centerLeft, child: Text(item, style: TextStyle(color: Colors.black, fontSize: 12.sp)))),
  //         Container(margin: EdgeInsets.only(left: 5.w), alignment: Alignment.center, width: 60.w, child: Text(date, style: TextStyle(color: Colors.black, fontSize: 12.sp))),
  //       ],
  //     ),
  //   );
  // }

  // Widget notifications() {
  //   return Card(
  //     elevation: 2.h,
  //     color: Colors.white,
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.sp)),
  //     child: SizedBox(
  //       width: 250.w,
  //       height: 280.h,
  //       child: Column(
  //         children: [
  //           Container(
  //             margin: EdgeInsets.only(bottom: 10.h),
  //             height: 40.h,
  //             padding: EdgeInsets.only(left: 50.w),
  //             alignment: Alignment.centerLeft,
  //             decoration: BoxDecoration(border: Border(bottom: BorderSide(color: lightGreyColor, width: 1.5.w))),
  //             child: Text('Notifications', style: TextStyle(color: tealColor, fontSize: 13.sp)),
  //           ),
  //           Expanded(
  //             child: Column(
  //               children: [
  //                 notificationTile(number: '#', item: 'Item', strategy: 'Strategy', date: 'Date', filled: true),
  //                 notificationTile(number: '1', item: '', strategy: '', date: ''),
  //                 notificationTile(number: '2', item: '', strategy: '', date: ''),
  //                 notificationTile(number: '3', item: '', strategy: '', date: ''),
  //                 notificationTile(number: '4', item: '', strategy: '', date: ''),
  //               ],
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget notificationTile({required String strategy, required String item, required String number, required String date, bool filled = false}) {
  //   return Container(
  //     height: 30.h,
  //     width: 240.w,
  //     decoration: BoxDecoration(color: filled ? fillColor : Colors.transparent),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Container(margin: EdgeInsets.only(left: 5.w), alignment: Alignment.center, width: 40.w, child: Text(number, style: TextStyle(color: Colors.black, fontSize: 12.sp))),
  //         Container(margin: EdgeInsets.only(left: 5.w), width: 80.w, alignment: Alignment.centerLeft, child: Text(strategy, style: TextStyle(color: Colors.black, fontSize: 12.sp))),
  //         Expanded(child: Container(margin: EdgeInsets.only(left: 5.w), alignment: Alignment.centerLeft, child: Text(item, style: TextStyle(color: Colors.black, fontSize: 12.sp)))),
  //         Container(margin: EdgeInsets.only(left: 5.w), alignment: Alignment.center, width: 60.w, child: Text(date, style: TextStyle(color: Colors.black, fontSize: 12.sp))),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget overdueActions() {
  //   return Card(
  //     elevation: 2.h,
  //     color: Colors.white,
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.sp)),
  //     child: SizedBox(
  //       width: 395.w,
  //       height: 280.h,
  //       child: Column(
  //         children: [
  //           Container(
  //             margin: EdgeInsets.only(bottom: 10.h),
  //             height: 40.h,
  //             padding: EdgeInsets.only(left: 50.w),
  //             alignment: Alignment.centerLeft,
  //             decoration: BoxDecoration(border: Border(bottom: BorderSide(color: lightGreyColor, width: 1.5.w))),
  //             child: Text('Overdue Actions', style: TextStyle(color: tealColor, fontSize: 13.sp)),
  //           ),
  //           Expanded(
  //             child: Column(
  //               children: [
  //                 overdueActionTile(referral1: "REF#", referral2: "REF#", referral3: "REF#", etc: "ETC", filled: true),
  //               ],
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget overdueActionTile({required String referral1, required String referral2, required String referral3, required String etc, bool filled = false}) {
  //   return Container(
  //     height: 30.h,
  //     width: 390.w,
  //     decoration: BoxDecoration(color: filled ? fillColor : Colors.transparent),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Expanded(child: Container(margin: EdgeInsets.only(left: 5.w), alignment: Alignment.centerLeft, child: Text(referral1, style: TextStyle(color: Colors.black, fontSize: 12.sp)))),
  //         Expanded(child: Container(margin: EdgeInsets.only(left: 5.w), width: 80.w, alignment: Alignment.center, child: Text(referral2, style: TextStyle(color: Colors.black, fontSize: 12.sp)))),
  //         Expanded(child: Container(margin: EdgeInsets.only(left: 5.w), alignment: Alignment.centerRight, child: Text(referral3, style: TextStyle(color: Colors.black, fontSize: 12.sp)))),
  //         Container(margin: EdgeInsets.only(left: 5.w), alignment: Alignment.centerLeft, width: 50.w, child: Text(etc, style: TextStyle(color: Colors.black, fontSize: 12.sp))),
  //       ],
  //     ),
  //   );
  // }

  Widget strategicStatus() {
    return Card(
      elevation: 2.h,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.sp)),
      child: SizedBox(
        height: 250.h,
        width: 750.w,
        child: Column(
          children: [
            Container(
              height: 40.h,
              padding: EdgeInsets.only(left: 50.w),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: lightGreyColor, width: 1.5.w))),
              child: Text('Strategies Progress Status', style: TextStyle(color: tealColor, fontSize: 13.sp)),
            ),
            Expanded(
              child: Row(
                children: [
                  subStrategyCharts(title: "Re-Branding", data: reBranding),
                  subStrategyCharts(title: "Cost Efficiency", data: costEfficiency),
                  subStrategyCharts(title: "Sustainability", data: sustainability),
                  subStrategyCharts(title: "People Development & Engagement", data: peopleDevelopment),
                  subStrategyCharts(title: "Digitalization", data: digitization),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
