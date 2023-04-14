import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottery/module/color/color.dart';
import 'package:lottery/module/page/edit/view.dart';
import 'package:lottery/module/page/lottery/LotteryPage.dart';

import 'logic.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logic = Get.put(MainLogic());

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('曹老师有很多问题')),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MaterialButton(
            onPressed: () {
              Get.to(() => LotteryPage());
            },
            //主题色
            textColor: Colors.white,
            color: MyColor.primary,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 100),
              child: Text('抽奖'),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          MaterialButton(
            onPressed: () {
              Get.to(() => EditPage());
            },
            textColor: Colors.white,
            color: MyColor.primary,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 100),
              child: Text('编辑'),
            ),
          ),
        ],
      )),
    );
  }
}
