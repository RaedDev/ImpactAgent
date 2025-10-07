import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:impactagent/models/project_model.dart';
import 'package:impactagent/integrations/supabase_service.dart';
import 'package:impactagent/pages/project_details_page.dart';

@NowaGenerated()
class ProjectsPage extends StatelessWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0.0, 2.0),
                    blurRadius: 8.0,
                    color: Colors.black12,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue[600]!, Colors.purple[600]!],
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: const Icon(
                      Icons.rocket_launch_outlined,
                      color: Colors.white,
                      size: 24.0,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Projects',
                          style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          'Discover amazing projects making a difference',
                          style: TextStyle(fontSize: 16.0, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: DataBuilder<List<ProjectModel>>(
                future: SupabaseService().getAllProjects(),
                builder: (context, projects) {
                  if (projects.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(24.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: Icon(
                              Icons.folder_open_outlined,
                              size: 48.0,
                              color: Colors.grey[400],
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Text(
                            'No projects found',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            'Projects will appear here once they\'re created',
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                        ],
                      ),
                    );
                  }
                  return RefreshIndicator(
                    onRefresh: () async =>
                        Future.delayed(const Duration(seconds: 1)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              MediaQuery.of(context).size.width > 600 ? 3 : 2,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                        ),
                        itemCount: projects.length,
                        itemBuilder: (context, index) =>
                            _buildProjectCard(context, projects[index]),
                      ),
                    ),
                  );
                },
                loadingWidget: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(strokeWidth: 3.0),
                      SizedBox(height: 16.0),
                      Text(
                        'Loading projects...',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                errorBuilder: (context, error) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(24.0),
                        decoration: BoxDecoration(
                          color: Colors.red[50],
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: Icon(
                          Icons.error_outline,
                          size: 48.0,
                          color: Colors.red[400],
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        'Failed to load projects',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        error.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.refresh),
                        label: const Text('Try Again'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[600],
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 12.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectCard(BuildContext context, ProjectModel project) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProjectDetailsPage(project: project),
          ),
        );
      },
      child: Card(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: BorderSide(color: Colors.grey[200]!),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Colors.grey[50]!],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 120.0,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      _getProjectColor(project.name ?? ''),
                      _getProjectColor(project.name ?? '').withOpacity(0.7),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 12.0,
                      right: 12.0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Text(
                          project.stage ?? 'Unknown',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: Icon(
                          _getProjectIcon(project.sectorTags),
                          color: Colors.white,
                          size: 32.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.name ?? 'Unnamed Project',
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8.0),
                      if (project.mission?.isNotEmpty == true)
                        Text(
                          project.mission!,
                          style: const TextStyle(
                            color: Colors.grey,
                            height: 1.4,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      const Spacer(),
                      Row(
                        children: [
                          if (project.geography?.isNotEmpty == true) ...[
                            Icon(
                              Icons.location_on_outlined,
                              size: 16.0,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(width: 4.0),
                            Expanded(
                              child: Text(
                                project.geography!,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12.0,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 14.0,
                            color: Colors.grey[400],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getProjectColor(String name) {
    final colors = [
      Colors.blue[600],
      Colors.purple[600],
      Colors.green[600],
      Colors.orange[600],
      Colors.teal[600],
      Colors.red[600],
      Colors.indigo[600],
      Colors.pink[600],
    ];
    return colors[name.hashCode % colors.length]!;
  }

  IconData _getProjectIcon(List<String>? sectors) {
    if (sectors == null || sectors!.isEmpty) {
      return Icons.rocket_launch_outlined;
    }
    final sector = sectors!.first.toLowerCase();
    if (sector.contains('health')) {
      return Icons.health_and_safety_outlined;
    }
    if (sector.contains('education')) {
      return Icons.school_outlined;
    }
    if (sector.contains('environment')) {
      return Icons.eco_outlined;
    }
    if (sector.contains('tech')) {
      return Icons.computer_outlined;
    }
    if (sector.contains('finance')) {
      return Icons.account_balance_outlined;
    }
    if (sector.contains('social')) {
      return Icons.people_outline;
    }
    return Icons.rocket_launch_outlined;
  }
}
