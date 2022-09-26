import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];
  String? selectedValue;

  final List<String> genderItems = [
    'Male',
    'Female',
  ];

  String? secondSelectedValue;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(actions: [
        IconButton(icon: Icon(Icons.help_outline), onPressed: () {})
      ]), */
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.assignment, size: 50),
            Text('TEAM HAW.',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
            const SizedBox(height: 50),
            DropdownButton2(
              hint: Text(
                '地区を選んでください',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).hintColor,
                ),
              ),
              items: items
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                  .toList(),
              value: selectedValue,
              onChanged: (value) {
                setState(() {
                  selectedValue = value as String;
                });
              },
              buttonHeight: 40,
              buttonWidth: 200,
              itemHeight: 40,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 400,
              child: DropdownButtonFormField2(
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                isExpanded: true,
                hint: const Text(
                  '町内会を選んでください',
                  style: TextStyle(fontSize: 14),
                ),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black45,
                ),
                iconSize: 30,
                buttonHeight: 50,
                buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                ),
                items: genderItems
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                    .toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Please select gender.';
                  }
                },
                onChanged: (value) {
                  //Do something when changing the item if you want.
                },
                onSaved: (value) {
                  secondSelectedValue = value.toString();
                },
              ),
            ),
            const SizedBox(height: 30),
            OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SubPage()),
                  );
                },
                child: Text(
                  '連携せずにログイン',
                  style: TextStyle(color: Colors.black54),
                )),
            const SizedBox(height: 50),
            _snsButton("LINE", 0xff06c755),
            const SizedBox(height: 20),
            _snsButton("Facebook", 0xff3b5998),
          ],
        ),
      ),
    );
  }
}

/*
colorは0x[透明度][R][G][B]と記述　
ex) 0xffffffff -> 真っ白
*/
Widget _snsButton(String snsName, int color) {
  return SizedBox(
      height: 40,
      child: ElevatedButton(
        onPressed: () => {},
        child: Text('${snsName}でログイン'),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color(color))),
      ));
}
