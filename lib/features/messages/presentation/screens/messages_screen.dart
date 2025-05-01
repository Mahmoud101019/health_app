import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:health_app/features/messages/data/models/message_item.dart';
import '../../../../core/constants/colors.dart';
import '../blocs/messages_bloc.dart';
import '../blocs/messages_event.dart';
import '../blocs/messages_state.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  int _selectedIndex = 2; // Messages هي النشطة

  @override
  void initState() {
    super.initState();
    context.read<MessagesBloc>().add(LoadMessagesEvent());
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        context.go('/dashboard');
        break;
      case 1:
        context.go('/notifications');
        break;
      case 2:
        context.go('/messages');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: BlocBuilder<MessagesBloc, MessagesState>(
            builder: (context, state) {
              if (state is MessagesLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.textColor),
                );
              } else if (state is MessagesLoaded) {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: screenHeight * 0.015),
                          _buildHeader(screenWidth),
                          SizedBox(height: screenHeight * 0.02),
                          _buildSearchBar(screenWidth, screenHeight),
                          SizedBox(height: screenHeight * 0.02),
                        ],
                      ),
                    ),
                    Expanded(
                      child: _buildMessagesList(
                        screenWidth,
                        screenHeight,
                        state.messages,
                      ),
                    ),
                  ],
                );
              } else if (state is MessagesError) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(color: AppColors.textColor),
                  ),
                );
              }
              return const Center(
                child: Text(
                  'No Messages',
                  style: TextStyle(color: AppColors.textColor),
                ),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.backgroundGradientEnd,
        selectedItemColor: AppColors.textColor,
        unselectedItemColor: AppColors.secondaryTextColor,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: ''),
        ],
      ),
    );
  }

  Widget _buildHeader(double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(
            Icons.person,
            color: AppColors.secondaryTextColor,
            size: 28,
          ),
          onPressed: () {},
        ),
        Text(
          'Messages',
          style: Theme.of(
            context,
          ).textTheme.headlineLarge?.copyWith(fontSize: 20),
        ),
        IconButton(
          icon: const Icon(
            Icons.settings,
            color: AppColors.secondaryTextColor,
            size: 28,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildSearchBar(double screenWidth, double screenHeight) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
      decoration: BoxDecoration(
        color: AppColors.backgroundGradientEnd,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        enabled: false, // مؤقتًا لأن السيرش مش شغال دلوقتي
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: const TextStyle(
            color: AppColors.secondaryTextColor,
            fontSize: 14,
          ),
          border: InputBorder.none,
          icon: Icon(
            Icons.search,
            color: AppColors.secondaryTextColor,
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildMessagesList(
    double screenWidth,
    double screenHeight,
    List<MessageItem> messages,
  ) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        return GestureDetector(
          onTap: () {
            context.push('/chat', extra: message.username);
          },
          child: Padding(
            padding: EdgeInsets.only(bottom: screenHeight * 0.02),
            child: Row(
              children: [
                CircleAvatar(
                  radius: screenWidth * 0.07,
                  backgroundImage: AssetImage(message.userImage),
                ),
                SizedBox(width: screenWidth * 0.03),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message.username,
                        style: const TextStyle(
                          color: AppColors.textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.005),
                      Text(
                        message.preview,
                        style: const TextStyle(
                          color: AppColors.secondaryTextColor,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      message.time,
                      style: const TextStyle(
                        color: AppColors.secondaryTextColor,
                        fontSize: 12,
                      ),
                    ),
                    if (message.reaction != null) ...[
                      SizedBox(height: screenHeight * 0.005),
                      Text(
                        message.reaction!,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
