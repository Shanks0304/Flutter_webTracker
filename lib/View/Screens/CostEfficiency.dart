import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../ReUse/Data.dart';
import '../../ReUse/ReUse.dart';

class CostEfficiency extends StatefulWidget {
  const CostEfficiency({Key? key}) : super(key: key);

  @override
  _CostEfficiencyState createState() => _CostEfficiencyState();
}

class _CostEfficiencyState extends State<CostEfficiency> {
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
              margin: EdgeInsets.only(bottom: 10.h),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  overAllStatus(title: 'Cost Efficiency Overall status', data: costEfficiency),
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

  Widget subStrategicProgress() {
    return Card(
      elevation: 2.h,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.sp)),
      child: SizedBox(
        height: 250.h,
        width: 450.w,
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
                      subStrategyCharts(title: "Value Creation", data: sortedBySubStrategy(costEfficiency, 'value creation')),
                      subStrategyCharts(title: "Cost Intelligence Hub", data: sortedBySubStrategy(costEfficiency, 'cost intelligent hub')),
                      subStrategyCharts(title: "Culture Creation", data: sortedBySubStrategy(costEfficiency, 'culture creation')),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
