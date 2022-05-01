import 'package:ditonton/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';

class GenreModel extends Equatable {
  final int id;
  final String name;

  const GenreModel({required this.id, required this.name});

  factory GenreModel.fromJson(Map<String, dynamic> genre) {
    return GenreModel(
      id: genre['id'],
      name: genre['name'],
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  Genre toEntity() => Genre(id: id, name: name);

  @override
  List<Object?> get props => [id, name];
}
