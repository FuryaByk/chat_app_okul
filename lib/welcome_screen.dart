import 'package:chat_app/login_screen.dart';
import 'package:chat_app/register_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Mirciler Chat App',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      backgroundColor: Colors.blueGrey,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Hero(
                tag: 'res',
                child: Image.asset(
                  'images/simsek.png',
                  width: 75,
                  height: 75,
                ),
              ),
              Text('Mirciler Chat', style: TextStyle(fontSize: 50))
            ]),
            SizedBox(
              height: 30,
            ),
            FilledButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Giriş Yap',
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.blueAccent),
                textStyle: MaterialStatePropertyAll(
                  TextStyle(fontSize: 20),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            FilledButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterScreen()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text('Üye Ol'),
              ),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Colors.lightBlueAccent),
                  textStyle: MaterialStatePropertyAll(
                    TextStyle(fontSize: 20),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
