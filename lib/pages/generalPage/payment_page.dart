import 'package:edu_vista/pages/paymob_manager/paymob_manager.dart';
import 'package:edu_vista/utils/color_utilis.dart';
import 'package:edu_vista/widgets/custom_elevated_button.dart';
import 'package:edu_vista/widgets/widdgits/expansion_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentPage extends StatefulWidget {
  final bool isexpanded;
  PaymentPage({super.key, this.isexpanded = false});

  static const String id = 'PaymentPage';

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtility.gbScaffold,
        title: const Text(
          'Payment Method',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: ColorUtility.mediumlBlack,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: ColorUtility.main,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 180,
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
          ],
        ),
      ),
    );
  }

  // Future<void> _pay() async {
  //   print('>>>>>>>>>>>>>>object');
  //   PaymobManager().getPaymentKey(10, "Egp").then((String paymentKey) {
  //     launchUrl(
  //       Uri.parse(
  //           "https://accept.paymob.com/api/acceptance/iframes/868771?payment_token=$paymentKey"),
  //     );
  //   });
  //    print('>>>>>>>>>>>>>>object');
  // }
  Future<void> _pay() async {
    PaymobManager().getPaymentKey(10, "EGP").then((String paymentKey) {
      launchUrl(
        Uri.parse(
            "https://accept.paymob.com/api/acceptance/iframes/791787?payment_token=$paymentKey"),
      );
    });
  }
}
