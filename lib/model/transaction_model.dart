import 'package:ascolin/model/order_model.dart';
import 'package:ascolin/model/product_order_model.dart';

class TransactionModel {
  String? sId;
  String? name;
  String? reference;
  num? amount;
  String? status;
  String? transactionType;
  String? step;

  Client? client;
  dynamic item;
  TransactionPhoneModel? transactionPhone;
  String? updatedAt;

  TransactionModel(
      {this.sId,
      this.name,
      this.reference,
      this.amount,
      this.status,
      this.transactionPhone,
      this.transactionType,
      this.step,
      this.client,
      this.item,
      this.updatedAt});

  TransactionModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    reference = json['reference'];
    amount = json['amount'];
    status = json['status'];
    transactionType = json['transactionType'];
    step = json['step'];
    client = json['client'] != null ? Client.fromJson(json['client']) : null;
    transactionPhone = json['transactionPhone'] != null
        ? TransactionPhoneModel.fromJson(json['transactionPhone'])
        : null;
    item = json['item'] != null
        ? json['transactionType'] == "product"
            ? ProductOrderModel.fromJson(json['item'])
            : OrderModel.fromJson(json['item'])
        : null;
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = sId;
    data['name'] = name;
    data['reference'] = reference;
    data['amount'] = amount;
    data['status'] = status;
    data['transactionType'] = transactionType;
    data['step'] = step;
    data['updatedAt'] = updatedAt;
    if (client != null) {
      data['client'] = client!.toJson();
    }
    if (transactionPhone != null) {
      data['transactionPhone'] = transactionPhone!.toJson();
    }
    if (item != null) {
      data['item'] = item!.toJson();
    }
    return data;
  }
}

class TransactionPhoneModel {
  String? network;
  String? value;

  TransactionPhoneModel({
    this.network,
    this.value,
  });

  TransactionPhoneModel.fromJson(Map<String, dynamic> json) {
    network = json['network'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['network'] = network;
    data['value'] = value;

    return data;
  }
}
