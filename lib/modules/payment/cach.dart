import 'package:flutter/material.dart';
import 'package:payment_c6/modules/register/register.dart';
import 'package:payment_c6/shared/common/constants.dart';

class CashScreen extends StatelessWidget {
  const CashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.teal,
        title: const Text('Cash'),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                    (route) => false);
              },
              child: const Text(
                'FINISH',
                style: TextStyle(color: Colors.white),
              ))
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You should go to any market to pay',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'This is your ref code',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Card(
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: Colors.teal,
                ),
                borderRadius: BorderRadius.circular(14.0),
              ),
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SelectableText(
                  REFCODE,
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
