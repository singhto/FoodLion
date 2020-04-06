class UserShopModel {
  String id;
  String name;
  String user;
  String password;
  String urlShop;
  String lat;
  String lng;

  UserShopModel(
      {this.id,
      this.name,
      this.user,
      this.password,
      this.urlShop,
      this.lat,
      this.lng});

  UserShopModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['Name'];
    user = json['User'];
    password = json['Password'];
    urlShop = json['UrlShop'];
    lat = json['Lat'];
    lng = json['Lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Name'] = this.name;
    data['User'] = this.user;
    data['Password'] = this.password;
    data['UrlShop'] = this.urlShop;
    data['Lat'] = this.lat;
    data['Lng'] = this.lng;
    return data;
  }
}
