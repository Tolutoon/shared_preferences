import 'package:flutter/material.dart';
import 'package:login/vendor_signup.dart';

void main() {
  runApp(MaterialApp(home: IndividualSignUp()));
}

class IndividualSignUp extends StatelessWidget {
  const IndividualSignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text('Individual'),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => VendorSignUp())));
                  },
                  child: Text('Sign Out'))
            ],
          ),
        ),
      ),
    );
  }
}
