import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/home_bloc/home_bloc.dart';
// import '../widgets/app_bar/custom_app_bar.dart';
import '../widgets/body/home_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
    
      body: HomeBody(),
    );
  }
} 