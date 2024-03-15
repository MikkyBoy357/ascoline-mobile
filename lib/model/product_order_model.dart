import 'package:ascolin/model/order_model.dart';
import 'package:ascolin/model/product_model.dart';

class ProductOrderModel {
  String? sId;
  String? reference;
  Client? client;
  ProductModel? product;
  num? quantity;
  num? price;
  num? total;
  String? status;
  String? specialNote;
  String? paymentStatus;
  ProductOrderModel(
      {this.sId,
      this.reference,
      this.client,
      this.quantity,
      this.price,
      this.total,
      this.status,
      this.specialNote,
      this.paymentStatus,
      this.product});

  ProductOrderModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    reference = json['reference'];
    client = json['client'] != null ? Client.fromJson(json['client']) : null;
    product =
        json['product'] != null ? ProductModel.fromJson(json['product']) : null;
    quantity = json['quantity'];
    price = json['price'];
    total = json['total'];
    status = json['status'];
    paymentStatus = json['paymentStatus'];
    specialNote = json['specialNote'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['reference'] = this.reference;
    if (this.client != null) {
      data['client'] = this.client!.toJson();
    }
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['total'] = this.total;
    data['status'] = this.status;
    data['paymentStatus'] = this.paymentStatus;
    data['specialNote'] = this.specialNote;
    return data;
  }
}
