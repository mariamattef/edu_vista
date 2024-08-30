// import 'package:edu_vista/utils/color_utilis.dart';
// import 'package:flutter/material.dart';
// import 'package:line_awesome_flutter/line_awesome_flutter.dart';

// class ProfileMenuWidget extends StatelessWidget {
//   const ProfileMenuWidget({
//     Key? key,
//     required this.title,
//     required this.icon,
//     required this.onPress,
//     this.endIcon = true,
//     this.textColor,
//   }) : super(key: key);

//   final String title;
//   final IconData icon;
//   final VoidCallback onPress;
//   final bool endIcon;
//   final Color? textColor;

//   @override
//   Widget build(BuildContext context) {
//     var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
//     var iconColor = isDark ? ColorUtility.deepYellow : ColorUtility.gray;

//     return ListTile(
//       onTap: onPress,
//       leading: Container(
//         width: 40,
//         height: 40,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(100),
//           color: iconColor.withOpacity(0.1),
//         ),
//         child: Icon(icon, color: iconColor),
//       ),
//       title: Text(title, style: TextStyle(color: ColorUtility.main)),
//       trailing: endIcon
//           ? Container(
//               width: 30,
//               height: 30,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(100),
//                 color: Colors.grey.withOpacity(0.1),
//               ),
//               child: const Icon(LineAwesomeIcons.angle_right_solid,
//                   size: 18.0, color: Colors.grey))
//           : null,
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class ProfilePage extends StatelessWidget {
//   static const String id = 'ProfilePage';
//   const ProfilePage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: const Text("Profile"),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(vertical: 20),
//         child: Column(
//           children: [
//             const ProfilePicWidget(),
//             const SizedBox(height: 20),
//             ProfileMenu(
//               text: "My Account",
//               icon: "assets/icons/User Icon.svg",
//               press: () => {},
//             ),
//             ProfileMenu(
//               text: "Notifications",
//               icon: "assets/icons/Bell.svg",
//               press: () {},
//             ),
//             ProfileMenu(
//               text: "Settings",
//               icon: "assets/icons/Settings.svg",
//               press: () {},
//             ),
//             ProfileMenu(
//               text: "Help Center",
//               icon: "assets/icons/Question mark.svg",
//               press: () {},
//             ),
//             ProfileMenu(
//               text: "Log Out",
//               icon: "assets/icons/Log out.svg",
//               press: () {},
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ProfilePicWidget extends StatelessWidget {
//   const ProfilePicWidget({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 115,
//       width: 115,
//       child: Stack(
//         fit: StackFit.expand,
//         clipBehavior: Clip.none,
//         children: [
//           const CircleAvatar(
//             backgroundImage:
//                 NetworkImage("https://i.postimg.cc/0jqKB6mS/Profile-Image.png"),
//           ),
//           Positioned(
//             right: -16,
//             bottom: 0,
//             child: SizedBox(
//               height: 46,
//               width: 46,
//               child: TextButton(
//                 style: TextButton.styleFrom(
//                   foregroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(50),
//                     side: const BorderSide(color: Colors.white),
//                   ),
//                   backgroundColor: const Color(0xFFF5F6F9),
//                 ),
//                 onPressed: () {},
//                 child: SvgPicture.string('cameraIco'),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// class ProfileMenu extends StatelessWidget {
//   const ProfileMenu({
//     Key? key,
//     required this.text,
//     required this.icon,
//     this.press,
//   }) : super(key: key);

//   final String text, icon;
//   final VoidCallback? press;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       child: TextButton(
//         style: TextButton.styleFrom(
//           foregroundColor: const Color(0xFFFF7643),
//           padding: const EdgeInsets.all(20),
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//           backgroundColor: const Color(0xFFF5F6F9),
//         ),
//         onPressed: press,
//         child: Row(
//           children: [
//             SvgPicture.asset(
//               icon,
//               colorFilter:
//                   const ColorFilter.mode(Color(0xFFFF7643), BlendMode.srcIn),
//               width: 22,
//             ),
//             const SizedBox(width: 20),
//             Expanded(
//               child: Text(
//                 text,
//                 style: const TextStyle(
//                   color: Color(0xFF757575),
//                 ),
//               ),
//             ),
//             const Icon(
//               Icons.arrow_forward_ios,
//               color: Color(0xFF757575),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
