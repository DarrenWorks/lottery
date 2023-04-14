import 'dart:math';

import 'package:flutter/material.dart';
import 'package:luckywheel/luckywheel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LotteryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LotteryPageState();
  }
}

class LotteryPageState extends State<LotteryPage>
    with TickerProviderStateMixin {
  List<String> _sentence = [];
  SharedPreferences? _sp;
  var _result = "_______________";

  late LuckyWheelController _wheelController;

  @override
  initState() {
    super.initState();

    SharedPreferences.getInstance().then((value) {
      setState(() {
        _sp = value;
        _sentence.addAll(_sp?.getStringList("sentence") ?? []);

        _wheelController = LuckyWheelController(
            vsync: this,
            totalParts: _sentence.length,
            rotateDuration: 1000,
            stopDuration: 3000,
            onRotationEnd: (index) {
              setState(() {
                _result = _sentence[index];
              });
            });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (AppBar(
        title: const Center(child: Text("曹老师有很多问题")),
      )),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Stack(
                children: [
                  LuckyWheel(
                    controller: _wheelController,
                    onResult: (result) {
                      setState(() {
                        _result = _sentence[result];
                      });
                    },
                    child: SpinningWidget(
                        width: 300, height: 300, totalParts: _sentence.length),
                    // child: Image.asset('images/wheel.png', width: 300, height: 300),
                  ),
                  Container(
                    width: 300,
                    height: 300,
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        _wheelController.reset();
                        _wheelController.start();
                        _wheelController.stop(
                            atIndex: Random().nextInt(_sentence.length));
                      },
                      child: Image.asset('assets/images/btn_rotate.png',
                          width: 64, height: 64),
                    ),
                  ),
                ],
              ),
            ),
            Text("下一个问题是： " + _result, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),),
          ],
        ),
      ),
    );
  }
}
