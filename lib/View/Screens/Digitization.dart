import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../ReUse/Data.dart';
import '../../ReUse/ReUse.dart';

class Digitization extends StatefulWidget {
  const Digitization({Key? key}) : super(key: key);

  @override
  _DigitizationState createState() => _DigitizationState();
}

class _DigitizationState extends State<Digitization> {
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
                  overAllStatus(title: 'Digitalization Overall status', data: digitization),
                  // subStrategicProgress(),
                  // timeLineRoad(),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10.h),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  subStrategicProgress(),
                  // actionPlan(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget overAllStatus() {
  //   List<PieChartSectionData> data = pieChartDataFor(digitization);
  //   List<BarChartGroupData> barChart = barChartDataFor(digitization);
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
  //                   Text('Digitization Overall status', style: TextStyle(color: greyColor, fontSize: 12.sp, fontWeight: FontWeight.bold)),
  //                   Expanded(child: valuedPieChartWidget(sectionData: data, barChartData: barChart)),
  //                 ],
  //               ),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget subStrategicProgress() {
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
              child: Text('Sub-Strategies Progress Status', style: TextStyle(color: tealColor, fontSize: 13.sp)),
            ),
            Expanded(
              child: Container(
                  padding: EdgeInsets.all(5.sp),
                  alignment: Alignment.topCenter,
                  child: Row(
                    children: [
                      subStrategyCharts(title: "Production Optimization", data: sortedBySubStrategy(digitization, 'production optimization')),
                      subStrategyCharts(title: "Administrative Compilance Tools", data: sortedBySubStrategy(digitization, 'administrative compliance tools')),
                      subStrategyCharts(title: "Remote Assistance & Virtual", data: sortedBySubStrategy(digitization, 'remote assistance & virtual')),
                      subStrategyCharts(title: "Data Validity/Reliability", data: sortedBySubStrategy(digitization, 'data validity/reliability')),
                      subStrategyCharts(title: "Well Integrity Assurance", data: sortedBySubStrategy(digitization, 'well integrity assurance')),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  // subStrategyCharts(String title) {
  //   return Expanded(
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Text(title, style: TextStyle(color: greyColor, fontSize: 12.sp, fontWeight: FontWeight.bold)),
  //         filledPieChartWidget(),
  //         barChartWidget(),
  //       ],
  //     ),
  //   );
  // }

  // Widget timeLineRoad() {
  //   return Card(
  //     elevation: 2.h,
  //     color: Colors.white,
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.sp)),
  //     child: SizedBox(
  //       width: 450.w,
  //       height: 280.h,
  //       child: Column(
  //         children: [
  //           Container(
  //             height: 40.h,
  //             padding: EdgeInsets.only(left: 50.w),
  //             alignment: Alignment.centerLeft,
  //             decoration: BoxDecoration(border: Border(bottom: BorderSide(color: lightGreyColor, width: 1.5.w))),
  //             child: Text('Timeline/Roadmap', style: TextStyle(color: tealColor, fontSize: 13.sp)),
  //           ),
  //           Expanded(
  //             child: Container(
  //               padding: EdgeInsets.all(5.sp),
  //               alignment: Alignment.topCenter,
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget actionPlan() {
  //   return Card(
  //     elevation: 2.h,
  //     color: Colors.white,
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.sp)),
  //     child: SizedBox(
  //       width: 1365.w,
  //       height: 280.h,
  //       child: Column(
  //         children: [
  //           Container(
  //             margin: EdgeInsets.only(bottom: 10.h),
  //             height: 40.h,
  //             padding: EdgeInsets.only(left: 50.w),
  //             alignment: Alignment.centerLeft,
  //             decoration: BoxDecoration(border: Border(bottom: BorderSide(color: lightGreyColor, width: 1.5.w))),
  //             child: Text('Action Plan', style: TextStyle(color: tealColor, fontSize: 13.sp)),
  //           ),
  //           Expanded(
  //             child: Column(
  //               children: [
  //                 actionPlanTile(
  //                     referral1: "REF#",
  //                     referral2: "REF#",
  //                     referral3: "REF#",
  //                     referral4: "REF#",
  //                     referral5: "REF#",
  //                     referral6: "REF#",
  //                     overdue: "Overdue",
  //                     completionStatus: "Complettion Status",
  //                     etc: "ETC",
  //                     filled: true),
  //               ],
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget actionPlanTile(
  //     {required String referral1,
  //     required String referral2,
  //     required String referral3,
  //     required String referral4,
  //     required String referral5,
  //     required String referral6,
  //     required String overdue,
  //     required String completionStatus,
  //     required String etc,
  //     bool filled = false}) {
  //   return Container(
  //     height: 30.h,
  //     width: 1365.w,
  //     decoration: BoxDecoration(color: filled ? fillColor : Colors.transparent),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Container(margin: EdgeInsets.only(left: 5.w), width: 50.w, alignment: Alignment.centerLeft, child: Text(referral1, style: TextStyle(color: Colors.black, fontSize: 12.sp))),
  //         Expanded(child: Container(margin: EdgeInsets.only(left: 5.w), alignment: Alignment.center, child: Text(referral2, style: TextStyle(color: Colors.black, fontSize: 12.sp)))),
  //         Expanded(child: Container(margin: EdgeInsets.only(left: 5.w), alignment: Alignment.center, child: Text(referral3, style: TextStyle(color: Colors.black, fontSize: 12.sp)))),
  //         Expanded(child: Container(margin: EdgeInsets.only(left: 5.w), alignment: Alignment.center, child: Text(referral4, style: TextStyle(color: Colors.black, fontSize: 12.sp)))),
  //         Expanded(child: Container(margin: EdgeInsets.only(left: 5.w), alignment: Alignment.center, child: Text(referral5, style: TextStyle(color: Colors.black, fontSize: 12.sp)))),
  //         Expanded(child: Container(margin: EdgeInsets.only(left: 5.w), alignment: Alignment.centerRight, child: Text(referral6, style: TextStyle(color: Colors.black, fontSize: 12.sp)))),
  //         Container(margin: EdgeInsets.only(left: 5.w), width: 80.w, alignment: Alignment.center, child: Text(etc, style: TextStyle(color: Colors.black, fontSize: 12.sp))),
  //         Container(margin: EdgeInsets.only(left: 5.w), width: 80.w, alignment: Alignment.center, child: Text(overdue, style: TextStyle(color: Colors.black, fontSize: 12.sp))),
  //         Container(margin: EdgeInsets.only(left: 5.w), alignment: Alignment.centerLeft, width: 100.w, child: Text(completionStatus, style: TextStyle(color: Colors.black, fontSize: 12.sp))),
  //       ],
  //     ),
  //   );
  // }

  bool loading = false;
  Widget topBar() {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h, right: 10.w),
      height: 60.h,
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: lightGreyColor, width: 2.w))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          loading ? Expanded(child: LinearProgressIndicator(color: tealColor, backgroundColor: lightGreyColor)) : Container(),
          Container(
            margin: EdgeInsets.only(left: 50.w),
            child: ElevatedButton(
              onPressed: loading
                  ? null
                  : () async {
                      loading = true;
                      setState(() {});
                      await getData();
                      setState(() {});
                    },
              style: ElevatedButton.styleFrom(backgroundColor: tealColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.sp))),
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
