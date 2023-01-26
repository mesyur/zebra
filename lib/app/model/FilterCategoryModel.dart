class FilterCategoryModel {
  FilterCategoryModel({
    required this.status,
    required this.data,
  });
  late final bool status;
  late final List<int> data;

  FilterCategoryModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    data = List.castFrom<dynamic, int>(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data'] = data;
    return _data;
  }
}