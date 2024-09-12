import 'package:flutter/material.dart';

class CallsSearchPage extends StatelessWidget {
  static const id = 'CallsSearchPage';
  const CallsSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: const Color(0xFF00BF6D),
        foregroundColor: Colors.white,
        title: const Text("Calls"),
      ),
      body: Column(
        children: [
          // Appbar search
          Container(
            margin: const EdgeInsets.only(bottom: 16.0),
            padding: const EdgeInsets.fromLTRB(
              16.0,
              0,
              16.0,
              16.0,
            ),
            color: const Color(0xFF00BF6D),
            child: Form(
              child: TextFormField(
                autofocus: true,
                textInputAction: TextInputAction.search,
                onChanged: (value) {
                  // search
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  prefixIcon: Icon(
                    Icons.search,
                    color: const Color(0xFF1D1D35).withOpacity(0.64),
                  ),
                  hintText: "Search",
                  hintStyle: TextStyle(
                    color: const Color(0xFF1D1D35).withOpacity(0.64),
                  ),
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0 * 1.5, vertical: 16.0),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SafeArea(
              child: ListView(
                children: [
                  // For demo
                  ...List.generate(
                    demoContactsImage.length,
                    (index) => CallHistoryCard(
                      name: "Darlene Robert",
                      image: demoContactsImage[index],
                      time: "3m ago",
                      isActive: index.isEven,
                      isOutgoingCall: index.isOdd,
                      isVideoCall: index.isEven,
                      press: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CallHistoryCard extends StatelessWidget {
  const CallHistoryCard({
    super.key,
    required this.name,
    required this.time,
    required this.isActive,
    required this.isVideoCall,
    required this.isOutgoingCall,
    required this.image,
    required this.press,
  });

  final String name, time, image;
  final bool isActive, isVideoCall, isOutgoingCall;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 16.0 / 2,
      ),
      onTap: press,
      leading: CircleAvatarWithActiveIndicator(
        image: image,
        isActive: isActive,
        radius: 28,
      ),
      title: Text(name),
      subtitle: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0 / 2),
        child: Row(
          children: [
            Icon(
              isOutgoingCall ? Icons.north_east : Icons.south_west,
              size: 16,
              color: isOutgoingCall
                  ? Theme.of(context).primaryColor
                  : const Color(0xFFF03738),
            ),
            const SizedBox(width: 16.0 / 2),
            Text(
              time,
              style: TextStyle(
                color: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .color!
                    .withOpacity(0.64),
              ),
            ),
          ],
        ),
      ),
      trailing: Icon(
        isVideoCall ? Icons.videocam : Icons.call,
        color: Theme.of(context).primaryColor,
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
                border: Border.all(
                    color: Theme.of(context).scaffoldBackgroundColor, width: 3),
              ),
            ),
          )
      ],
    );
  }
}

final List<String> demoContactsImage = [
  'https://i.postimg.cc/g25VYN7X/user-1.png',
  'https://i.postimg.cc/cCsYDjvj/user-2.png',
  'https://i.postimg.cc/sXC5W1s3/user-3.png',
  'https://i.postimg.cc/4dvVQZxV/user-4.png',
  'https://i.postimg.cc/FzDSwZcK/user-5.png',
];
