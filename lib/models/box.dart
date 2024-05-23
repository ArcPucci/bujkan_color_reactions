import 'package:flutter/material.dart';

class Box {
  final int id;
  final String name;
  final Color color;

  factory Box.empty() => const Box(id: -1, name: "", color: Colors.transparent);
//<editor-fold desc="Data Methods">

  const Box({
    required this.id,
    required this.name,
    required this.color,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is Box &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              name == other.name &&
              color == other.color);

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ color.hashCode;

  @override
  String toString() {
    return 'Box{ id: $id, name: $name, color: $color,}';
  }

  Box copyWith({
    int? id,
    String? name,
    Color? color,
  }) {
    return Box(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'color': color,
    };
  }

  factory Box.fromMap(Map<String, dynamic> map) {
    return Box(
      id: map['id'] as int,
      name: map['name'] as String,
      color: map['color'] as Color,
    );
  }

//</editor-fold>
}