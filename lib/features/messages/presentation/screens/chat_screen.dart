import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:health_app/core/constants/assets.dart';
import '../../../../core/constants/colors.dart';
import '../blocs/chat_bloc.dart';
import '../blocs/chat_event.dart';
import '../blocs/chat_state.dart';

class ChatScreen extends StatefulWidget {
  final String username;

  const ChatScreen({super.key, required this.username});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(LoadChatEvent(widget.username));
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              if (state is ChatLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.textColor),
                );
              } else if (state is ChatLoaded) {
                return Column(
                  children: [
                    _buildHeader(screenWidth, state.username),
                    Expanded(
                      child: Container(
                        color: Colors.transparent, // الشات فاضي دلوقتي
                      ),
                    ),
                    _buildMessageInput(screenWidth, screenHeight),
                  ],
                );
              } else if (state is ChatError) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(color: AppColors.textColor),
                  ),
                );
              }
              return const Center(
                child: Text(
                  'No Chat',
                  style: TextStyle(color: AppColors.textColor),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(double screenWidth, String username) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical: 10,
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.textColor,
              size: 28,
            ),
            onPressed: () {
              context.pop();
            },
          ),
          SizedBox(width: screenWidth * 0.02),
          CircleAvatar(
            radius: screenWidth * 0.07,
            backgroundImage: const AssetImage(AppAssets.account_circle),
          ),
          SizedBox(width: screenWidth * 0.03),
          Expanded(
            child: Text(
              username,
              style: const TextStyle(
                color: AppColors.textColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.more_vert,
              color: AppColors.textColor,
              size: 28,
            ),
            onPressed: () {
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical: 10,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
        decoration: BoxDecoration(
          color: AppColors.backgroundGradientEnd,
          borderRadius: BorderRadius.circular(30),
        ),
        child: TextField(
          enabled: false, // مؤقتًا لأن الإرسال مش شغال دلوقتي
          decoration: InputDecoration(
            hintText: 'Message...',
            hintStyle: const TextStyle(
              color: AppColors.secondaryTextColor,
              fontSize: 14,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
