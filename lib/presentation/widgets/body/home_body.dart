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
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.width * .08),
            child: SingleChildScrollView(
              controller: _controller,
              child: Column(
                children: [
                  IntroSection(key: introKey),
                  
                  // Featured Production Apps Section
                  const SectionTitle(title: 'Production Applications'),
                  FeaturedAppsShowcase(
                    apps: [
                      AppConstants.projects[0], // Npod
                      AppConstants.projects[1], // Reals
                    ],
                  ),
                  
                  // Skills Section with Animation
                  const SkillsShowcaseSection(),
                  
                  // About Section
                  AboutMeSection(key: aboutKey),
                  
                  // Main Projects Grid
                  const SectionTitle(title: AppStrings.featuredProjects),
                  ProjectsSection(key: projectKey),
                  
                  // Contact Section
                  ContactSection(key: contactKey),
                ],
              ),
            ),
          ),
          const VerticalHeadersBuilder(),
          const FloatingActionButtons(),
        ],
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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryColor.withOpacity(0.1),
            AppColors.secondaryColor.withOpacity(0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // App Icon/Image
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              project.imageUrl,
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          
          // App Name with Live Badge
          Row(
            children: [
              Text(
                project.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.accentSuccess,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'LIVE',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Description
          Text(
            project.description,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),
          
          // Action Buttons
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () => project.googlePlay != null 
                    ? launchUrl(Uri.parse(project.googlePlay!))
                    : null,
                icon: const Icon(Icons.play_arrow),
                label: const Text('Play Store'),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: () => project.previewLink != null 
                    ? launchUrl(Uri.parse(project.previewLink!))
                    : null,
                icon: const Icon(Icons.remove_red_eye),
                label: const Text('Preview'),
              ),
            ],
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
