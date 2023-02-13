import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracker/ReUse/Data.dart';
import 'package:simple_animations/simple_animations.dart';
import '../Models/DataModel.dart';
import 'package:pie_chart/pie_chart.dart' as pie;
import 'package:flutter_animate/flutter_animate.dart';

int screen = 0;
Color tealColor = Colors.teal.shade400;
Color greyColor = Colors.grey;
Color lightGreyColor = Colors.grey.shade200;
Color darkGreyColor = Colors.grey.shade800;
Color fillColor = const Color(0xe6e3e3e3);
Color blueColor = const Color(0xff436c99);
Color greenColor = const Color(0xff58a08f);
Color lightGreen = Colors.green.shade300;
BorderSide borderSide = BorderSide(color: Colors.black, width: .5.w);

barChartWidget(List<double> data) {
  int touchedIndex = -1;

  MovieTween tween = MovieTween()
    ..scene(
            begin: Duration(milliseconds: 20),
            end: Duration(milliseconds: 800),
            curve: Curves.linear)
        .tween('overdue', Tween(begin: 0, end: data[0] / 2),
            curve: Curves.linear)
    ..scene(
            begin: Duration(milliseconds: 150),
            duration: Duration(milliseconds: 250))
        .tween('notstarted', Tween(begin: 0.0, end: data[1]),
            curve: Curves.linear)
    ..scene(
            begin: Duration(milliseconds: 300),
            duration: Duration(milliseconds: 250))
        .tween('inprogress', Tween(begin: 0.0, end: data[2]),
            curve: Curves.linear)
    ..scene(
            begin: Duration(milliseconds: 250),
            duration: Duration(milliseconds: 250))
        .tween('completed', Tween(begin: 0.0, end: data[3]),
            curve: Curves.linear)
    ..scene(
            begin: Duration(milliseconds: 300),
            duration: Duration(milliseconds: 250))
        .tween('closed', Tween(begin: 0.0, end: data[4]), curve: Curves.linear);
  return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
    return Container(
      margin: EdgeInsets.only(left: 5.w),
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      height: 60.h,
      width: 160.w,
      decoration: BoxDecoration(
        border: Border.all(color: lightGreyColor, width: .5.w),
      ),
      alignment: Alignment.center,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 2.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  barTitle('Overdue'),
                  barTitle('Not Started'),
                  barTitle('In Progress'),
                  barTitle('Completed'),
                  barTitle('Closed'),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: RotatedBox(
                quarterTurns: 1,
                child: PlayAnimationBuilder<Movie>(
                  tween: tween,
                  duration: tween.duration,
                  builder: (context, data_value, child) {
                    return BarChart(
                        swapAnimationDuration:
                            const Duration(milliseconds: 100),
                        swapAnimationCurve: Curves.linear,
                        BarChartData(
                          barTouchData: BarTouchData(
                            touchTooltipData: BarTouchTooltipData(
                              rotateAngle: 270,
                              tooltipPadding: EdgeInsets.all(0),
                              tooltipBgColor: Colors.grey[200],
                              tooltipMargin: 0,
                              getTooltipItem:
                                  (group, groupIndex, rod, rodIndex) {
                                String label;
                                switch (groupIndex) {
                                  case 0:
                                    label = "Overdue";
                                    break;
                                  case 1:
                                    label = "Not started";
                                    break;
                                  case 2:
                                    label = "In Progress";
                                    break;
                                  case 3:
                                    label = "Completed";
                                    break;
                                  case 4:
                                    label = "Closed";
                                    break;
                                  default:
                                    throw Error();
                                }
                                return BarTooltipItem(
                                  "$label\n",
                                  const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: (rod.toY).toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10),
                                    )
                                  ],
                                );
                              },
                            ),
                            touchCallback:
                                (FlTouchEvent event, barTouchResponse) {
                              setState(() {
                                if (!event.isInterestedForInteractions ||
                                    barTouchResponse == null ||
                                    barTouchResponse.spot == null) {
                                  touchedIndex = -1;
                                  return;
                                }
                                touchedIndex =
                                    barTouchResponse.spot!.touchedBarGroupIndex;
                              });
                            },
                            enabled: true,
                          ),
                          alignment: BarChartAlignment.spaceAround,
                          barGroups: bardata(data, data_value, touchedIndex),
                          gridData: FlGridData(show: false),
                          borderData: FlBorderData(show: false),
                          titlesData: FlTitlesData(
                            topTitles: AxisTitles(
                                sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, tileMeta) =>
                                        RotatedBox(
                                          quarterTurns: -1,
                                          child: Text(
                                            value.toStringAsFixed(0),
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 8.sp),
                                          ),
                                        ))),
                            bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                              showTitles: false,
                            )),
                            rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                            leftTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                          ),
                        ));
                  },
                )),
          ),
        ],
      ),
    );
  });
}

