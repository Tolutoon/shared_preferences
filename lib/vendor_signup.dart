import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: VendorSignUp()));
}


class VendorSignUp extends StatelessWidget {
  const VendorSignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Text('Vendor')),
      ),
    );
  }
}
