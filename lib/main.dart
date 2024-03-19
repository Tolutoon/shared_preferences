import 'package:flutter/material.dart';
import 'package:login/individual_signup.dart';
import 'package:login/profile.dart';
import 'package:login/vendor_signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUp(),
    );
  }
}

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

List<Map<String, dynamic>> data = [
  {
    "title": "Individual",
    "value": "individual",
    "text": "I'm an Individual,\nLooking for a service."
  },
  {
    "title": "Vendor",
    "value": "vendor",
    "text": "I'm a vendor,\nLooking for a client."
  }
];

class _SignUpState extends State<SignUp> {
  late SharedPreferences logindata;
  late String selectedOption;

  @override
  void initState() {
    super.initState();
    selectedOption = 'None selected';
    checkIfAlreadySelected();
  }

  void checkIfAlreadySelected() async {
    logindata = await SharedPreferences.getInstance();
    if (logindata.containsKey('selectedOption')) {
      setState(() {
        selectedOption = logindata.getString('selectedOption')!;
      });
      navigateToSelectedPage();
    }
  }

  void navigateToSelectedPage() {
    if (selectedOption == 'individual') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => IndividualSignUp()),
      );
    } else if (selectedOption == 'vendor') {
      bool isFirstTimeVendorPageClicked =
          !logindata.containsKey('vendorPageClicked');
      if (isFirstTimeVendorPageClicked) {
        logindata.setBool('vendorPageClicked', true);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfileSetup()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => VendorSignUp()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: const Text(
                    'Sign-Up',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                ...data
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: RadioListTile<String>(
                          title: Text(
                            e['text'],
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          value: e['value'],
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setState(() {
                              selectedOption = value!;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.trailing,
                          tileColor: Colors.white,
                          selectedTileColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: Colors.grey),
                          ),
                          contentPadding: const EdgeInsets.all(20),
                        ),
                      ),
                    )
                    .toList(),
                const SizedBox(height: 70),
                ElevatedButton(
                  onPressed: () {
                    logindata.setString('selectedOption', selectedOption);
                    navigateToSelectedPage();
                  },
                  child: const Text(
                    'Next',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 100,
                      vertical: 20,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
