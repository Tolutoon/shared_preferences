// import 'package:eventapp/main.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:keycloak_wrapper/keycloak_wrapper.dart';
import "package:shared_preferences/shared_preferences.dart";

final selectedOptionProvider = StateProvider<String>((ref) => '');

class SignUp extends ConsumerStatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  ConsumerState<SignUp> createState() => _SignUpState();
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

class _SignUpState extends ConsumerState<SignUp> {
  // ignore: unused_field
  bool _isLoggedIn = false;
  String selectedOption = 'None selected';

  late SharedPreferences logindata;
  late bool newuser;
  late String individualUser;
  late String vendorUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check_if_already_selected();
  }

  void check_if_already_selected() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    individualUser = (logindata.getString('individual') ?? 'individual');
    vendorUser = (logindata.getString('vendor') ?? 'vendor');

    print(newuser);

    if (newuser == false) {
      if (selectedOption == 'individual') {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: ((context) => IndividualSignUp())));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => VendorSignUp()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                  'Sign-Up',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              ...data
                  .map((e) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: SizedBox(
                          width: 350,
                          height: 150,
                          child: RadioMenuButton(
                            value: e['value'],
                            groupValue: selectedOption,
                            onChanged: (_) {
                              setState(() {
                                selectedOption = _;
                              });
                              // final config = KeycloakConfig(
                              //   bundleIdentifier: 'com.issl.eventapp',
                              //  clientId: 'flutter-cli',
                              // frontendUrl: 'https://keycloak.issl.ng',
                              //  realm: 'Testing');

                              //  keycloakWrapper.login(config).then((value) {
                              //   ref
                              //  .read(selectedOptionProvider.notifier)
                              //  .state = _;
                              //  });
                              print(_);
                            },
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side:
                                          const BorderSide(color: Colors.grey)),
                                ),
                                elevation: MaterialStateProperty.all(2),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white)),
                            child: Text(
                              e['text'],
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
              const SizedBox(height: 70),
              ElevatedButton(
                onPressed: () {
                  if (selectedOption == 'individual') {
                    logindata.setString('individual', 'individual');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => IndividualSignUp()),
                    );
                  } else {
                    logindata.setString('vendor', 'vendor');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VendorSignUp()),
                    );
                  }
                },
                //selectedOption != 'None selected'
                //  ? () async {
                //    final config = KeycloakConfig(
                //      bundleIdentifier: 'com.issl.eventapp',
                //    clientId: 'flutter-cli',
                //  frontendUrl: 'https://keycloak.issl.ng',
                //realm: 'Testing');

                // final isLoggedIn = await keycloakWrapper.login(config);
                // setState(() {
                // _isLoggedIn = isLoggedIn;
                // });

                // final selectedOptions =
                //    ref.read(selectedOptionProvider);
                //  print(selectedOptions);

                //  : null,
                child: const Text(
                  'Next',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 20),
                    textStyle: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }
}


class IndividualSignUp extends StatelessWidget {
  const IndividualSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Text('Individual')),
      ),
    );
  }
}

class VendorSignUp extends StatelessWidget {
  const VendorSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Text('Vendor')),
      ),
    );
  }
}