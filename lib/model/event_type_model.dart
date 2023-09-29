class EventTypeModel {
  bool? status;
  String? message;
  Data? data;

  EventTypeModel({this.status, this.message, this.data});

  EventTypeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<EventType>? eventType;

  Data({this.eventType});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['eventType'] != null) {
      eventType = <EventType>[];
      json['eventType'].forEach((v) {
        eventType!.add(new EventType.fromJson(v));
      });
    }
  }
}

class EventType {
  int? id;
  String? name;

  EventType({this.id, this.name});

  EventType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

}
