class FiltersSubCategoryModel{
  FiltersSubCategoryModel({
    required this.status,
    required this.data,
  });
  late final bool status;
  late final List<Data> data;

  FiltersSubCategoryModel.fromJson(Map<String, dynamic> json){
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
    required this.subCategories,
    required this.childCategories,
  });
  late final List<SubCategories> subCategories;
  late final List<dynamic> childCategories;

  Data.fromJson(Map<String, dynamic> json){
    subCategories = List.from(json['subCategories']).map((e)=>SubCategories.fromJson(e)).toList();
    childCategories = List.castFrom<dynamic, dynamic>(json['childCategories']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['subCategories'] = subCategories.map((e)=>e.toJson()).toList();
    _data['childCategories'] = childCategories;
    return _data;
  }
}

class SubCategories {
  SubCategories({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;

  SubCategories.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}