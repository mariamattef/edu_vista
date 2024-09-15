import 'package:edu_vista/models/chat.dart';
import 'package:edu_vista/pages/chatPages/calls_search_page.dart';
import 'package:edu_vista/pages/chatPages/contacts_page.dart';
import 'package:edu_vista/pages/chatPages/message_page.dart';
import 'package:edu_vista/pages/chatPages/search_chat_page.dart';
import 'package:edu_vista/utils/color_utilis.dart';
import 'package:flutter/material.dart';

class ChatsPage extends StatefulWidget {
  static const id = 'ChatsPage';

  const ChatsPage({super.key});

  @override
  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  bool showActiveOnly = false; // Track whether to show only active chats

  @override
  Widget build(BuildContext context) {
    // Filter chats based on whether 'showActiveOnly' is true or false
    List<Chat> displayedChats = showActiveOnly ? chatsData.where((chat) => chat.isActive).toList() : chatsData;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: ColorUtility.deepYellow,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Text("Chats"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, ContactSearchChatPage.id);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
            color: ColorUtility.deepYellow,
            child: Row(
              children: [
                FillOutlineButton(
                  press: () {
                    setState(() {
                      showActiveOnly = false;
                      // Show recent messages
                    });
                  },
                  text: "Recent Message",
                  isFilled: !showActiveOnly,
                ),
                const SizedBox(width: 16.0),
                FillOutlineButton(
                  press: () {
                    setState(() {
                      showActiveOnly = true; // Show only active chats
                    });
                  },
                  text: "Active",
                  isFilled: showActiveOnly,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: displayedChats.length,
              itemBuilder: (context, index) => ChatCard(
                chat: displayedChats[index],
                //  press: () {
                //   Navigator.pushNamed(context, MessagesPage.id, arguments: chat);
                // },
                press: () {
                  // send user to the chat screen
                  Navigator.pushNamed(context, MessagesPage.id, arguments: displayedChats[index]);
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, ContactsPage.id);
        },
        backgroundColor: ColorUtility.deepYellow,
        child: const Icon(
          Icons.person_add_alt_1,
          color: Colors.white,
        ),
      ),
    );
  }
}

class ChatCard extends StatelessWidget {
  const ChatCard({
    super.key,
    required this.chat,
    required this.press,
  });

  final Chat chat;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0 * 0.75),
        child: Row(
          children: [
            CircleAvatarWithActiveIndicator(
              image: chat.image,
              isActive: chat.isActive,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chat.name ?? '',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    Opacity(
                      opacity: 0.64,
                      child: Text(
                        chat.lastMessage ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Opacity(
              opacity: 0.64,
              child: Text(chat.time ?? ''),
            ),
          ],
        ),
      ),
    );
  }
}

class FillOutlineButton extends StatelessWidget {
  const FillOutlineButton({
    super.key,
    this.isFilled = true,
    required this.press,
    required this.text,
  });

  final bool isFilled;
  final VoidCallback press;
  final String text;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: const BorderSide(color: Colors.white),
      ),
      elevation: isFilled ? 2 : 0,
      color: isFilled ? Colors.white : Colors.transparent,
      onPressed: press,
      child: Text(
        text,
        style: TextStyle(
          color: isFilled ? const Color(0xFF1D1D35) : Colors.white,
          fontSize: 12,
        ),
      ),
    );
  }
}

class CircleAvatarWithActiveIndicator extends StatelessWidget {
  const CircleAvatarWithActiveIndicator({
    super.key,
    this.image,
    this.radius = 24,
    this.isActive,
  });

  final String? image;
  final double? radius;
  final bool? isActive;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: radius,
          backgroundImage: NetworkImage(image!),
        ),
        if (isActive!)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              height: 16,
              width: 16,
              decoration: BoxDecoration(
                color: const Color(0xFF00BF6D),
                shape: BoxShape.circle,
                border: Border.all(color: Theme.of(context).scaffoldBackgroundColor, width: 3),
              ),
            ),
          )
      ],
    );
  }
}
