class GetPaymentMethodsModel {
  final bool? status;
  final String? message;
  final List<PaymentMethods>? data;
  const GetPaymentMethodsModel({this.status, this.message, this.data});
  GetPaymentMethodsModel copyWith(
      {bool? status, String? message, List<PaymentMethods>? data}) {
    return GetPaymentMethodsModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data);
  }

  Map<String, Object?> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.map<Map<String, dynamic>>((data) => data.toJson()).toList()
    };
  }

  static GetPaymentMethodsModel fromJson(Map<String, Object?> json) {
    return GetPaymentMethodsModel(
        status: json['status'] == null ? null : json['status'] as bool,
        message: json['message'] == null ? null : json['message'] as String,
        data: json['data'] == null
            ? null
            : (json['data'] as List)
                .map<PaymentMethods>((data) =>
                    PaymentMethods.fromJson(data as Map<String, Object?>))
                .toList());
  }

  @override
  String toString() {
    return '''GetPaymentMethodsModel(
                status:$status,
message:$message,
data:${data.toString()}
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is GetPaymentMethodsModel &&
        other.runtimeType == runtimeType &&
        other.status == status &&
        other.message == message &&
        other.data == data;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, status, message, data);
  }
}

class PaymentMethods {
  final int? id;
  final String? name;
  final List<dynamic>? image;
  final String? type;
  final bool? status;
  final String? createdAt;
  final String? updatedAt;
  const PaymentMethods(
      {this.id,
      this.name,
      this.image,
      this.type,
      this.status,
      this.createdAt,
      this.updatedAt});
  PaymentMethods copyWith(
      {int? id,
      String? name,
      List<dynamic>? image,
      String? type,
      bool? status,
      String? createdAt,
      String? updatedAt}) {
    return PaymentMethods(
        id: id ?? this.id,
        name: name ?? this.name,
        image: image ?? this.image,
        type: type ?? this.type,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt);
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'type': type,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt
    };
  }

  static PaymentMethods fromJson(Map<String, Object?> json) {
    return PaymentMethods(
        id: json['id'] == null ? null : json['id'] as int,
        name: json['name'] == null ? null : json['name'] as String,
        image: json['image'] == null ? null : json['image'] as List<dynamic>,
        type: json['type'] == null ? null : json['type'] as String,
        status: json['status'] == null ? null : json['status'] as bool,
        createdAt:
            json['created_at'] == null ? null : json['created_at'] as String,
        updatedAt:
            json['updated_at'] == null ? null : json['updated_at'] as String);
  }

  @override
  String toString() {
    return '''Data(
                id:$id,
name:$name,
image:$image,
type:$type,
status:$status,
createdAt:$createdAt,
updatedAt:$updatedAt
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is PaymentMethods &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.name == name &&
        other.image == image &&
        other.type == type &&
        other.status == status &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return Object.hash(
        runtimeType, id, name, image, type, status, createdAt, updatedAt);
  }
}
