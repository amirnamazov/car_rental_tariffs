class TariffModel {
  String? id;
  CarModel? car;
  List<RateModel> rate = [];

  TariffModel.fromJson(Map<dynamic, dynamic> json) {
    id = json['_id'];
    car = json['car'] != null ? CarModel.fromJson(json['car']) : null;
    if (json['rate'] != null) {
      json['rate'].forEach((v) {
        rate.add(RateModel.fromJson(v));
      });
    }
  }
}

class CarModel {
  String? picturecardurl_small;
  String? models;

  CarModel.fromJson(Map<dynamic, dynamic> json) {
    picturecardurl_small = json['picturecardurl_small'];
    models = json['models'];
  }
}

class RateModel {
  String? rateName;
  var price;
  String? price_title;
  int? parkrate;
  List<DescriptionModel> description = [];

  RateModel.fromJson(Map<dynamic, dynamic> json) {
    rateName = json['rateName'];
    price = json['price'];
    price_title = json['price_title'];
    parkrate = json['parkrate'];
    if (json['description'] != null) {
      json['description'].forEach((v) {
        description.add(DescriptionModel.fromJson(v));
      });
    }
  }
}

class DescriptionModel {
  var val;
  String? title;
  String? desc;
  int? type;
  String? comment;

  DescriptionModel.fromJson(Map<dynamic, dynamic> json) {
    val = json['val'];
    title = json['title'];
    desc = json['desc'];
    type = json['type'];
    comment = json['comment'];
  }
}