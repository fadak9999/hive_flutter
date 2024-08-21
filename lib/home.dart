import 'package:flutter/material.dart';
import 'package:hive_flutter/main.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //////
  List<List<String>> _textsList = [];

  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

//! Hive
  void _loadData() {
    // استرجاع البيانات المخزنة في Hive
    setState(() {
      _textsList = List<List<String>>.from(
          mybox?.get('textsList', defaultValue: []) ??
              []); //???????????????????
    });
  }

//?    ------Add------
  void _addTexts() {
    String text1 = _controller1.text;
    String text2 = _controller2.text;
    String text3 = _controller3.text;

    if (text1.isNotEmpty && text2.isNotEmpty && text3.isNotEmpty) {
      setState(() {
        _textsList.add([text1, text2, text3]);
        //?
        mybox?.put('textsList', _textsList); // تخزين النصوص في Hive

        _controller1.clear();
        _controller2.clear();
        _controller3.clear();
      });
    }
  }

////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(129, 1, 179, 161),
        title: const Text("Text Storage with Hive"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            //
            TextField(
              controller: _controller1,
              decoration: const InputDecoration(labelText: 'Enter first text'),
            ),
            //
            TextField(
              controller: _controller2,
              decoration: const InputDecoration(labelText: 'Enter second text'),
            ),
            TextField(
              controller: _controller3,
              decoration: const InputDecoration(labelText: 'Enter third text'),
            ),
            //
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addTexts,
              child: const Text('Add Texts'),
            ),
            const SizedBox(height: 20),
            //
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // عدد الأعمدة في GridView
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: _textsList.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 10,
                    color: const Color.fromARGB(131, 95, 183, 158),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(_textsList[index][0],
                              textAlign: TextAlign.center),
                          const SizedBox(height: 5),
                          Text(_textsList[index][1],
                              textAlign: TextAlign.center),
                          const SizedBox(height: 5),
                          Text(_textsList[index][2],
                              textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
