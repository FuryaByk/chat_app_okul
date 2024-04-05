import 'dart:ui';

import 'package:chat_app/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Container> msg = [];
  List<Text> txt = [];
  late String eposta = 'mirciler@gmail.com';
  late String mesaj = 'selam';
  final user = FirebaseAuth.instance.currentUser;

  CollectionReference mesajlar =
      FirebaseFirestore.instance.collection('mesajlar');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AktifKullanici();
    getList();
    print(eposta);
  }

  void AktifKullanici() {
    if (user != null) {
      eposta = user!.email.toString();
    } else {
      print('Çıkış Yapıldı');
    }
  }

  Future<void> addMesagge() {
    return mesajlar
        .add({'gonderen': eposta, 'mesaj': mesaj, 'zaman': DateTime.now()})
        .then((value) => print("Mesaj EKlendi"))
        .catchError((error) => print("Mesaj eklenemedi: $error"));
  }

  void messageStream() async {
    await for (var snapshot in firestore.collection('mesajlar').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.get('mesaj'));
      }
    }
  }

  void getList() async {
    await for (var snapshot in firestore.collection('mesajlar').snapshots()) {
      for (var message in snapshot.docs) {
        txt.add(Text(message.get('mesaj')));
        print(message.get('mesaj'));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                final cikis = await FirebaseAuth.instance.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WelcomeScreen()),
                );
              },
              icon: Icon(Icons.backspace_outlined))
        ],
        backgroundColor: Colors.blueAccent,
        title: Row(
          children: [
            Image.asset(
              'images/simsek.png',
              width: 30,
            ),
            Text('Mesajlar'),
          ],
        ),
        //leading: Image.asset('images/simsek.png'),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('mesajlar')
                    .orderBy('zaman')
                    .snapshots(),
                builder: (context, snapshot) {
                  bool kim = false;
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.blue,
                      ),
                    );
                  }
                  final gelenMesajlar = snapshot.data?.docs;
                  List<Padding> mesajWidget = [];
                  for (var message in gelenMesajlar!) {
                    final mesaj = message.get('mesaj');
                    final gonderen = message.get('gonderen');
                    if (gonderen == user?.email) {
                      kim = true;
                    } else {
                      kim = false;
                    }
                    final messageWidget = Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: kim
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Text('$gonderen '),
                          Material(
                            elevation: 10,
                            borderRadius: kim
                                ? BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30))
                                : BorderRadius.only(
                                    topRight: Radius.circular(30),
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30)),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text('Mesaj: $mesaj'),
                            ),
                            color: kim ? Colors.lightBlue : Colors.redAccent,
                          ),
                        ],
                      ),
                    );
                    mesajWidget.add(messageWidget);
                  }
                  return Expanded(
                      child: ListView(
                    children: mesajWidget,
                    reverse: false,
                  ));
                }),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      mesaj = value;
                    },
                    decoration:
                        InputDecoration(labelText: 'Mesajınzı buraya yazın'),
                  ),
                ),
                FilledButton(
                  onPressed: () async {
                    addMesagge();
                    msg.clear();
                  },
                  child: Text('Gönder'),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.blueAccent)),
                )
              ],
            )
          ]),
    );
  }
}

// Container(
// padding: EdgeInsets.all(10),
// decoration: BoxDecoration(
// borderRadius: BorderRadius.only(
// topLeft: Radius.circular(30),
// bottomLeft: Radius.circular(30),
// bottomRight: Radius.circular(30)),
// color: Colors.lightBlue,
// ),
// margin:
// EdgeInsets.symmetric(vertical: 10, horizontal: 5),
// child: Text('Gönderen: $gonderen Mesaj: $mesaj'))
