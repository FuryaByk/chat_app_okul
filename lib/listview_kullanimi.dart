import 'package:flutter/material.dart';

class Listview extends StatelessWidget {
  const Listview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        //reverse: true,
        //scrollDirection: Axis.horizontal,
        padding: EdgeInsets.all(20),
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.deepOrange,
            ),
            margin: EdgeInsets.only(top: 20, bottom: 20),
            padding: EdgeInsets.all(10),
            child: Text('Kutu 1'),
          ),
          Divider(
            thickness: 3,
            height: 5,
            color: Colors.blueGrey,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.lightBlueAccent,
            ),
            margin: EdgeInsets.only(top: 20, bottom: 20),
            padding: EdgeInsets.all(10),
            child: Text('Kutu 2'),
          ),
          Divider(
            thickness: 3,
            height: 5,
            color: Colors.blueGrey,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.lightGreen,
            ),
            margin: EdgeInsets.only(top: 20, bottom: 20),
            padding: EdgeInsets.all(10),
            child: Text('Kutu 3'),
          ),
        ],
      ),
    );
  }
}
