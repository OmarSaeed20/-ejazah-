class GetWalletModel {
  bool? status;
  String? message;
  Data? data;

  GetWalletModel({this.status, this.message, this.data});

  GetWalletModel.fromJson(Map<String, dynamic> json) {
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
  int? total;
  List<Wallets>? wallets;

  Data({this.total, this.wallets});

  Data.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['wallets'] != null) {
      wallets = <Wallets>[];
      json['wallets'].forEach((v) {
        wallets!.add(new Wallets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    if (this.wallets != null) {
      data['wallets'] = this.wallets!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Wallets {
  String? desc;
  String? date;

  Wallets({this.desc, this.date});

  Wallets.fromJson(Map<String, dynamic> json) {
    desc = json['desc'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['desc'] = this.desc;
    data['date'] = this.date;
    return data;
  }
}
