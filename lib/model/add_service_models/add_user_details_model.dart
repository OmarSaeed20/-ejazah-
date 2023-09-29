class AddUserDetailsModel {
  bool? status;
  int? number;
  String? message;

  AddUserDetailsModel({this.status, this.number, this.message});

  AddUserDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    number = json['number'];
    message = json['message'];
  }
}
