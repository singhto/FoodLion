class BannerModel {
  String id;
  String pathImage;

  BannerModel({this.id, this.pathImage});

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pathImage = json['PathImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['PathImage'] = this.pathImage;
    return data;
  }
}

