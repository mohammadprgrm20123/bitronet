class ResponseModel {
  int msgID;
  String? msgName;
  String? msgDescription;
  dynamic msgData;

  ResponseModel(
      {required this.msgID, this.msgName, this.msgDescription, this.msgData});

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      msgID: json['msgID'],
      msgName: json['msgName'],
      msgDescription: json['msgDescription'],
      msgData: json['msgData'],
    );
  }
}
