import 'package:flutter/material.dart';
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
    if (logindata.containsKey('profileSetupCompleted')) {
      // Profile setup is completed, navigate to appropriate page
      if (selectedOption == 'individual') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => IndividualSignUp()),
        );
      } else if (selectedOption == 'vendor') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => VendorSignUp()),
        );
      }
    } else {
      // Profile setup not completed, navigate to profile setup page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProfileSetup()),
      );
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