import 'package:flutter/material.dart';
import 'package:payment_c6/modules/payment/visa.dart';
import '../../shared/common/components.dart';
import 'cach.dart';

class ToggleScreen extends StatelessWidget {
  const ToggleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 18.0,
                  bottom: 6.0,
                ),
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios)),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  NavigateAndFinish(context, VisCard());
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/realistic-credit-card-design.png',
                            width: double.infinity,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Payment With Card',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  NavigateTo(context, const CashScreen());
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/point-sale-machine-design-resource.png',
                            width: double.infinity,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Payment With Cash',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),

          ],
        ),
      ),
    );
  }
}
