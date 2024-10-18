import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/bloC/auth_cubit/chat_bot_cubit/chat_bot_cubit.dart';
import 'package:gymmerator/ui_component/app_drawer.dart';
import 'package:gymmerator/ui_component/loading_screen_animation.dart';
import 'package:gymmerator/utils/app_colors/app_colors.dart';
import 'package:sizer/sizer.dart';

import '../../../../models/api_response/ChatAiApiResponse.dart';
import '../../../../ui_component/show_snackbar.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();
  ChatAiApiResponse? response;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBotCubit(),
      child: BlocConsumer<ChatBotCubit, ChatBotState>(
        listener: (context, state) {
          if (state is FailedToGetChatResponse) {
            showSnackBar(context, "Please try again");
          }
          if (state is ChatResponseSuccessfully) {
            response = state.response;
            messageController.clear();
          }
        },
        builder: (context, state) {
          return LoadingScreenAnimation(
            isLoading: state is LoadingState,
            child: Scaffold(
              backgroundColor: AppColors.chatScreenBackgroundColor,
              drawer: const AppDrawer(),
              appBar: AppBar(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset('assets/icons/chat_ai_title_icon.png',
                        width: 35, height: 35),
                    Text('GYMI',
                        style: GoogleFonts.vazirmatn(
                            color: AppColors.prductBuyNowButtonColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
                titleSpacing: 0.0,
              ),
              body: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  const SectionTitle(
                      title: 'Explain', icon: Icon(Icons.lightbulb_outline)),
                  const FeatureButton(
                      title:
                          'Welcome to the Nutrition and Fitness Assistant! You can ask questions related to nutrition and fitness.'),
                  response?.data?.userInput != null
                      ? FeatureButton(
                          title: response?.data?.userInput ?? "",
                          color: const Color(0xff599918).withOpacity(0.44),
                        )
                      : const SizedBox(),
                  const SizedBox(height: 18.0),
                  response?.data?.response != null
                      ? FeatureButton(title: response?.data?.response ?? "")
                      : const SizedBox(),
                ],
              ),
              bottomNavigationBar: Material(
                color: AppColors.chatScreenBackgroundColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Material(
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                          ),
                          shadowColor:
                              Colors.grey, // Example color for the shadow
                          elevation: 2.0,
                          child: TextField(
                            controller: messageController,
                            maxLines: null,
                            // Allows the TextField to expand dynamically
                            minLines: 1,
                            // Starts with one line
                            keyboardType: TextInputType.multiline,
                            // Supports multi-line input
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              // Fills the background with color
                              hintText: 'Hello GYMI, how are you today?',
                              hintStyle: GoogleFonts.vazirmatn(),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () async {
                                  await _onSendButtonPressed(context);
                                },
                                icon: const Icon(Icons.send),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _onSendButtonPressed(BuildContext context) async {
    if (messageController.text.isEmpty) {
      showSnackBar(context, "Please enter email");
    } else {
      context.read<ChatBotCubit>().chatRequest(message: messageController.text);
    }
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title, required this.icon});

  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        icon,
        const SizedBox(height: 16.0),
        Text(
          title,
          style: GoogleFonts.vazirmatn(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class FeatureButton extends StatelessWidget {
  final String title;
  final Color? color;

  const FeatureButton({super.key, required this.title, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16.0,
        ),
        decoration: BoxDecoration(
          color: color ?? AppColors.chatScreenFeatureButtonColor,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Center(
            child: Text(title,
                style: GoogleFonts.vazirmatn(
                    fontSize: 12.sp, fontWeight: FontWeight.w400))),
      ),
    );
  }
}
