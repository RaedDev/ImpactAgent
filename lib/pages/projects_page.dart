import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:impactagent/models/project_model.dart';
import 'package:impactagent/integrations/supabase_service.dart';

@NowaGenerated()
class ProjectsPage extends StatelessWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          alignment: const Alignment(0.0, 0.0),
          children: [
            Positioned(
              top: 130.0,
              left: 31.5,
              width: 330.0,
              height: 500.0,
              child: DataBuilder<List<ProjectModel>>(
                builder: (context, data) => ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final ProjectModel element = data[index];
                    return Container(
                      height: 100.0,
                      width: 100.0,
                      decoration: const BoxDecoration(
                        color: Color(0x66ffe1b0),
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xffc4c4c4),
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Center(child: Text(element.name!)),
                    );
                  },
                ),
                loadingWidget: const Align(
                  alignment: Alignment(0.0, 0.0),
                  child: CircularProgressIndicator(),
                ),
                errorBuilder: (context, error) => Align(
                  alignment: const Alignment(0.0, 0.0),
                  child: Text(
                    error.toString(),
                    style: const TextStyle(color: Color(0xffff0000)),
                  ),
                ),
                future: SupabaseService().getAllProjects(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
