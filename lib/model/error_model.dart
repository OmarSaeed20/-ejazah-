class ErrorRegisterModel {
  bool? status;
  String? number;
  String? message;

  ErrorRegisterModel({this.status, this.number, this.message});

  ErrorRegisterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    number = json['number'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['number'] = this.number;
    data['message'] = this.message;
    return data;
  }
}