valuedPieChartWidget(
    // {required List<PieChartSectionData> sectionData,
    // required List<BarChartGroupData> barChartData,
    // required double percentage,
    // bool border = true}
    {required Map<String, double> sectionData,
    required List<double> barChartData,
    required double percentage,
    bool border = true}) {
  return Column(
    children: [
      Expanded(
        child: Container(
          margin: EdgeInsets.only(top: 5.h),
          padding: EdgeInsets.all(5.sp),
          alignment: Alignment.center,
          width: 130.w,
          decoration: border
              ? BoxDecoration(
                  border: Border(
                      top: borderSide, left: borderSide, right: borderSide))
              : const BoxDecoration(),
          child: Stack(
            alignment: Alignment.center,
            children: [
              pie.PieChart(
                dataMap: sectionData,
                animationDuration: Duration(milliseconds: 800),
                chartRadius: 150.sp,
                ringStrokeWidth: 10,
                colorList: [fillColor, tealColor],
                initialAngleInDegree: 270,
                chartType: pie.ChartType.ring,
                centerText: '${percentage.toInt()}%',
                legendOptions: pie.LegendOptions(
                    showLegends: false, showLegendsInRow: false),
                chartValuesOptions: pie.ChartValuesOptions(
                  showChartValueBackground: false,
                  showChartValues: false,
                ),
              )
              // PieChart(
              //   PieChartData(
              //     sections: sectionData,
              //     sectionsSpace: 0,
              //     startDegreeOffset: 270,
              //     centerSpaceRadius: double.infinity,
              //   ),
              //   swapAnimationDuration: durationTime,
              //   swapAnimationCurve: Curves.elasticIn,
              // ),
              // Text('${percentage.toInt()}%',
              //     style: TextStyle(
              //         color: tealColor,
              //         fontSize: 14.sp,
              //         fontWeight: FontWeight.w900)),
            ],
          ),
        ),
      ),
      barChartWidget(barChartData),
    ],
  );
}

colorCodeDescription(String title, String value, Color color) {
  return Container(
    height: 15.h,
    width: 50.w,
    alignment: Alignment.center,
    decoration: BoxDecoration(color: color),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          title,
          style: TextStyle(
              color:
                  color.computeLuminance() < 0.5 ? Colors.white : Colors.black,
              fontSize: 8.sp),
        ),
        Text(
          value,
          style: TextStyle(
              color:
                  color.computeLuminance() < 0.5 ? Colors.white : Colors.black,
              fontSize: 8.sp),
        ),
      ],
    ),
  );
}

barTitle(String title) {
  return Expanded(
      child: Text(title,
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.black, fontSize: 7.sp)));
}

List<PieChartSectionData> pieChartDataFor(List<DataModel> data) {
  return [
    pieChartSectionData(
        'Open',
        fillColor,
        data
            .where(
                (element) => !element.status.toLowerCase().contains('closed'))
            .length
            .toDouble()),
    pieChartSectionData(
        'Closed',
        tealColor,
        data
            .where((element) => element.status.toLowerCase().contains('closed'))
            .length
            .toDouble())
  ];
}

Map<String, double> pieChartdataFor(List<DataModel> data) {
  double opened_data = data
      .where((element) => !element.status.toLowerCase().contains('closed'))
      .length
      .toDouble();
  double closed_data = data
      .where((element) => element.status.toLowerCase().contains('closed'))
      .length
      .toDouble();

  Map<String, double> dataMap = {
    "Open": opened_data,
    "Close": closed_data,
  };
  return dataMap;
}

PieChartSectionData pieChartSectionData(
    String title, Color color, double data) {
  return PieChartSectionData(
    value: data,
    titleStyle: TextStyle(color: Colors.black, fontSize: 10.sp),
    color: color,
    showTitle: false,
    radius: 15.sp,
  );
}

List<BarChartGroupData> bardata(List<double> data, value, int index) {
  return [
    BarChartGroupData(x: data[0].toInt(), barRods: [
      BarChartRodData(
          toY: value.get('overdue'),
          width: index == 0 ? 12 : 8,
          borderSide:
              index == 0 ? BorderSide(width: 0.5, color: Colors.black87) : null,
          color: Colors.red)
    ]),
    BarChartGroupData(x: data[1].toInt(), barRods: [
      BarChartRodData(
          toY: value.get('notstarted'),
          width: index == 1 ? 12 : 8,
          borderSide:
              index == 1 ? BorderSide(width: 0.5, color: Colors.black87) : null,
          color: Colors.grey)
    ]),
    BarChartGroupData(x: data[2].toInt(), barRods: [
      BarChartRodData(
          toY: value.get('inprogress'),
          width: index == 2 ? 12 : 8,
          borderSide:
              index == 2 ? BorderSide(width: 0.5, color: Colors.black87) : null,
          color: Colors.orange)
    ]),
    BarChartGroupData(x: data[3].toInt(), barRods: [
      BarChartRodData(
          toY: value.get('completed'),
          width: index == 3 ? 12 : 8,
          borderSide:
              index == 3 ? BorderSide(width: 0.5, color: Colors.black87) : null,
          color: Colors.purple)
    ]),
    BarChartGroupData(x: data[4].toInt(), barRods: [
      BarChartRodData(
          toY: value.get('closed'),
          width: index == 4 ? 12 : 8,
          borderSide:
              index == 4 ? BorderSide(width: 0.5, color: Colors.black87) : null,
          color: tealColor)
    ]),
  ];
}

