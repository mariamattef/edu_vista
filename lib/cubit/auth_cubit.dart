import 'dart:nativewrappers/_internal/vm/lib/developer.dart';

import 'package:edu_vista/pages/authPages/login_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vista/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  AuthCubit() : super(AuthInitial());

  Future<void> login({
    required BuildContext context,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  }) async {
    try {
      var credentials = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (credentials.user != null) {
        if (!context.mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('You Logged In Successfully'),
          ),
        );

        Navigator.pushReplacementNamed(context, HomePage.id);
      }
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No user found for that email.'),
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Wrong password provided for that user.'),
          ),
        );
      } else if (e.code == 'user-disabled') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User Disabled'),
          ),
        );
      } else if (e.code == 'invalid-credential') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid Credential'),
          ),
        );
      }
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong'),
        ),
      );
    }
  }

  Future<void> signUp({
    required BuildContext context,
    required TextEditingController nameController,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  }) async {
    try {
      var credentials =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      if (credentials.user != null) {
        credentials.user!.updateDisplayName(nameController.text);

        if (!context.mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account created successfully'),
          ),
        );
        Navigator.pushReplacementNamed(context, HomePage.id);
      }
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('The password provided is too weak.'),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('The account already exists for that email.'),
          ),
        );
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sign up Exception $e'),
        ),
      );
    }
  }

  Future<void> resetPassword({
    required BuildContext context,
    required TextEditingController emailController,
  }) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text,
      );

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password reset email sent'),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No user found for that email.'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to send password reset email'),
          ),
        );
      }
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong'),
        ),
      );
    }
  }

  Future<void> submitPassword({
    required BuildContext context,
    required TextEditingController passwordController,
    required TextEditingController confirmPasswordController,
  }) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.updatePassword(passwordController.text);

        if (!context.mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password updated successfully'),
          ),
        );
        Navigator.pushReplacementNamed(context, HomePage.id);
      }
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('The password provided is too weak.'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to update password'),
          ),
        );
      }
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong'),
        ),
      );
    }
  }

  Future<void> deleteUser(BuildContext context) async {
    emit(AuthDeleteLoadingState());

    try {
      var user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        emit(AuthDeleteFailingState('No user logged'));
        return;
      }

      await user.delete();
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      emit(AuthDeleteSuccessededState(' deleting success'));
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('deleting success'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacementNamed(context, LoginPage.id);
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthDeleteFailingState(
          e.message ?? 'An error occurred while deleting the account.'));
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message ?? 'Failed deleting account'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      emit(AuthDeleteFailingState('Something went wrong'));
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Something went wrong'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      emit(Unauthenticated());
      Navigator.of(context).pushReplacementNamed(HomePage.id);
    } catch (e) {
      print('Errrror in LogOut $e');
    }
  }

//   // Future<void> updateDisplayName(String name, BuildContext context) async {
//     emit(UserNameUpdateLoading());
//     try {
//       var credentials = FirebaseAuth.instance.currentUser;
//       if (credentials == null) {
//         emit(UserNameUpdateFailed('No user logged in'));
//       } else {
//         await credentials.updateDisplayName(name);
//         await credentials.reload();
//         log('Name updated to: ${credentials.displayName}');
//         emit(UserNameUpdateSuccess('Name updated successfully'));
//         if (context.mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               backgroundColor: Colors.green,
//               content: Text('Name updated successfully'),
//             ),
//           );
//         }
//       }
//     } catch (e) {
//       emit(UserNameUpdateFailed(e.toString()));
//       if (!context.mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error updating name: $e')),
//       );
//     }
//   }
// //

  Future<void> uploadProfilePicture(BuildContext context) async {
    emit(UProPicUpdateLoadingState());

    var imageResult = await FilePicker.platform
        .pickFiles(type: FileType.image, withData: true);

    if (imageResult != null) {
      var storageRef = FirebaseStorage.instance
          .ref('images/${imageResult!.files.first.name}');

      var uploadResult = await storageRef.putData(
          imageResult.files.first.bytes!,
          SettableMetadata(
            contentType:
                'image/${imageResult.files.first.name.split('.').last}',
          ));
      if (uploadResult.state == TaskState.success) {
        var downloadUrl = await uploadResult.ref.getDownloadURL();
        log('Image upload $downloadUrl');

        emit(UProPicUpdateSuccessState('Profile picture updated successfully'));
      } else {
        emit(UProPicUpdateFailedState('Failed to upload profile picture'));
      }
    }
  }
}
