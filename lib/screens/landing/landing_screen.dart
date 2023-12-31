import 'package:flutter/material.dart';
import 'package:we_bite/design/colour.dart';
import 'package:we_bite/utils/constant/assets.dart';
import 'package:we_bite/utils/routes/app_routes.dart';
import 'package:we_bite/widgets/button.dart';
import 'package:we_bite/widgets/snackbar.dart';


class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              addVerticalSpace(size.height * 0.05),
              _buildTitle(context, size),
              _buildSubTitle(context, size),
              const Expanded(child: SizedBox()),
              _buildHeroImage(size),
              const Expanded(child: SizedBox()),
              RoundedButton(
                text: 'Get Started',
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.phoneLoginScreen,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroImage(Size size) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
      child: Image.asset(
        ImagesConsts.icLanding2,
        width: size.width * 0.9,
        height: size.width * 0.9,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildTitle(BuildContext context, Size size) {
    return Text(
      'Welcome To LetsChat',
      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontSize: size.width * 0.08,
          ),
    );
  }

  Widget _buildSubTitle(BuildContext context, Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        'Easy and free you can get all features here.',
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontSize: size.width * 0.04,
              color: AppColors.grey,
              fontWeight: FontWeight.normal,
            ),
      ),
    );
  }
}