List<double> barChartDataFor(List<DataModel> data) {
  double closed = data
      .where((element) => element.status.toLowerCase().contains('closed'))
      .length
      .toDouble();
  double complete = data
      .where((element) => element.status.toLowerCase().contains('complete'))
      .length
      .toDouble();
  double inProgress = data
      .where((element) => element.status.toLowerCase().contains('in progress'))
      .length
      .toDouble();
  double notStarted = data
      .where((element) => element.status.toLowerCase().contains('not started'))
      .length
      .toDouble();
  double overdue = data
      .where((element) => element.status.toLowerCase().contains('overdue'))
      .length
      .toDouble();
// barChartGroupData(overdue, Colors.red),
//     barChartGroupData(notStarted, Colors.grey),
//     barChartGroupData(inProgress, Colors.orange),
//     barChartGroupData(complete, Colors.purple),
//     barChartGroupData(closed, tealColor),
  return [overdue, notStarted, inProgress, complete, closed];
}

subStrategyCharts(
    {required String title,
    required List<DataModel> data,
    bool showAverage = false}) {
  //List<PieChartSectionData> pieChart = pieChartDataFor(data);
  Map<String, double> dataMap = pieChartdataFor(data);
  List<double> barChart = barChartDataFor(data);

  int closed = data
      .where((element) => element.status.toLowerCase().contains('closed'))
      .length;
  double percentage = 0;
  if (showAverage) {
    percentage += reBranding.isNotEmpty
        ? (reBranding
                .where((element) =>
                    element.status.toLowerCase().contains('closed'))
                .length /
            reBranding.length)
        : 0;
    percentage += costEfficiency.isNotEmpty
        ? (costEfficiency
                .where((element) =>
                    element.status.toLowerCase().contains('closed'))
                .length /
            costEfficiency.length)
        : 0;
    percentage += digitization.isNotEmpty
        ? (digitization
                .where((element) =>
                    element.status.toLowerCase().contains('closed'))
                .length /
            digitization.length)
        : 0;
    percentage += peopleDevelopment.isNotEmpty
        ? (peopleDevelopment
                .where((element) =>
                    element.status.toLowerCase().contains('closed'))
                .length /
            peopleDevelopment.length)
        : 0;
    percentage += sustainability.isNotEmpty
        ? (sustainability
                .where((element) =>
                    element.status.toLowerCase().contains('closed'))
                .length /
            sustainability.length)
        : 0;
    percentage = (percentage / 5) * 100;
  } else {
    percentage = data.isNotEmpty ? (closed / data.length * 100) : 0;
  }
  return Expanded(
    child: Container(
      padding: EdgeInsets.only(bottom: 3.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              margin: EdgeInsets.only(top: 5.h),
              child: Text(title,
                  style: TextStyle(
                      color: greyColor,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold))),
          Container(
              margin: EdgeInsets.only(top: 5.h),
              child: labelWidget(closed, data.length - closed)),
          Expanded(
              child: valuedPieChartWidget(
                  //sectionData: pieChart,
                  sectionData: dataMap,
                  barChartData: barChart,
                  percentage: percentage,
                  border: false))
        ],
      ),
    ),
  );
}

Widget labelWidget(int closed, int open) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      colorCodeDescription('Closed', closed.toString(), tealColor),
      colorCodeDescription('Open', open.toString(), fillColor),
    ],
  );
}

List<DataModel> sortedBySubStrategy(List<DataModel> models, String compare) {
  return models
      .where((element) => element.actionItem.toLowerCase().contains(compare))
      .toList();
}

Widget overAllStatus(
    {required List<DataModel> data,
    required String title,
    bool showAverage = false}) {
  return Card(
    elevation: 2.h,
    color: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.sp)),
    child: SizedBox(
      width: 200.w,
      height: 250.h,
      child: Column(
        children: [
          Container(
            height: 40.h,
            padding: EdgeInsets.only(left: 50.w),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: lightGreyColor, width: 1.5.w))),
            child: Text('Overall Status',
                style: TextStyle(color: tealColor, fontSize: 13.sp)),
          ),
          subStrategyCharts(title: title, data: data, showAverage: showAverage)
          // Expanded(
          //   child: Container(
          //     padding: EdgeInsets.all(5.sp),
          //     alignment: Alignment.topCenter,
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //         Text(title, style: TextStyle(color: greyColor, fontSize: 10.sp, fontWeight: FontWeight.bold)),
          //         labelWidget(),
          //         Expanded(child: valuedPieChartWidget(sectionData: pieChart, barChartData: barChart, border: false)),
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
    ),
  );
}
