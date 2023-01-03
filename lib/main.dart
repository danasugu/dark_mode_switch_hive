import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

const darkModeBox = 'darkModeTutorial';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox(darkModeBox);

  // open box
  var box = await Hive.openBox('crudBox');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _myCrudBox = Hive.box('crudBox');

  // write data
  void writeData() {
    _myCrudBox.put('name', 'John Doe');
    _myCrudBox.put('age', 20);
    _myCrudBox.put('isStudent', true);
  }

  // read data
  void readData() {
    _myCrudBox.get('name');
    _myCrudBox.get('age');
    _myCrudBox.get('isStudent');
    print(_myCrudBox.get('name'));
    print(_myCrudBox.get('age'));
  }

  //delete data
  void deleteData() {
    _myCrudBox.delete('name');
    _myCrudBox.delete('age');
    _myCrudBox.delete('isStudent');
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box(darkModeBox).listenable(),
      builder: (context, box, widget) {
        var darkMode = box.get('darkMode', defaultValue: false);
        return MaterialApp(
          theme: ThemeData(useMaterial3: true),
          debugShowCheckedModeBanner: false,
          themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
          darkTheme: ThemeData.dark(useMaterial3: true),
          home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.pink,
              elevation: 0,
              title: const Text('Dark Mode Switch'),
              actions: [
                Switch(
                  value: darkMode,
                  onChanged: (val) {
                    box.put('darkMode', !darkMode);
                  },
                )
              ],
            ),
            body: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: writeData,
                  child: const Text('Write'),
                ),
                ElevatedButton(
                  onPressed: readData,
                  child: const Text('Read'),
                ),
                ElevatedButton(
                  onPressed: deleteData,
                  child: const Text('Delete'),
                ),
              ],
            )),
          ),
        );
      },
    );
  }
}
