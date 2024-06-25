import 'package:flutter/material.dart';
import 'package:uas_ambw/home.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final TextEditingController pinController = TextEditingController();

  Future<void> checkPin(BuildContext context) async {
    String enteredPin = pinController.text;

    final box = await Hive.openBox('pin');

    String? storedPin = box.get(0);

    if (enteredPin == storedPin) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Incorrect PIN'),
            content: Text('Please enter the correct PIN.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> createPin(BuildContext context) async {
    final box = await Hive.openBox('pin');

    box.put(0, pinController.text);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );
  }

  Future<String?> checkPinExist() async {
    final box = await Hive.openBox('pin');

    String? storedPin = box.get(0);
    return storedPin;
  }

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: checkPinExist(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading data'));
          } else {
            bool result = snapshot.data == null;
            if (result) {
              return Scaffold(
                body: Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.35),
                        child: TextField(
                          controller: pinController,
                          obscureText: true,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(6)
                          ],
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter a new PIN',
                          ),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.width * 0.03),
                      ElevatedButton(
                        onPressed: () {
                          createPin(context);
                        },
                        child: Text('Create PIN'),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Scaffold(
                body: Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.35),
                        child: TextField(
                          controller: pinController,
                          obscureText: true,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(6)
                          ],
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter your PIN',
                          ),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.width * 0.03),
                      ElevatedButton(
                        onPressed: () {
                          checkPin(context);
              //             Navigator.pushReplacement(
              // context, MaterialPageRoute(builder: (context) => Home()));
                        },
                        child: Text('Login'),
                      ),
                    ],
                  ),
                ),
              );
            }
          }
        });
  }
}
