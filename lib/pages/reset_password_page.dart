import 'package:edu_vista/cubit/auth_cubit.dart';
import 'package:edu_vista/widgets/custom_elevated_button.dart';
import 'package:edu_vista/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});
  static const id = 'ResetPasswordPage';

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  late TextEditingController passwordController;
  late TextEditingController confirmpPasswordControllerr;

  bool _isLoading = false;
  @override
  void initState() {
    passwordController = TextEditingController();
    confirmpPasswordControllerr = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmpPasswordControllerr.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
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
              Form(
                  child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                  return Column(
                    children: [
                      CustomTextFormField(
                        hintText: '***********',
                        labelText: 'Password',
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        hintText: '***********',
                        labelText: 'Confirm Password',
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomElevatedButton(
                              onPressed: () async {
                                if (state is resetPasswordLoadingStete) {
                                  CircularProgressIndicator();
                                }
                                if (state is resetPasswordSuccessStete) {
                                  await context
                                      .read<AuthCubit>()
                                      .submitPassword(
                                        context: context,
                                        passwordController: passwordController,
                                        confirmPasswordController:
                                            confirmpPasswordControllerr,
                                      );
                                }
                                if (state is resetPasswordFailedStete) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Failed to reset password ${state.error}')));
                                }
                              },
                              child: const Text(
                                'SUBMIT',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  );
                }),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
