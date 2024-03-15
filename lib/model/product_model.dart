class ProductModel {
  String? sId;
  String? name;
  String? description;
  num? quantity;
  num? price;
  List<dynamic>? images;

  ProductModel(
      {this.sId,
      this.name,
      this.description,
      this.price,
      this.quantity,
      this.images});

  ProductModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    quantity = json['quantity'];
    images = json['images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['images'] = this.images;
    return data;
  }
}
