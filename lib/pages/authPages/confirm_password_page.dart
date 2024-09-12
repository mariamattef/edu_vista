import 'package:edu_vista/cubit/auth_cubit.dart';
import 'package:edu_vista/pages/authPages/reset_password_page.dart';
import 'package:edu_vista/widgets/custom_elevated_button.dart';
import 'package:edu_vista/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmPasswrdPage extends StatefulWidget {
  static const String id = 'ConfirmPasswrdPage';
  const ConfirmPasswrdPage({super.key});

  @override
  State<ConfirmPasswrdPage> createState() => _ConfirmPasswrdPageState();
}

class _ConfirmPasswrdPageState extends State<ConfirmPasswrdPage> {
  final _email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const Text(
              'Reset Password',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomTextFormField(
                controller: _email,
                hintText: 'Demo@gmail.com',
                labelText: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      onPressed: () async {
                        await context.read<AuthCubit>().resetPassword(
                              context: context,
                              emailController: _email,
                            );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Password reset link sent to your email',
                            ),
                          ),
                        );
                        Navigator.pushNamed(context, ResetPasswordPage.id);
                      },
                      child: const Text(
                        'SUBMIT',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
