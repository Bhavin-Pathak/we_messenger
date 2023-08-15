import 'dart:io';
import 'package:flutter/material.dart';
import 'package:giphy_picker/giphy_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:we_bite/utils/constant/strings.dart';
import 'package:we_bite/utils/enums/message_type.dart';
import 'package:we_bite/widgets/snackbar.dart';

/// Invoke to pick image from gallery.
Future<File?> pickImageFromGallery(BuildContext context) async {
  File? imageFile;

  try {
    XFile? xFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (xFile != null) {
      imageFile = File(xFile.path);
    }
  } catch (e) {
    showSnackBar(context, content: e.toString());
  }

  return imageFile;
}

/// Invoke to pick video from gallery.
Future<File?> pickVideoFromGallery(BuildContext context) async {
  File? videoFile;

  try {
    XFile? xFile = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
      maxDuration: const Duration(minutes: 1),
    );

    if (xFile != null) {
      videoFile = File(xFile.path);
    }
  } catch (e) {
    showSnackBar(context, content: e.toString());
  }

  return videoFile;
}

/// Invoke to pick GIF.
Future<GiphyGif?> pickGIG(BuildContext context) async {
  GiphyGif? gif;
  try {
    gif = await GiphyPicker.pickGif(
      title: const Text('Pick GIF'),
      context: context,
      apiKey: StringsConsts.giphyApiKey,
    );
  } catch (e) {
    showSnackBar(context, content: e.toString());
  }
  return gif;
}

/// Invoke to get file type which you are going to send.
String getFileType(MessageTypes messageType) {
  switch (messageType) {
    case MessageTypes.image:
      return '📷 Photo';
    case MessageTypes.gif:
      return 'GIF';
    case MessageTypes.audio:
      return '🎵 Audio';
    case MessageTypes.video:
      return '📸 Video';
    default:
      return 'GIF';
  }
}
