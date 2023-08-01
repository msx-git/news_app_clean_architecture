import 'package:equatable/equatable.dart';

class Source extends Equatable {
  final String? id;
  final String? name;

  const Source({this.id, this.name});

  factory Source.fromMap(Map<String, dynamic> map) {
    return Source(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  @override
  String toString() {
    return 'Source{id: $id, name: $name}';
  }

  @override
  List<Object?> get props => [id, name];
}
