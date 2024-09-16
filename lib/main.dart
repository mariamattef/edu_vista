import 'package:edu_vista/blocs/cart/cart_bloc.dart';
import 'package:edu_vista/blocs/course/course_bloc.dart';
import 'package:edu_vista/blocs/lecture/lecture_bloc.dart';
import 'package:edu_vista/cubit/auth_cubit.dart';
import 'package:edu_vista/firebase_options.dart';
import 'package:edu_vista/pages/cart_page/shop_items_page.dart';
import 'package:edu_vista/pages/generalPage/all_categories_page.dart';
import 'package:edu_vista/pages/generalPage/category_course_page.dart';
import 'package:edu_vista/pages/chatPages/calls_search_page.dart';
import 'package:edu_vista/pages/cart_page/card_page.dart';
import 'package:edu_vista/pages/chatPages/chat_page.dart';
import 'package:edu_vista/pages/chatPages/contacts_page.dart';
import 'package:edu_vista/pages/profilePages/about_us_page.dart';
import 'package:edu_vista/pages/profilePages/edit_profile_page.dart';
import 'package:edu_vista/pages/chatPages/message_page.dart';
import 'package:edu_vista/pages/profilePages/profile_page.dart';
import 'package:edu_vista/pages/chatPages/search_chat_page.dart';
import 'package:edu_vista/pages/profilePages/settings_profile_page.dart';
import 'package:edu_vista/pages/authPages/reset_password_page.dart';
import 'package:edu_vista/pages/generalPage/course_details_page.dart';
import 'package:edu_vista/pages/generalPage/home_page.dart';
import 'package:edu_vista/pages/authPages/login_page.dart';
import 'package:edu_vista/pages/authPages/onboarding_page.dart';
import 'package:edu_vista/pages/authPages/confirm_password_page.dart';
import 'package:edu_vista/pages/authPages/signup_page.dart';
import 'package:edu_vista/pages/authPages/splash_page.dart';
import 'package:edu_vista/pages/generalPage/search_page.dart';
import 'package:edu_vista/services/pref.service.dart';
import 'package:edu_vista/services/storage.services.dart';
import 'package:edu_vista/utils/color_utilis.dart';
import 'package:edu_vista/utils/const_apikey.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paymob_payment/paymob_payment.dart';

import 'models/chat.dart';

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
  PaymobPayment.instance.initialize(
    apiKey: kConstants.payMobApikey,
    integrationID: kConstants.cardPaymentMethodIntegrationId,
    iFrameID: kConstants.iframeID,
  );
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => AuthCubit()),
      BlocProvider(create: (ctx) => CourseBloc()),
      BlocProvider(create: (ctx) => LectureBloc()),
      BlocProvider(create: (ctx) => CartBloc()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: _CustomScrollBehaviour(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: ColorUtility.gbScaffold),
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
          case AllCategoryPage.id:
            return MaterialPageRoute(builder: (context) => AllCategoryPage());

          case ProfilePage.id:
            return MaterialPageRoute(builder: (context) => ProfilePage());

          case CartPage.id:
            return MaterialPageRoute(builder: (context) => const CartPage());
          case CategoryCoursesPage.id:
            return MaterialPageRoute(
                builder: (context) => CategoryCoursesPage(
                      categoryName: data,
                    ));
          case EditProfilePage.id:
            return MaterialPageRoute(
                builder: (context) => const EditProfilePage());
          case AboutUsPage.id:
            return MaterialPageRoute(builder: (context) => const AboutUsPage());
          case SettingsProfilePage.id:
            return MaterialPageRoute(
                builder: (context) => const SettingsProfilePage());

          case ChatsPage.id:
            return MaterialPageRoute(builder: (context) => const ChatsPage());
          case CallsSearchPage.id:
            return MaterialPageRoute(
                builder: (context) => const CallsSearchPage());
          case ContactsPage.id:
            return MaterialPageRoute(
                builder: (context) => const ContactsPage());
          case MessagesPage.id:
            return MaterialPageRoute(
                builder: (context) => MessagesPage(chat: data as Chat));
          case ContactSearchChatPage.id:
            return MaterialPageRoute(
                builder: (context) => ContactSearchChatPage());

          case ShopItemsPage.id:
            return MaterialPageRoute(
                builder: (context) => const ShopItemsPage());

          case SearchPage.id:
            return MaterialPageRoute(builder: (context) => const SearchPage());

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
