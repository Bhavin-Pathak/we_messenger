enum MessageTypes {
  text('text'),
  image('image'),
  gif('gif'),
  audio('audio'),
  video('video');

  final String type;
  const MessageTypes(this.type);
}

extension ConvertMessageType on String {
  MessageTypes toEnum() {
    switch (this) {
      case 'text':
        return MessageTypes.text;
      case 'image':
        return MessageTypes.image;
      case 'gif':
        return MessageTypes.gif;
      case 'audio':
        return MessageTypes.audio;
      case 'video':
        return MessageTypes.video;
      default:
        return MessageTypes.text;
    }
  }
}
