import 'package:tracker/Models/DataModel.dart';
// import 'package:html/parser.dart' as parser;
// import 'package:http/http.dart' as http;
// import 'package:tracker/ReUse/Data.dart';
import 'package:tracker/ReUse/Assets.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:excel/excel.dart';

List<DataModel> models = [];
List<DataModel> reBranding = [];
List<DataModel> costEfficiency = [];
List<DataModel> sustainability = [];
List<DataModel> peopleDevelopment = [];
List<DataModel> digitization = [];

getData() async {
  try {
    // const url =
    // 'https://oes.aramco.com.sa/ActionItem/Search?org_id=30002897&criteria=%7B%22ShowDetailedColumns%22%3Atrue%2C%22OrgID%22%3A30002897%2C%22Number%22%3Anull%2C%22ProcessID%22%3A%227.1%22%2C%22ElementID%22%3Anull%2C%22Search%22%3Anull%2C%22OwnerID%22%3Anull%2C%22SmeID%22%3Anull%2C%22StartDate%22%3Anull%2C%22DueDate%22%3Anull%2C%22StatusID%22%3Anull%2C%22SourceID%22%3Anull%2C%22PriorityID%22%3Anull%2C%22CriteriaID%22%3Anull%2C%22InitiativeID%22%3Anull%2C%22InitiativePhaseID%22%3Anull%2C%22DeliverableID%22%3Anull%2C%22StepID%22%3Anull%2C%22StepDetailID%22%3Anull%2C%22ProcessAreaOfImprovementID%22%3Anull%2C%22FocusAreaAreaOfImprovementID%22%3Anull%2C%22EmployeeID%22%3Anull%2C%22GroupBy%22%3A%22None%22%2C%22SortBy%22%3A%22Status%22%2C%22SortThenBy%22%3Anull%2C%22FocusAreaID%22%3Anull%2C%22OrgFocusAreaKpiID%22%3Anull%2C%22OrgProcessKpiID%22%3Anull%2C%22IsClosed%22%3Afalse%2C%22IsArchived%22%3Afalse%2C%22AllowOrgChange%22%3Atrue%2C%22AllowProcessChange%22%3Atrue%2C%22AllowFocusAreaChange%22%3Atrue%2C%22AllowAssigneeChange%22%3Atrue%2C%22AllowSourceChange%22%3Atrue%2C%22AllowSearch%22%3Atrue%2C%22ShowTracking%22%3Afalse%7D&html_target=action_items';
    // const url = 'http://localhost:8090/';

    // final response = await http.Client().get(Uri.parse(url));

    // if (response.statusCode == 200) {
    //   var document = parser.parse(response.body);
    //   try {
    //     var element = document.querySelectorAll('table>tbody')[0];
    //     var data = element.querySelectorAll('tr');

    //     models.clear();
    //     reBranding.clear();
    //     costEfficiency.clear();
    //     sustainability.clear();
    //     peopleDevelopment.clear();
    //     digitization.clear();

    //     for (int i = 0; i < data.length; i++) {
    //       // print(data[i].children[0].text.toString().trim());
    //       // print(data[i].children[1].text.toString().trim());
    //       // print(data[i].children[2].text.toString().trim());
    //       // print(data[i].children[3].text.toString().trim());
    //       // print(data[i].children[4].children[0].text.toString().trim());
    //       // print(data[i].children[6].text.toString().trim());
    //       // print(data[i].children[9].text.toString().trim());
    //       // print(data[i].children[11].text.toString().trim());

    //       DataModel model = DataModel(
    //         number: data[i].children[0].text.toString().trim(),
    //         organization: data[i].children[1].text.toString().trim(),
    //         process: data[i].children[2].text.toString().trim(),
    //         source: data[i].children[3].text.toString().trim(),
    //         actionItem: data[i].children[4].children[0].text.toString().trim(),
    //         assignee: data[i].children[6].text.toString().trim(),
    //         status: data[i].children[9].text.toString().trim(),
    //         history: data[i].children[11].text.toString().trim(),
    //       );
    //       models.add(model);
    //       filterData(model);
    //     }
    //   } catch (e) {
    //     return ['', '', 'ERROR!'];
    //   }
    // }

    ByteData byteData = await rootBundle.load(Assets.xlsxfile);
    print(Assets.xlsxfile);

    if (byteData != null) {
      var bytes = byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
      var excel = Excel.decodeBytes(bytes);
      for (var table in excel.tables.keys) {
        if (table.contains('Data')) {
          Sheet? data = excel.tables[table];
          if (data != null) {
            models.clear();
            reBranding.clear();
            costEfficiency.clear();
            sustainability.clear();
            peopleDevelopment.clear();
            digitization.clear();

            for (int row = 0; row < data.maxRows; row++) {
              DataModel model = DataModel(
                number: data
                    .cell(CellIndex.indexByColumnRow(
                        columnIndex: 0, rowIndex: row))
                    .value
                    .toString(),
                organization: data
                    .cell(CellIndex.indexByColumnRow(
                        columnIndex: 1, rowIndex: row))
                    .value
                    .toString(),
                process: data
                    .cell(CellIndex.indexByColumnRow(
                        columnIndex: 2, rowIndex: row))
                    .value
                    .toString(),
                source: data
                    .cell(CellIndex.indexByColumnRow(
                        columnIndex: 3, rowIndex: row))
                    .value
                    .toString(),
                actionItem: data
                    .cell(CellIndex.indexByColumnRow(
                        columnIndex: 4, rowIndex: row))
                    .value
                    .toString(),
                assignee: data
                    .cell(CellIndex.indexByColumnRow(
                        columnIndex: 6, rowIndex: row))
                    .value
                    .toString(),
                status: data
                    .cell(CellIndex.indexByColumnRow(
                        columnIndex: 9, rowIndex: row))
                    .value
                    .toString(),
                history: data
                    .cell(CellIndex.indexByColumnRow(
                        columnIndex: 11, rowIndex: row))
                    .value
                    .toString(),
              );
              models.add(model);
              filterData(model);
            }
          }
        }
      }
    }
  } catch (e) {
    models.clear();
    reBranding.clear();
    costEfficiency.clear();
    sustainability.clear();
    peopleDevelopment.clear();
    digitization.clear();
  }
}

filterData(DataModel value) {
  if (value.process.contains('Re-Branding Strategy')) {
    reBranding.add(value);
  } else if (value.process.contains('Cost Efficiency Strategy')) {
    costEfficiency.add(value);
  } else if (value.process.contains('Sustainability Strategy')) {
    sustainability.add(value);
  } else if (value.process
      .contains('People Development & Engagement Strategy')) {
    peopleDevelopment.add(value);
  } else if (value.process.contains('Digitization Strategy')) {
    digitization.add(value);
  }
}
