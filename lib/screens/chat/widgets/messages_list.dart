// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:we_bite/utils/enums/message_type.dart';
import 'package:we_bite/utils/enums/swipe_direction.dart';
import 'package:we_bite/utils/errors/apploader.dart';
import 'package:we_bite/utils/providers/current_userprovider.dart';
import 'package:we_bite/utils/providers/message_replyprovider.dart';
import '../../../models/message.dart';
import '../controllers/chat_controller.dart';
import 'message_card.dart';

class MessagesList extends ConsumerStatefulWidget {
  const MessagesList({
    super.key,
    required this.uId,
    required this.isGroupChat,
  });

  final String uId;
  final bool isGroupChat;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MessageListState();
}

class _MessageListState extends ConsumerState<MessagesList> {
  late final ScrollController _messagesScrollController;

  @override
  void initState() {
    super.initState();
    _messagesScrollController = ScrollController();
  }

  @override
  void dispose() {
    _messagesScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Message>>(
      stream: widget.isGroupChat
          ? ref
              .watch(chatControllerProvider)
              .getGroupMessagesList(groupId: widget.uId)
          : ref
              .watch(chatControllerProvider)
              .getMessagesList(receiverUserId: widget.uId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Loader();
        }

        // adding callback to new message to scroll to bottom.
        SchedulerBinding.instance.addPostFrameCallback(
          (_) => _messagesScrollController.animateTo(
            _messagesScrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 500),
            curve: Curves.linear,
          ),
        );

        return ListView.builder(
          controller: _messagesScrollController,
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            Message message = snapshot.data![index];

            final bool isSenderUser =
                message.senderUserId == ref.read(currentUserProvider!).uid;

            // setting message seen for receiver
            if (!message.isSeen &&
                message.receiverUserId == ref.read(currentUserProvider!).uid) {
              ref.read(chatControllerProvider).setChatMessageSeen(
                    context,
                    receiverUserId: widget.uId,
                    messageId: message.messageId,
                  );
            }
            return MessageCard(
              isSender: isSenderUser ? true : false,
              message: message.lastMessage,
              messageType: message.messageType,
              isSeen: message.isSeen,
              time: DateFormat.Hm().format(message.time),
              swipeDirection:
                  isSenderUser ? SwipeDirection.left : SwipeDirection.right,
              repliedText: message.repliedMessage,
              repliedMessageType: message.repliedMessageType,
              username: message.repliedTo,
              onSwipe: isSenderUser
                  ? () => _onSwipeMessage(
                        message: message.lastMessage,
                        isMe: true,
                        messageType: message.messageType,
                        isSender: true,
                      )
                  : () => _onSwipeMessage(
                        message: message.lastMessage,
                        isMe: false,
                        messageType: message.messageType,
                        isSender: false,
                      ),
            );
          },
        );
      },
    );
  }

  void _onSwipeMessage({
    required String message,
    required bool isMe,
    required MessageTypes messageType,
    required bool isSender,
  }) {
    ref.watch(replyMessageProvider.state).state = ReplyMessage(
      message: message,
      isMe: isMe,
      messageType: messageType,
      isSender: isSender,
    );
  }
}
