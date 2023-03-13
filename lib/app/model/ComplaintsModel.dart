class ComplaintsModel {
  ComplaintsModel({
    required this.status,
    required this.data,
  });
  late final bool status;
  late final List<Data> data;

  ComplaintsModel.fromJson(Map<String, dynamic> json){
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
    required this.complaintId,
    required this.complaintReason,
  });
  late final int complaintId;
  late final String complaintReason;

  Data.fromJson(Map<String, dynamic> json){
    complaintId = json['complaintId'];
    complaintReason = json['complaintReason'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['complaintId'] = complaintId;
    _data['complaintReason'] = complaintReason;
    return _data;
  }
}