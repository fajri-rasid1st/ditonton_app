import 'package:core/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';

class GenreModel extends Equatable {
  final String name;

  const GenreModel({required this.name});

  factory GenreModel.fromJson(Map<String, dynamic> genre) {
    return GenreModel(name: genre['name']);
  }

  Map<String, dynamic> toJson() => {'name': name};

  Genre toEntity() => Genre(name: name);

  @override
  List<Object?> get props => [name];
}
