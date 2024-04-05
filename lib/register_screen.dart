import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late String emailAddress;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.backspace_outlined))
        ],
        backgroundColor: Colors.blueAccent,
        title: Text('Mirciler Chat App',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: 'res',
              child: Image.asset(
                'images/simsek.png',
                width: 200,
                height: 200,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              onChanged: (value) {
                emailAddress = value;
              },
              //textAlign: TextAlign.center,
              decoration: InputDecoration(
                labelText: 'E posta Giriniz',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              onChanged: (value) {
                password = value;
              },
              obscureText: true,
              //textAlign: TextAlign.center,
              decoration: InputDecoration(
                labelText: 'Şifre Giriniz',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            FilledButton(
              onPressed: () async {
                try {
                  final credential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: emailAddress,
                    password: password,
                  );
                  print('Kullanıcı başarıyla eklendi.');
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    print('Şifre en az 6 haneli olmalı.');
                  } else if (e.code == 'email-already-in-use') {
                    print('Bu hesap zaten var.');
                  }
                } catch (e) {
                  print(e);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Üye Ol',
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.blueAccent),
                textStyle: MaterialStatePropertyAll(
                  TextStyle(fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
