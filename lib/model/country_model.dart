class CountryModel {
  String? id;
  String? label;
  String? description;

  CountryModel({this.id, this.label, this.description});

  CountryModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    label = json['label'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['label'] = this.label;
    data['description'] = this.description;
    return data;
  }
}
