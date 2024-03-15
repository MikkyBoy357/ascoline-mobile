import 'package:ascolin/model/unit_model.dart';

import 'pricing_model.dart';

class OrderModel {
  String? sId;
  String? trackingId;
  UnitModel? typeColis;
  UnitModel? transportType;
  Client? client;
  PricingModel? pricing;
  String? description;
  UnitModel? unit;
  String? pays;
  num? quantity;
  String? ville;
  String? status;
  String? specialNote;
  String? paymentStatus;
  List<dynamic>? images;
  OrderModel(
      {this.sId,
      this.trackingId,
      this.typeColis,
      this.transportType,
      this.client,
      this.pricing,
      this.description,
      this.unit,
      this.pays,
      this.quantity,
      this.ville,
      this.status,
      this.specialNote,
      this.paymentStatus,
      this.images});

  OrderModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    trackingId = json['trackingId'];
    typeColis = json['typeColis'] != null
        ? new UnitModel.fromJson(json['typeColis'])
        : null;
    transportType = json['transportType'] != null
        ? new UnitModel.fromJson(json['transportType'])
        : null;
    client =
        json['client'] != null ? new Client.fromJson(json['client']) : null;
    pricing = json['pricing'] != null
        ? new PricingModel.fromJson(json['pricing'])
        : null;
    description = json['description'];
    unit = json['unit'] != null ? new UnitModel.fromJson(json['unit']) : null;
    pays = json['pays'];
    quantity = json['quantity'];
    ville = json['ville'];
    status = json['status'];
    paymentStatus = json['paymentStatus'];
    specialNote = json['specialNote'];
    images = json['images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['trackingId'] = this.trackingId;
    if (this.typeColis != null) {
      data['typeColis'] = this.typeColis!.toJson();
    }
    if (this.transportType != null) {
      data['transportType'] = this.transportType!.toJson();
    }
    if (this.client != null) {
      data['client'] = this.client!.toJson();
    }
    if (this.pricing != null) {
      data['pricing'] = this.pricing!.toJson();
    }
    data['description'] = this.description;
    if (this.unit != null) {
      data['unit'] = this.unit!.toJson();
    }
    data['pays'] = this.pays;
    data['quantity'] = this.quantity;
    data['ville'] = this.ville;
    data['status'] = this.status;
    data['paymentStatus'] = this.paymentStatus;
    data['specialNote'] = this.specialNote;
    data['images'] = this.images;
    return data;
  }
}

class Client {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? address;

  Client({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.address,
  });

  Client.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    return data;
  }
}
