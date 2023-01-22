class ContactUsModel {
  ContactUsModel({
    required this.status,
    required this.data,
  });
  late final bool status;
  late final String data;

  ContactUsModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data'] = data;
    return _data;
  }
}