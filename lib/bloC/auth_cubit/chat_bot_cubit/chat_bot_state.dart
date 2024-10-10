part of 'chat_bot_cubit.dart';

abstract class ChatBotState extends Equatable {
  const ChatBotState();

  @override
  List<Object> get props => [];
}

class ChatBotInitial extends ChatBotState {}

class LoadingState extends ChatBotState {}

class ChatResponseSuccessfully extends ChatBotState {
  final ChatAiApiResponse response;
  const ChatResponseSuccessfully(this.response);
}

class FailedToGetChatResponse extends ChatBotState {
  final ChatAiApiResponse response;

  const FailedToGetChatResponse(this.response);
}
