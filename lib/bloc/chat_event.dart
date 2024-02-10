part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

class ChatGenerateNewTextEvent extends ChatEvent {
  final String inputMessage;
  ChatGenerateNewTextEvent({
    required this.inputMessage,
  });
}
