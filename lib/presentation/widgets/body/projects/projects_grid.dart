import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../data/models/project.dart';
import '../../../../core/utils/app_colors.dart';

class ProjectsGrid extends StatelessWidget {
  final List<Project> projects;

  const ProjectsGrid({required this.projects, super.key});

  int _getCrossAxisCount(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width > 1200) return 3;
    if (width > 800) return 2;
    return 1;
  }

  double _getChildAspectRatio(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width > 1200) return 1.5;
    if (width > 800) return 1.3;
    return 1.1;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _getCrossAxisCount(context),
        childAspectRatio: _getChildAspectRatio(context),
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: projects.length,
      itemBuilder: (context, index) => ProjectCard(project: projects[index]),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final Project project;
  const ProjectCard({required this.project, super.key});

  String _getGithubUrl(String projectName) {
    return 'https://github.com/Ogunleye-Similoluwa/${projectName.split(' ')[0].toLowerCase()}';
  }

  Future<void> _launchURL(String? url) async {
    if (url != null) {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, webOnlyWindowName: '_blank');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A237E).withOpacity(0.08),
              const Color(0xFF0D47A1).withOpacity(0.12),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white.withOpacity(0.05),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    project.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (project.name != 'Npod' && project.name != 'Reals')
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.code, color: Colors.white, size: 24),
                      onPressed: () => _launchURL(_getGithubUrl(project.name)),
                      tooltip: 'View Source Code',
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Text(
                project.description,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.6,
                  color: Colors.white.withOpacity(0.8),
                  letterSpacing: 0.3,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (project.previewLink != null)
                  TextButton.icon(
                    icon: const Icon(Icons.remove_red_eye, size: 20),
                    label: const Text('Preview'),
                    onPressed: () => _launchURL(project.previewLink),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white.withOpacity(0.9),
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                  ),
                if (project.googlePlay != null) ...[
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.play_arrow, size: 20),
                    label: const Text('Play Store'),
                    onPressed: () => _launchURL(project.googlePlay),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.white.withOpacity(0.1),
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
