import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/icons.dart';

class TodoModel {
  final int? id;

  const TodoModel({required this.id, key});

  // factory TodoModel.fromMap() {
  //   return null;
  // }
  Map<String, dynamic>? toMap() {
    return null;
  }
}

class TodoCategory extends TodoModel {
  @override
  final int? id;
  final String? title;
  final IconData? icon;
  final int? completed;
  final int? totalItems;
  final int? value;

  static const String table = 'Categories';

  TodoCategory(
      {this.id,
      this.value,
      this.title = '',
      this.icon,
      this.completed = 0,
      this.totalItems = 0})
      : super(id: null);

  factory TodoCategory.fromMap(Map<String, dynamic> map) => TodoCategory(
        id: map['id'] as int,
        value: map["value"] as int,
        title: map['title'] as String,
        icon: map['icon'].toString().getFontAwesomeIcon,
        completed: map['completed'] as int,
        totalItems: map['totalItems'] as int,
      );

  double get percent {
    if (totalItems == 0) {
      return 0.0;
    } else {
      return (completed! / totalItems!).toDouble();
    }
  }

  String get percentString => NumberFormat.percentPattern().format(percent);

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'title': title,
      'icon': icon!.getFontAwesomeString,
    };

    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  //override bool operator ==

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is TodoCategory &&
        o.id == id &&
        o.value == value &&
        o.title == title &&
        o.icon == icon &&
        o.completed == completed &&
        o.totalItems == totalItems;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        icon.hashCode ^
        completed.hashCode ^
        value.hashCode ^
        totalItems.hashCode;
  }

  @override
  String toString() {
    return 'TodoCategory(id: $id, title: $title, icon: $icon, completed: $completed, totalItems: $totalItems)';
  }

  TodoCategory copyWith({
    required int id,
    required String title,
    required IconData icon,
    required int completed,
    required int totalItems,
  }) {
    return TodoCategory(
      id: id,
      title: title,
      icon: icon,
      completed: completed,
      totalItems: totalItems,
    );
  }
}

class TodoItem extends TodoModel {
  @override
  final int? id;
  final int? category;
  final String? title;
  final String? description;
  final bool? completed;

  static const String table = 'Items';

  TodoItem(
      {this.id,
      this.category,
      this.title = '',
      this.description = '',
      this.completed = false})
      : super(id: null);

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'category': category,
      'title': title,
      'description': description,
      'completed': completed! ? '1' : '0'
    };

    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  factory TodoItem.fromMap(Map<String, dynamic> map) => TodoItem(
      id: map['id'] as int,
      category: map['category'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      completed: map['completed'] == 1);

  @override
  String toString() {
    return 'TodoItem(id: $id, category: $category, title: $title, description: $description, completed: $completed)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is TodoItem &&
        o.id == id &&
        o.category == category &&
        o.title == title &&
        o.description == description &&
        o.completed == completed;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        category.hashCode ^
        title.hashCode ^
        description.hashCode ^
        completed.hashCode;
  }

  TodoItem copyWith({
    int? id,
    int? category,
    String? title,
    String? description,
    bool? completed,
  }) {
    return TodoItem(
      id: id!,
      category: category!,
      title: title!,
      description: description!,
      completed: completed!,
    );
  }
}
