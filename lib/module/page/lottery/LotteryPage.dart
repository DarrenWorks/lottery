import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LotteryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LotteryPageState();
  }
}

class LotteryPageState extends State<LotteryPage> {
  List<String> _sentence = [];
  SharedPreferences? _sp;

  String lottery = "------------------------------";

  @override
  initState() {
    super.initState();

    SharedPreferences.getInstance().then((value) {
      setState(() {
        _sp = value;
        _sentence.addAll(_sp?.getStringList("sentence") ?? []);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (AppBar(
        title: const Center(child: Text("抽奖")),
      )),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(lottery, style: const TextStyle(fontSize: 25),),
            ),
            MaterialButton(
              onPressed: () {
                setState(() {
                  lottery = _sentence[Random().nextInt(_sentence.length)];
                });
              },
              color: Colors.blue,
              textColor: Colors.white,
              child: const Text("抽奖"),
            )
          ],
        ),
      ),
    );
  }
}
