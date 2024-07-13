class ChatMessagesModel {
  ChatMessagesModel({
    required this.status,
    required this.data,
  });
  late final bool status;
  late final List<Data> data;

  ChatMessagesModel.fromJson(Map<String, dynamic> json){
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
    required this.author,
    required this.id,
    required this.userId,
    required this.text,
    required this.type,
    required this.createdAt,
  });
  late final Author author;
  late final int id;
  late final int userId;
  late final String text;
  late final String type;
  late final String createdAt;

  Data.fromJson(Map<String, dynamic> json){
    author = Author.fromJson(json['author']);
    id = json['id'];
    userId = json['userId'];
    text = json['text'];
    type = json['type'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['author'] = author.toJson();
    _data['id'] = id;
    _data['userId'] = userId;
    _data['text'] = text;
    _data['type'] = type;
    _data['createdAt'] = createdAt;
    return _data;
  }
}

class Author {
  Author({
    required this.id,
    required this.firstName,
    required this.lastName,
  });
  late final int id;
  late final String firstName;
  late final String lastName;

  Author.fromJson(Map<String, dynamic> json){
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    return _data;
  }
}