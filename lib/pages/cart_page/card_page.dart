import 'package:edu_vista/blocs/cart/cart_bloc.dart';
import 'package:edu_vista/models/course.dart';
import 'package:edu_vista/pages/generalPage/course_details_page.dart';
import 'package:edu_vista/pages/generalPage/payment_page.dart';
import 'package:edu_vista/pages/paymob_manager/paymob_manager.dart';
import 'package:edu_vista/utils/color_utilis.dart';
import 'package:edu_vista/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';
import 'package:paymob_payment/paymob_payment.dart';
import 'package:url_launcher/url_launcher.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  static const String id = 'CartPage';

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    context.read<CartBloc>().add(LoadingCartEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtility.gbScaffold,
        title: const Text('Check Out'),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartUpdatState && state.itemcart.isNotEmpty) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        top: 10,
                        bottom: 10,
                      ),
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: .8,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemCount: state.itemcart.length,
                        itemBuilder: (context, index) {
                          var course = state.itemcart[index];
                          var rate = course.rating;
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                CourseDetailsPage.id,
                                arguments: course,
                              );
                            },
                            child: Wrap(
                              alignment: WrapAlignment.start,
                              children: [
                                Container(
                                  width: 140,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        course.image ?? 'No Image Found',
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Row(
                                    children: [
                                      Text(
                                        '${rate ?? 'No rank'}',
                                        style: const TextStyle(
                                          color: ColorUtility.grayExtraLight,
                                          fontSize: 11.4,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  course.title ?? 'No Title',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.person_2_outlined),
                                    Text(
                                      course.instructor?.name ?? 'No name',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 5,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '\$${course.price ?? ''}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w800,
                                          color: ColorUtility.main,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 30, right: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      TextButton(
                                        onPressed: () async {
                                          Navigator.pushNamed(
                                              context, PaymentPage.id);

                                          // PaymobPayment.instance.initialize(
                                          //   apiKey: dotenv.env[
                                          //       'apiKey']!, // from dashboard Select Settings -> Account Info -> API Key
                                          //   integrationID: int.parse(dotenv.env[
                                          //       'integrationID']!), // from dashboard Select Developers -> Payment Integrations -> Online Card ID
                                          //   iFrameID: int.parse(dotenv.env[
                                          //       'iFrameID']!), // from paymob Select Developers -> iframes
                                          // );

                                          // final PaymobResponse? response =
                                          //     await PaymobPayment.instance.pay(
                                          //   context: context,
                                          //   currency: "EGP",
                                          //   amountInCents: "20000", // 200 EGP
                                          // );

                                          // if (response != null) {
                                          //   print(
                                          //       'Response: ${response.transactionID}');
                                          //   print(
                                          //       'Response: ${response.success}');
                                          // }
                                        },
                                        child: const Text(
                                          'Check Out',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            BlocProvider.of<CartBloc>(context)
                                                .add(
                                              RemovingFromCartEvent(course),
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          )),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 25),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Total Price:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: ColorUtility.grayExtraLight),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    child: Text(
                                      '\$${state.totalPrice.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 17.54,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          ElevatedButton(
                            onPressed: () {
                              () async => _pay();
                            },
                            style: ElevatedButton.styleFrom(
                                fixedSize: const Size(100, 50),
                                shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(6))),
                            child: const Text('PayMob'),
                          )
                          // CustomElevatedButton(
                          //   width: double.infinity,
                          //   onPressed: () async {
                          //     Navigator.pushNamed(context, PaymentPage.id);

                          //     // PaymobPayment.instance.initialize(
                          //     //   apiKey: dotenv.env[
                          //     //       'apiKey']!, // from dashboard Select Settings -> Account Info -> API Key
                          //     //   integrationID: int.parse(dotenv.env[
                          //     //       'integrationID']!), // from dashboard Select Developers -> Payment Integrations -> Online Card ID
                          //     //   iFrameID: int.parse(dotenv.env[
                          //     //       'iFrameID']!), // from paymob Select Developers -> iframes
                          //     // );

                          //     final PaymobResponse? response =
                          //         await PaymobPayment.instance.pay(
                          //       context: context,
                          //       currency: "EGP",
                          //       amountInCents: "20000", // 200 EGP
                          //     );

                          //     if (response != null) {
                          //       // log('Response: ${response.transactionID}');
                          //       // log('Response: ${response.success}');
                          //     }
                          //   },

                          //   child: const Text('Check Out'),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: Text('Your cart is empty'),
          );
        },
      ),
    );
  }

  Future<void> _pay() async {
    PaymobManager().getPaymentKey(10, "EGP").then((String paymentKey) {
      launchUrl(
        Uri.parse(
            "https://accept.paymob.com/api/acceptance/iframes/791787?payment_token=$paymentKey"),
      );
    });
  }
}
