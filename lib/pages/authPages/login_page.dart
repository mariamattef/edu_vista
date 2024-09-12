import 'package:edu_vista/cubit/auth_cubit.dart';
import 'package:edu_vista/widgets/auth/auth_template.widget.dart';
import 'package:edu_vista/widgets/custom_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'LoginPage';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthTemplateWidget(
      onLogin: () async {
        await context.read<AuthCubit>().login(
            context: context,
            emailController: emailController,
            passwordController: passwordController);
      },
      body: Form(
        key: formKey,
        child: Column(
          children: [
            CustomTextFormField(
              controller: emailController,
              hintText: 'Demo@gmail.com',
              labelText: 'Email',
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Your Password';
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              controller: passwordController,
              hintText: '***********',
              labelText: 'Password',
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Your Password';
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  getValidate(String value, String title) {
    if (value == null || value.isEmpty) {
      return title;
    }
  }
}
