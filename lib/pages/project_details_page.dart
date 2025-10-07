import 'package:flutter/material.dart';
import 'package:impactagent/models/project_model.dart';
import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated()
class ProjectDetailsPage extends StatelessWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const ProjectDetailsPage({required this.project, super.key});

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            pinned: true,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black87,
            elevation: 0.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                project.name ?? 'Unnamed Project',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: const [
                    Shadow(
                      offset: Offset(0.0, 1.0),
                      blurRadius: 3.0,
                      color: Colors.black45,
                    ),
                  ],
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.blue[600]!, Colors.purple[600]!],
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.3),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (project.mission?.isNotEmpty == true) ...[
                    _buildSectionCard(
                      'Mission',
                      project.mission!,
                      Icons.flag_outlined,
                      Colors.blue,
                    ),
                    const SizedBox(height: 20.0),
                  ],
                  if (project.problem?.isNotEmpty == true) ...[
                    _buildSectionCard(
                      'Problem We\'re Solving',
                      project.problem!,
                      Icons.lightbulb_outline,
                      Colors.orange,
                    ),
                    const SizedBox(height: 20.0),
                  ],
                  Row(
                    children: [
                      if (project.stage?.isNotEmpty == true)
                        Expanded(
                          child: _buildInfoCard(
                            'Stage',
                            project.stage!,
                            Icons.timeline,
                            Colors.green,
                          ),
                        ),
                      if (project.stage?.isNotEmpty == true && project.geography?.isNotEmpty == true) const SizedBox(width: 16.0),
                      if (project.geography?.isNotEmpty == true)
                        Expanded(
                          child: _buildInfoCard(
                            'Location',
                            project.geography!,
                            Icons.location_on_outlined,
                            Colors.red,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  if (project.beneficiaries?.isNotEmpty == true) ...[
                    _buildSectionCard(
                      'Who We Help',
                      project.beneficiaries!,
                      Icons.people_outline,
                      Colors.purple,
                    ),
                    const SizedBox(height: 20.0),
                  ],
                  if (project.sectorTags?.isNotEmpty == true) ...[
                    _buildTagSection(
                      'Sectors',
                      project.sectorTags!,
                      Colors.blue,
                    ),
                    const SizedBox(height: 20.0),
                  ],
                  if (project.needs?.isNotEmpty == true) ...[
                    _buildTagSection(
                      'What We Need',
                      project.needs!,
                      Colors.orange,
                    ),
                    const SizedBox(height: 20.0),
                  ],
                  if (project.languages?.isNotEmpty == true) ...[
                    _buildTagSection(
                      'Languages',
                      project.languages!,
                      Colors.green,
                    ),
                    const SizedBox(height: 20.0),
                  ],
                  if (project.contactEmail?.isNotEmpty == true) ...[
                    _buildContactCard(project.contactEmail!),
                    const SizedBox(height: 20.0),
                  ],
                  if (project.links?.isNotEmpty == true) _buildLinksSection(project.links!),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard(
    String title,
    String content,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 0.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: Colors.grey[200]!),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Icon(icon, color: color, size: 20.0),
                ),
                const SizedBox(width: 12.0),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Text(
              content,
              style: const TextStyle(
                fontSize: 16.0,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    String title,
    String content,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 0.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.grey[200]!),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 20.0),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              content,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTagSection(String title, List<String> tags, Color color) {
    return Card(
      elevation: 0.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: Colors.grey[200]!),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: tags
                  .map(
                    (tag) => Chip(
                      label: Text(tag),
                      backgroundColor: color.withOpacity(0.1),
                      labelStyle: TextStyle(color: color),
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard(String email) {
    return Card(
      elevation: 0.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: Colors.grey[200]!),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: const Icon(Icons.email_outlined, color: Colors.blue),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Contact',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    email,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLinksSection(List<String> links) {
    return Card(
      elevation: 0.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: Colors.grey[200]!),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Links',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12.0),
            Column(
              children: links
                  .map(
                    (link) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.link,
                            color: Colors.blue,
                            size: 16.0,
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: Text(
                              link,
                              style: const TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
