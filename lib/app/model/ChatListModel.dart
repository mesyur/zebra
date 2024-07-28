class ChatListModel {
  ChatListModel({
    required this.status,
    required this.data,
  });
  late final bool status;
  late final List<Data> data;

  ChatListModel.fromJson(Map<String, dynamic> json){
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
    required this.chatId,
    required this.createdAt,
  });
  late final Author author;
  late final int chatId;
  late final String createdAt;

  Data.fromJson(Map<String, dynamic> json){
    author = Author.fromJson(json['author']);
    chatId = json['chatId'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['author'] = author.toJson();
    _data['chatId'] = chatId;
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