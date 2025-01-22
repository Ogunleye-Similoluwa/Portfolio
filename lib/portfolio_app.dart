import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/theme/theme_manager.dart';
import 'presentation/blocs/home_bloc/home_bloc.dart';
import 'presentation/pages/home_page.dart';

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Similoluwa Ogunleye',
        theme: CustomTheme.darkTheme(),
        home: const HomePage(),
        builder: (context, child) {
          return child ?? const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
