import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymmerator/models/api_response/ChatAiApiResponse.dart';

import '../../../resources/repository.dart';

part 'chat_bot_state.dart';

class ChatBotCubit extends Cubit<ChatBotState> {
  ChatBotCubit() : super(ChatBotInitial());

  final _repository = Repository();

  Future chatRequest({required String message}) async {
    emit(LoadingState());
    Map data = {"user_input": message};
    final ChatAiApiResponse model = await _repository.chatRequest(data);
    if (model.error == null) {
      emit(ChatResponseSuccessfully(model));
    } else {
      emit(FailedToGetChatResponse(model));
    }
  }
}
