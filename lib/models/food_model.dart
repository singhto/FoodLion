class FoodModel {
  String id;
  String idShop;
  String nameFood;
  String detailFood;
  String urlFood;
  String priceFood;
  String score;

  FoodModel(
      {this.id,
      this.idShop,
      this.nameFood,
      this.detailFood,
      this.urlFood,
      this.priceFood,
      this.score});

  FoodModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idShop = json['idShop'];
    nameFood = json['NameFood'];
    detailFood = json['DetailFood'];
    urlFood = json['UrlFood'];
    priceFood = json['PriceFood'];
    score = json['Score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idShop'] = this.idShop;
    data['NameFood'] = this.nameFood;
    data['DetailFood'] = this.detailFood;
    data['UrlFood'] = this.urlFood;
    data['PriceFood'] = this.priceFood;
    data['Score'] = this.score;
    return data;
  }
}
