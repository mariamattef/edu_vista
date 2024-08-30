import 'package:edu_vista/bloc/bloc_course/course_bloc.dart';
import 'package:edu_vista/cubit/auth_cubit.dart';
import 'package:edu_vista/firebase_options.dart';
import 'package:edu_vista/pages/categories_page.dart';
import 'package:edu_vista/pages/profile_page.dart';
import 'package:edu_vista/pages/reset_password_page.dart';
import 'package:edu_vista/pages/course_details_page.dart';
import 'package:edu_vista/pages/home_page.dart';
import 'package:edu_vista/pages/login_page.dart';
import 'package:edu_vista/pages/onboarding_page.dart';
import 'package:edu_vista/pages/confirm_password_page.dart';
import 'package:edu_vista/pages/signup_page.dart';
import 'package:edu_vista/pages/splash_page.dart';
import 'package:edu_vista/pages/test2_page.dart';
import 'package:edu_vista/pages/test_screen.dart';
import 'package:edu_vista/services/pref.service.dart';
import 'package:edu_vista/services/storage.services.dart';
import 'package:edu_vista/utils/color_utilis.dart';
import 'package:edu_vista/pages/botton_nav_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesService.init();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print('Failed to initialize Firebase: $e');
  }
  FirebaseSrorageReference.init();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => AuthCubit(),
      ),
      BlocProvider(create: (ctx) => CourseBloc()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: _CustomScrollBehaviour(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: ColorUtility.gbScaffold),
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: ColorUtility.main,
          ),
        ),
        scaffoldBackgroundColor: ColorUtility.gbScaffold,
        fontFamily: ' PlusJakartaSans',
        colorScheme: ColorScheme.fromSeed(seedColor: ColorUtility.main),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) {
        final String routeName = settings.name ?? '';
        final dynamic data = settings.arguments;

        switch (routeName) {
          case LoginPage.id:
            return MaterialPageRoute(builder: (context) => const LoginPage());

          case SignUpPage.id:
            return MaterialPageRoute(builder: (context) => const SignUpPage());

          case ResetPasswordPage.id:
            return MaterialPageRoute(
                builder: (context) => const ResetPasswordPage());

          case ConfirmPasswrdPage.id:
            return MaterialPageRoute(
                builder: (context) => const ConfirmPasswrdPage());

          case OnBoardingpage.id:
            return MaterialPageRoute(
                builder: (context) => const OnBoardingpage());

          case HomePage.id:
            return MaterialPageRoute(builder: (context) => const HomePage());

          case CourseDetailsPage.id:
            return MaterialPageRoute(
                builder: (context) => CourseDetailsPage(
                      course: data,
                    ));
          case CategoriesPage.id:
            return MaterialPageRoute(
                builder: (context) => const CategoriesPage());
          case ProfilePage.id:
            return MaterialPageRoute(builder: (context) => const ProfilePage());
          case BottomNavPage.id:
            return MaterialPageRoute(
                builder: (context) => const BottomNavPage());
          case AudioCallingScreen.id:
            return MaterialPageRoute(
                builder: (context) => const AudioCallingScreen());

          // case Test2Page.id:
          //   return MaterialPageRoute(
          //       builder: (context) => Test2Page(
          //             categoryName: '',
          //           ));

          default:
            return MaterialPageRoute(builder: (context) => const SplashPage());
        }
      },
      initialRoute: SplashPage.id,
    );
  }
}

class _CustomScrollBehaviour extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.mouse,
        PointerDeviceKind.touch,
      };
}
