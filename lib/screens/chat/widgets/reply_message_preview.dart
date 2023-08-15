// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:we_bite/design/colour.dart';
import 'package:we_bite/utils/providers/message_replyprovider.dart';
import 'package:we_bite/widgets/snackbar.dart';
import 'display_message.dart';

class ReplyMessagePreview extends ConsumerWidget {
  const ReplyMessagePreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ReplyMessage? replyMessage = ref.read(replyMessageProvider);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: replyMessage!.isMe ? AppColors.primary : AppColors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  replyMessage.isMe ? 'Me' : 'Opposite',
                  style: replyMessage.isMe
                      ? Theme.of(context).textTheme.headlineSmall
                      : Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: AppColors.black),
                ),
              ),
              IconButton(
                onPressed: () => _cancelReply(ref),
                icon: Icon(
                  Icons.close,
                  color: replyMessage.isMe ? AppColors.white : AppColors.black,
                ),
              )
            ],
          ),
          addVerticalSpace(8.0),
          DisplayMessage(
            message: replyMessage.message,
            messageType: replyMessage.messageType,
            isSender: replyMessage.isMe,
          ),
        ],
      ),
    );
  }

  void _cancelReply(WidgetRef ref) {
    ref.read(replyMessageProvider.state).state = null;
  }
}
