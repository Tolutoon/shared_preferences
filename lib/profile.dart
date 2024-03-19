import 'package:flutter/material.dart';
import 'package:login/individual_signup.dart';
import 'package:login/vendor_signup.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfileSetup extends StatelessWidget {
  const ProfileSetup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Profile Setup'),
              ElevatedButton(
                onPressed: () async {
                  SharedPreferences logindata =
                      await SharedPreferences.getInstance();
                  logindata.setBool('profileSetupCompleted', true);
                  // Navigate to appropriate page after profile setup
                  String selectedOption =
                      logindata.getString('selectedOption')!;
                  if (selectedOption == 'individual') {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => IndividualSignUp()),
                    );
                  } else if (selectedOption == 'vendor') {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => VendorSignUp()),
                    );
                  }
                },
                child: Text('Profile Complete'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
