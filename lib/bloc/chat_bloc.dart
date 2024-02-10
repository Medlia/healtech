
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:healtech/bloc/chat_bloc.dart';
import 'package:meta/meta.dart';

import 'package:healtech/models/chat_message_model.dart';

import '../repos/chat_repo.dart';
import 'chat_bloc.dart';


part 'chat_event.dart';
part 'chat_state.dart'

class ChatBloc extends Bloc<ChatEvent, ChatState> {

  ChatBloc() : super(ChatInitial()){

    on <ChatGenerateNewTextEvent>(ChatGenerateNewTextEvent);
    // Implementation


  }


  List<ChatMessageModel> messages = [];
  bool generating = false;

  Future<FutureOr<void>> ChatGenerateNewTextEvent(ChatGenerateNewTextEvent event, Emitter<ChatState> emit) async {

    messages.add(ChatMessageModel(role:"user", parts: [
      ChatPartModel(text: event.inputMessage )]))

    emit(ChatSuccessState(messages: messages));


    await ChatRepo.chatTextGenerationRepo(messages);



  }


}