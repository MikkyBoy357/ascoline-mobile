import 'package:ascolin/model/unit_model.dart';

class PricingModel {
  String? sId;
  int? price;
  UnitModel? typeColis;
  UnitModel? transportType;
  UnitModel? unit;
  String? description;
  int? quantity;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? iV;

  PricingModel(
      {this.sId,
      this.price,
      this.typeColis,
      this.transportType,
      this.unit,
      this.description,
      this.quantity,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.iV});

  PricingModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    price = json['price'];
    typeColis = json['typeColis'] != null
        ? new UnitModel.fromJson(json['typeColis'])
        : null;
    transportType = json['transportType'] != null
        ? new UnitModel.fromJson(json['transportType'])
        : null;
    unit = json['unit'] != null ? new UnitModel.fromJson(json['unit']) : null;
    description = json['description'];
    quantity = json['quantity'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['price'] = this.price;
    if (this.typeColis != null) {
      data['typeColis'] = this.typeColis!.toJson();
    }
    if (this.transportType != null) {
      data['transportType'] = this.transportType!.toJson();
    }
    if (this.unit != null) {
      data['unit'] = this.unit!.toJson();
    }
    data['description'] = this.description;
    data['quantity'] = this.quantity;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
