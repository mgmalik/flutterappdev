import 'package:uuid/uuid.dart';

class Category {
  final String id;
  final String name;

  Category({String? id, required this.name}) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(id: json['id'], name: json['name']);
  }
}
