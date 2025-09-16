import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated()
class ProjectModel {
  const ProjectModel({
    this.id,
    this.teamId,
    this.ownerId,
    this.name,
    this.slug,
    this.mission,
    this.problem,
    this.beneficiaries,
    this.geography,
    this.sectorTags,
    this.stage,
    this.needs,
    this.languages,
    this.links,
    this.contactEmail,
    this.published,
    this.createdAt,
    this.updatedAt,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] as String?,
      teamId: json['team_id'] as String?,
      ownerId: json['owner_id'] as String?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      mission: json['mission'] as String?,
      problem: json['problem'] as String?,
      beneficiaries: json['beneficiaries'] as String?,
      geography: json['geography'] as String?,
      sectorTags: (json['sector_tags'] as List?)
          ?.map((e) => e as String)
          .toList(),
      stage: json['stage'] as String?,
      needs: (json['needs'] as List?)?.map((e) => e as String).toList(),
      languages: (json['languages'] as List?)?.map((e) => e as String).toList(),
      links: (json['links'] as List?)?.map((e) => e as String).toList(),
      contactEmail: json['contact_email'] as String?,
      published: json['published'] as bool?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  final String? id;

  final String? teamId;

  final String? ownerId;

  final String? name;

  final String? slug;

  final String? mission;

  final String? problem;

  final String? beneficiaries;

  final String? geography;

  final List<String>? sectorTags;

  final String? stage;

  final List<String>? needs;

  final List<String>? languages;

  final List<String>? links;

  final String? contactEmail;

  final bool? published;

  final String? createdAt;

  final String? updatedAt;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'team_id': teamId,
      'owner_id': ownerId,
      'name': name,
      'slug': slug,
      'mission': mission,
      'problem': problem,
      'beneficiaries': beneficiaries,
      'geography': geography,
      'sector_tags': sectorTags,
      'stage': stage,
      'needs': needs,
      'languages': languages,
      'links': links,
      'contact_email': contactEmail,
      'published': published,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
