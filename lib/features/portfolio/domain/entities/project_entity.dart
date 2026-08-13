import 'package:equatable/equatable.dart';

class ProjectEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final String category; // e.g. "Desktop Apps", "Mobile Apps", "Enterprise Systems", "Web Apps"
  final List<String> technologies;
  final String? imagePath;
  final String? link;
  final String? githubUrl;
  final String? liveUrl;
  final bool isFeatured;
  final List<String>? keyFeatures;
  final String? clientOrPlatform;

  const ProjectEntity({
    this.id = '',
    required this.name,
    required this.description,
    this.category = 'Mobile Apps',
    this.technologies = const [],
    this.imagePath,
    this.link,
    this.githubUrl,
    this.liveUrl,
    this.isFeatured = false,
    this.keyFeatures,
    this.clientOrPlatform,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        category,
        technologies,
        imagePath,
        link,
        githubUrl,
        liveUrl,
        isFeatured,
        keyFeatures,
        clientOrPlatform,
      ];
}

