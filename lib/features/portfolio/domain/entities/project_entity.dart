import 'package:equatable/equatable.dart';

class ProjectEntity extends Equatable {
  final String name;
  final String description;
  final String? imagePath;
  final String? link;

  const ProjectEntity({
    required this.name,
    required this.description,
    this.imagePath,
    this.link,
  });

  @override
  List<Object?> get props => [name, description, imagePath, link];
}
