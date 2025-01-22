import '../../data/models/custom_service.dart';
import '../../data/models/project.dart';
import 'app_assets.dart';

abstract class AppConstants {
  static const double appBarHeight = 80;
  static const List<CustomService> services = [
    CustomService(
      service: 'MOBILE DEVELOPMENT',
      logo: AppAssets.androidLogo,
      description:
          'Expert Flutter development with clean architecture, beautiful UI/UX, and cross-platform solutions. Specializing in high-performance mobile applications.',
    ),
    CustomService(
      service: 'FULL STACK SOLUTIONS',
      logo: AppAssets.uiDesignLogo,
      description:
          'End-to-end application development combining Flutter frontend with Spring Boot and Django backends. Building scalable and maintainable solutions.',
    ),
    CustomService(
      service: 'AI INTEGRATION',
      logo: AppAssets.scrappingLogo,
      description:
          'Implementing cutting-edge AI features including speech recognition, natural language processing, and smart automation. Creating intelligent and interactive applications.',
    ),
  ];
  static const List<Project> projects = [
    Project(
      name: 'Npod',
      imageUrl: 'PATH_TO_IMAGE',
      description:
          'A comprehensive transportation platform with features like trip booking, car hire, and traveler management. Built with Flutter and integrated with secure payment systems.',
      googlePlay: "https://play.google.com/store/apps/details?id=com.nomadicpod.npod&hl=en_US"
    ),
    Project(
      name: 'Reals',
      imageUrl: 'PATH_TO_IMAGE',
      description:
          'Cross-platform mobile application for seamless utility services including airtime, data, and bill payments. Features real-time processing and intuitive user experience.',
      googlePlay: 'https://play.google.com/apps/testing/com.reals.app.Reals',
    ),
    Project(
      name: 'Zimi',
      imageUrl: 'PATH_TO_IMAGE',
      description:
          'Advanced music recognition app featuring ACRCloud integration, real-time lyrics synchronization, and YouTube video integration. Includes beautiful particle animations and offline support.',
      githubRepoLink: 'YOUR_GITHUB_LINK',
    ),
    Project(
      name: 'E-Commerce Backend',
      imageUrl: 'PATH_TO_YOUR_IMAGE',
      description:
          'A scalable Spring Boot backend powering an e-commerce platform. Features microservices architecture, secure payment processing, and real-time inventory management.',
      githubRepoLink: 'YOUR_GITHUB_LINK',
      previewLink: 'YOUR_PREVIEW_LINK',
    ),
    Project(
      name: 'Convene - Video Conferencing',
      imageUrl: 'PATH_TO_YOUR_IMAGE',
      description:
          'Modern video conferencing platform with features like instant meetings, scheduling, end-to-end encryption, Google Sign-In, and smart notifications. Built with Flutter and Firebase for robust real-time communication.',
      githubRepoLink: 'YOUR_GITHUB_LINK',
      previewLink: 'YOUR_PREVIEW_LINK',
    ),
    Project(
      name: 'AniHub',
      imageUrl: 'PATH_TO_YOUR_IMAGE',
      description:
          'Feature-rich manga and anime platform with advanced reading modes, offline support, HD streaming capabilities, and comprehensive content management. Implements modern architecture patterns and best practices.',
      githubRepoLink: 'YOUR_GITHUB_LINK',
      previewLink: 'YOUR_PREVIEW_LINK',
    ),
    Project(
      name: 'Chatty - AI Assistant',
      imageUrl: 'PATH_TO_YOUR_IMAGE',
      description:
          'Advanced AI chat application powered by Google Gemini, featuring speech recognition, image processing, multi-language support, and voice interactions. Includes AI image generation and real-time language translation.',
      githubRepoLink: 'YOUR_GITHUB_LINK',
      previewLink: 'YOUR_PREVIEW_LINK',
    ),
    Project(
      name: 'CulinaryCompass',
      imageUrl: 'PATH_TO_YOUR_IMAGE',
      description:
          'Smart recipe discovery app with voice commands, hands-free cooking mode, offline support, and advanced search capabilities. Features step-by-step instructions and multi-language support.',
      githubRepoLink: 'YOUR_GITHUB_LINK',
      previewLink: 'YOUR_PREVIEW_LINK',
    ),
    Project(
      name: 'ConnectPro',
      imageUrl: 'PATH_TO_YOUR_IMAGE',
      description:
          'Real-time chat application with features like instant messaging, media sharing, voice messages, and group chats. Built with Flutter and Firebase, featuring modern UI and comprehensive security features.',
      githubRepoLink: 'YOUR_GITHUB_LINK',
      previewLink: 'YOUR_PREVIEW_LINK',
    ),
    Project(
      name: 'VocabVault',
      imageUrl: 'PATH_TO_YOUR_IMAGE',
      description:
          'Advanced vocabulary learning app with interactive quizzes, audio pronunciations, progress tracking, and comprehensive analytics. Features multiple quiz modes and customizable learning paths.',
      githubRepoLink: 'YOUR_GITHUB_LINK',
      previewLink: 'YOUR_PREVIEW_LINK',
    ),
    Project(
      name: 'NewsHub',
      imageUrl: 'PATH_TO_YOUR_IMAGE',
      description:
          'Modern news aggregator combining multiple sources with features like smart search, offline reading, and real-time updates. Implements clean architecture and advanced state management.',
      githubRepoLink: 'YOUR_GITHUB_LINK',
      previewLink: 'YOUR_PREVIEW_LINK',
    ),
    Project(
      name: 'Routinely',
      imageUrl: 'PATH_TO_YOUR_IMAGE',
      description:
          'Sophisticated habit tracking app with detailed analytics, custom reminders, and progress visualization. Features interactive charts, category management, and comprehensive insights.',
      githubRepoLink: 'YOUR_GITHUB_LINK',
      previewLink: 'YOUR_PREVIEW_LINK',
    ),
    Project(
      name: 'JestGenius',
      imageUrl: 'PATH_TO_YOUR_IMAGE',
      description:
          'Advanced joke generator with multiple categories, text-to-speech, customizable themes, and offline support. Features include daily notifications and comprehensive analytics.',
      githubRepoLink: 'YOUR_GITHUB_LINK',
      previewLink: 'YOUR_PREVIEW_LINK',
    ),
    Project(
      name: 'SkyScope',
      imageUrl: 'PATH_TO_YOUR_IMAGE',
      description:
          'Modern weather application featuring real-time updates, interactive charts, location-based forecasts, and beautiful animations. Includes offline support and home screen widgets.',
      githubRepoLink: 'YOUR_GITHUB_LINK',
      previewLink: 'YOUR_PREVIEW_LINK',
    ),
    Project(
      name: 'QrCraft Pro',
      imageUrl: 'PATH_TO_YOUR_IMAGE',
      description:
          'Feature-rich QR code generator and scanner with advanced customization, batch processing, and comprehensive analytics. Supports multiple QR types and includes business features.',
      githubRepoLink: 'YOUR_GITHUB_LINK',
      previewLink: 'YOUR_PREVIEW_LINK',
    ),
  ];
}
