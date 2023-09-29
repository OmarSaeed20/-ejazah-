class Comment {
  final bool? status;
  final String? message;
  final List<Data>? data;

  const Comment({
    this.status,
    this.message,
    this.data,
  });

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.map<Map<String, dynamic>>((data) => data.toJson()).toList()
    };
  }

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        status: json['status'] == null ? null : json['status'] as bool,
        message: json['message'] == null ? null : json['message'] as String,
        data: json['data'] == null
            ? null
            : (json['data'] as List)
                .map<Data>(
                    (data) => Data.fromJson(data as Map<String, Object?>))
                .toList());
  }
}

class Data {
  final int? id;
  final String? commenet;
  final String? rate;
  final String? user_name;
  final String? createdAt;

  const Data({
    this.id,
    this.commenet,
    this.rate,
    this.user_name,
    this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'commenet': commenet,
      'rate': rate,
      'user_name': user_name,
      'created_at': createdAt,
    };
  }

  static Data fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'] == null ? null : json['id'] as int,
      commenet: json['commenet'] == null ? null : json['commenet'] as String,
      rate: json['rate'] == null ? null : json['rate'] as String,
      user_name: json['user_name'] == null ? null : json['user_name'] as String,
      createdAt:
          json['created_at'] == null ? null : json['created_at'] as String,
    );
  }
}
