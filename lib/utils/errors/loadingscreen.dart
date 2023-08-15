import 'package:flutter/material.dart';
import 'package:we_bite/design/colour.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: AppColors.black,
        ),
      ),
    );
  }
}
