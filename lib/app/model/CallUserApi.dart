class CallUserApi {
  CallUserApi({
    required this.status,
    required this.data,
  });
  late final bool status;
  late final Data data;

  CallUserApi.fromJson(Map<String, dynamic> json){
    status = json['status'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.callId,
  });
  late final int callId;

  Data.fromJson(Map<String, dynamic> json){
    callId = json['callId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['callId'] = callId;
    return _data;
  }
}