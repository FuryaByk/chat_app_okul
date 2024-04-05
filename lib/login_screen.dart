import 'package:chat_app/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
        title: Text(
          'Mirciler Chat App',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
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
                      .signInWithEmailAndPassword(
                          email: emailAddress, password: password);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ChatScreen()),
                  );
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    print('Kayıtlı e-posta bulunamadı');
                  } else if (e.code == 'wrong-password') {
                    print('Hatalı Şifre');
                  }
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
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
            )
          ],
        ),
      ),
    );
  }
}
//Firebase veritabanında veriler JSOn formatında saklanır.
//veriler key:value şeklindedir. Key ve value arasında : olmak zorundadır.
//NOT key ler "" içine yazılmak zorundadır. Aşağıda Örnek JSON verisi ekledik:
//   {
//      "adi":"Ayşe",
//      "soyadi":"GÜL",
//      "yas":26,
//      "askerlikDurumu":false,
//      "maas":25000.80,
//      "sevdigi_programlar":["dizi","film","gündüz kuşağı"]
//  }
/*JSON verilerin türleri aşağıdaki
türlerden birisi olabilir.
 */
// string
// number
// object (JSON object)
// array-dizi
// boolean
// null
