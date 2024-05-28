import 'package:flutter/material.dart';
import 'package:gymmerator/ui_component/app_drawer.dart';
import 'package:gymmerator/utils/app_colors/app_colors.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.chatScreenBackgroundColor,
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('assets/icons/chat_ai_title_icon.png',
                width: 40, height: 40),
            const Text('ChatAi',
                style: TextStyle(
                    color: AppColors.prductBuyNowButtonColor,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600)),
          ],
        ),
        titleSpacing: 0.0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          SectionTitle(title: 'Explain', icon: Icon(Icons.lightbulb_outline)),
          FeatureButton(title: 'Explain Quantum physics'),
          FeatureButton(title: 'What are wormholes explain like i am 5'),
          SizedBox(height: 16.0),
          SectionTitle(title: 'Write & edit', icon: Icon(Icons.edit_outlined)),
          FeatureButton(title: 'Write a tweet about global warming'),
          FeatureButton(title: 'Write a poem about flower and love'),
          FeatureButton(title: 'Write a rap song lyrics about'),
          SizedBox(height: 16.0),
          SectionTitle(
              title: 'Translate', icon: Icon(Icons.translate_outlined)),
          FeatureButton(title: 'How do you say “how are you” in korean?'),
          FeatureButton(title: 'Write a poem about flower and love'),
        ],
      ),
      bottomNavigationBar: const Material(
        color: AppColors.chatScreenBackgroundColor,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Material(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  shadowColor: AppColors.borderColor,
                  elevation: 2.0,
                  child: TextField(
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        hintText: 'Hello ChatAi, how are you today?',
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))),
                        suffixIcon: Icon(Icons.send)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class FeatureButton extends StatelessWidget {
  final String title;

  const FeatureButton({super.key, required this.title});

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
          color: AppColors.chatScreenFeatureButtonColor,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Center(
            child: Text(title,
                style: const TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.w400))),
      ),
    );
  }
}
