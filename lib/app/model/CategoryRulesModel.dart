class CategoryRulesModel {
  CategoryRulesModel({
    required this.status,
    required this.data,
  });
  late final bool status;
  late final List<Data> data;

  CategoryRulesModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.categoryId,
    required this.value,
    required this.amount,
    required this.minLimit,
    required this.maxLimit,
    required this.recommendedPrice,
    required this.minPrice,
    required this.maxPrice,
    required this.increaseAmount,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final int categoryId;
  late final String value;
  late final String amount;
  late final int minLimit;
  late final int maxLimit;
  late final String recommendedPrice;
  late final String minPrice;
  late final String maxPrice;
  late final int increaseAmount;
  late final String createdAt;
  late final String updatedAt;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    categoryId = json['categoryId'];
    value = json['value'];
    amount = json['amount'];
    minLimit = json['minLimit'];
    maxLimit = json['maxLimit'];
    recommendedPrice = json['recommendedPrice'];
    minPrice = json['minPrice'];
    maxPrice = json['maxPrice'];
    increaseAmount = json['increaseAmount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['categoryId'] = categoryId;
    _data['value'] = value;
    _data['amount'] = amount;
    _data['minLimit'] = minLimit;
    _data['maxLimit'] = maxLimit;
    _data['recommendedPrice'] = recommendedPrice;
    _data['minPrice'] = minPrice;
    _data['maxPrice'] = maxPrice;
    _data['increaseAmount'] = increaseAmount;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}