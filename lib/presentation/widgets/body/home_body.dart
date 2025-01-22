import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/core/utils/app_colors.dart';
import 'package:portfolio/data/models/project.dart';
import 'package:portfolio/presentation/widgets/body/projects/projects_grid.dart';
import 'package:portfolio/presentation/widgets/common/floating_action_buttons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../core/utils/app_extensions.dart';
import '../../blocs/home_bloc/home_bloc.dart';
import '../app_bar/vertical_headers_builder.dart';
import 'about_me/about_me_section.dart';
import 'contact/contact_section.dart';
import 'intro/intro_section.dart';
import 'projects/projects_section.dart';
import 'skills_showcase_section.dart';
import 'statistics_section.dart';
import 'services_section.dart';
import 'testimonials_section.dart';
import 'blog_section.dart';
import 'achievements_section.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/utils/app_strings.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final ScrollController _controller = ScrollController();
  final introKey = GlobalKey();
  final aboutKey = GlobalKey();
  final projectKey = GlobalKey();
  final contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initListenerForInteractWithHeaderIndex();
    });
  }

  void _initListenerForInteractWithHeaderIndex() {
    double introHeight = introKey.currentContext!.size!.height;
    double aboutHeight = aboutKey.currentContext!.size!.height;
    double projectHeight = projectKey.currentContext!.size!.height;
    // double contactHeight = contactKey.currentContext!.size!.height;
    _controller.addListener(() {
      double controllerHeight = _controller.offset;
      if (_controller.position.extentAfter == 0.0) {
        context.read<HomeBloc>().add(ChangeAppBarHeadersColorByColor(3));
      } else if (controllerHeight < introHeight) {
        context.read<HomeBloc>().add(ChangeAppBarHeadersColorByColor(0));
      } else if (controllerHeight < (introHeight + aboutHeight)) {
        context.read<HomeBloc>().add(ChangeAppBarHeadersColorByColor(1));
      } else if (controllerHeight <
          (introHeight + aboutHeight + projectHeight)) {
        context.read<HomeBloc>().add(ChangeAppBarHeadersColorByColor(2));
      } else {
        context.read<HomeBloc>().add(ChangeAppBarHeadersColorByColor(3));
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is AppBarHeadersIndexChanged) {
          Navigator.of(context).maybePop();
          const duration = Duration(milliseconds: 300);
          if (state.index == 0) {
            Scrollable.ensureVisible(
              introKey.currentContext!,
              duration: duration,
            );
          }
          if (state.index == 1) {
            Scrollable.ensureVisible(
              aboutKey.currentContext!,
              duration: duration,
            );
          }
          if (state.index == 2) {
            Scrollable.ensureVisible(
              projectKey.currentContext!,
              duration: duration,
            );
          }
          if (state.index == 3) {
            Scrollable.ensureVisible(
              contactKey.currentContext!,
              duration: duration,
            );
          }
        }
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth * 0.08,
                ),
                child: SingleChildScrollView(
                  controller: _controller,
                  child: Column(
                    children: [
                      IntroSection(key: introKey),
                      
                      // Featured Production Apps Section with responsive layout
                      const SectionTitle(title: 'Production Applications'),
                      constraints.maxWidth > 800
                          ? FeaturedAppsShowcase(
                              apps: [
                                AppConstants.projects[0],
                                AppConstants.projects[1],
                              ],
                            )
                          : Column(
                              children: [
                                FeaturedAppCard(project: AppConstants.projects[0]),
                                FeaturedAppCard(project: AppConstants.projects[1]),
                              ],
                            ),
                      
                      const SkillsShowcaseSection(),
                      AboutMeSection(key: aboutKey),
                      ProjectsSection(key: projectKey),
                      ContactSection(key: contactKey),
                    ],
                  ),
                ),
              ),
              const VerticalHeadersBuilder(),
              const FloatingActionButtons(),
            ],
          );
        },
      ),
    );
  }
}

// New Featured Apps Showcase Widget
class FeaturedAppsShowcase extends StatelessWidget {
  final List<Project> apps;
  
  const FeaturedAppsShowcase({required this.apps, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        children: apps.map((app) => Expanded(
          child: FeaturedAppCard(project: app),
        )).toList(),
      ),
    );
  }
}

// Special Card for Featured Apps
class FeaturedAppCard extends StatelessWidget {
  final Project project;
  
  const FeaturedAppCard({required this.project, super.key});

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
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1A237E).withOpacity(0.15),
            const Color(0xFF0D47A1).withOpacity(0.25),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Live Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF00C853).withOpacity(0.9),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.play_circle_outline,
                      color: Colors.white,
                      size: 18,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'LIVE ON PLAY STORE',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // App Name
          Text(
            project.name,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 16),
          
          // Description
          Text(
            project.description,
            style: TextStyle(
              fontSize: 16,
              height: 1.6,
              color: Colors.white.withOpacity(0.9),
              letterSpacing: 0.3,
            ),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 32),
          
          // Action Button
          Center(
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: ElevatedButton.icon(
                onPressed: () => _launchURL(project.googlePlay),
                icon: const Icon(Icons.play_arrow, size: 24),
                label: const Text(
                  'Download on Play Store',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Add this class before FeaturedAppsShowcase
class SectionTitle extends StatelessWidget {
  final String title;
  
  const SectionTitle({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
