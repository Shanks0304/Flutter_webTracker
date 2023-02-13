class DataModel {
  String number;
  String organization;
  String process;
  String source;
  String actionItem;
  String assignee;
  // DateTime startDate;
  // DateTime dueDate;
  String status;
  String history;
  DataModel({
    required this.number,
    required this.status,
    required this.actionItem,
    required this.assignee,
    // required this.dueDate,
    required this.history,
    required this.organization,
    required this.process,
    required this.source,
    // required this.startDate,
  });
}
