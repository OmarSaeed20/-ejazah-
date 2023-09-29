class MarketingTypeModel {
  bool? status;
  String? message;
  Data? data;

  MarketingTypeModel({this.status, this.message, this.data});

  MarketingTypeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<MarkitingType>? markitingType;

  Data({this.markitingType});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['markitingType'] != null) {
      markitingType = <MarkitingType>[];
      json['markitingType'].forEach((v) {
        markitingType!.add(new MarkitingType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.markitingType != null) {
      data['markitingType'] =
          this.markitingType!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MarkitingType {
  int? id;
  String? name;

  MarkitingType({this.id, this.name});

  MarkitingType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
