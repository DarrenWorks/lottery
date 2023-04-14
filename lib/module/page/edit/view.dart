import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../color/color.dart';

class EditPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EditPageState();
  }
}

class EditPageState extends State<EditPage> {
  var _controller = TextEditingController();
  List<String> _sentence = [];

  SharedPreferences? _sp;

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
      appBar: AppBar(
        title: const Center(child: Text("曹老师病历本")),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextField(
                controller: _controller,
              ),
            ),
            MaterialButton(
              textColor: Colors.white,
              color: MyColor.primary,
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  setState(() {
                    _sentence.add(_controller.text);
                    _controller.text = "";
                    _updateSentence();
                  });
                }
              },
              child: const Text("添加"),
            ),
            const SizedBox(
              height: 10,
            ),
            _sentence.isEmpty
                ? const Text("空空如也")
                : Expanded(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _sentence.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _sentenceWidget(index);
                        },
                      ),
                    ),
                ),
          ],
        ),
      ),
    );
  }

  _sentenceWidget(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Text(_sentence[index])),
          MaterialButton(
            onPressed: () {
              setState(() {
                _sentence.removeWhere((element) => element == _sentence[index]);
                _updateSentence();
              });
            },
            color: MyColor.primary,
            textColor: Colors.white,
            child: const Text("删除"),
          ),
        ],
      ),
    );
  }

  _updateSentence() {
    _sp?.setStringList("sentence", _sentence);
  }
}
