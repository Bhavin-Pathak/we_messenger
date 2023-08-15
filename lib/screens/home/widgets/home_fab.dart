import 'dart:io';
import 'package:flutter/material.dart';
import 'package:we_bite/design/colour.dart';
import 'package:we_bite/functions/methods.dart';
import 'package:we_bite/utils/routes/app_routes.dart';
import 'package:we_bite/widgets/snackbar.dart';

class HomeFAB extends StatefulWidget {
  const HomeFAB({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  final TabController tabController;

  @override
  State<HomeFAB> createState() => _HomeFABState();
}

class _HomeFABState extends State<HomeFAB> {
  @override
  void initState() {
    super.initState();
    widget.tabController.addListener(
      () {
        setState(() {
          widget.tabController.indexIsChanging;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        widget.tabController.index == 0
            ? GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.groupChatsScreen);
                },
                child: const CircleAvatar(
                  radius: 24.0,
                  backgroundColor: AppColors.primary,
                  child: Icon(
                    Icons.group,
                    color: AppColors.white,
                  ),
                ),
              )
            : const SizedBox(),
        addVerticalSpace(16.0),
        FloatingActionButton(
          onPressed: () {
            switch (widget.tabController.index) {
              case 0:
                Navigator.pushNamed(context, AppRoutes.selectContactScreen);
                break;
              case 1:
                _selectAndConfirmImage();
                break;
              case 2:
                break;
              default:
                Navigator.pushNamed(context, AppRoutes.errorScreen);
            }
          },
          child: Icon(
            widget.tabController.index == 0
                ? Icons.chat_rounded
                : widget.tabController.index == 1
                    ? Icons.image
                    : Icons.call,
          ),
        ),
      ],
    );
  }

  void _selectAndConfirmImage() async {
    File? imageFile = await pickImageFromGallery(context);
    if (imageFile != null) {
      if (!mounted) return;
      Navigator.pushNamed(
        context,
        AppRoutes.confirmStatusScreen,
        arguments: imageFile,
      );
    } else {
      if (!mounted) return;
      showSnackBar(context, content: 'Image not selected');
    }
  }
}
