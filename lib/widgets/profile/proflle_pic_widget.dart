import 'package:edu_vista/cubit/auth_cubit.dart';
import 'package:edu_vista/utils/color_utilis.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePicWidget extends StatelessWidget {
  ProfilePicWidget({super.key});
  final User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      var proPictureUrl = user?.photoURL;
      if (state is UProPicUpdateLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is UProPicUpdateSuccessState) {
        proPictureUrl = state.downloadUrl;
      }
      return SizedBox(
        height: 114,
        width: 114,
        child: Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
                backgroundImage:
                    proPictureUrl != null && proPictureUrl.isNotEmpty
                        ? NetworkImage(proPictureUrl) as ImageProvider
                        : const AssetImage('assets/images/Personal_photo.png')),
            Positioned(
              top: 120,
              left: 5,
              child: Column(
                children: [
                  Text(
                    user?.displayName ?? 'No Name',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    user?.email ?? 'No email',
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            Positioned(
              right: -20,
              bottom: 10,
              child: IconButton(
                style: TextButton.styleFrom(
                    alignment: Alignment.topCenter,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: Colors.black),
                    ),
                    backgroundColor: const Color(0xFFF5F6F9),
                    fixedSize: Size(25, 25)),
                onPressed: () async {
                  await context.read<AuthCubit>().uploadProfilePicture(context);
                  print('>>>>>>>>$proPictureUrl');
                },
                icon: Icon(
                  Icons.photo_camera_back,
                  color: Colors.grey,
                  size: 33,
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
