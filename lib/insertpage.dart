import 'package:flutter/material.dart';
import 'package:sqlflitedatabase/datasetter.dart';
import 'package:sqlflitedatabase/viewpage.dart';

class insertpage extends StatefulWidget {
  const insertpage({Key? key}) : super(key: key);

  @override
  State<insertpage> createState() => _insertpageState();
}

class _insertpageState extends State<insertpage> {
  TextEditingController tname = TextEditingController();
  TextEditingController tcontact = TextEditingController();

  bool namestatus = false;
  String? contactvalue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1e847f),
        title: Text('Data base'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: tname,
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.person,
                    color: Color(0xffecc19c),
                  ),
                  border: OutlineInputBorder(),
                  hintText: 'Name',
                  errorText: namestatus ? 'Enter name' : null),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: tcontact,
              maxLength: 10,
              decoration: InputDecoration(
                  hintText: 'Contact',
                  prefixIcon: Icon(
                    Icons.call,
                    color: Color(0xffecc19c),
                  ),
                  border: OutlineInputBorder(),
                  errorText: contactvalue),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () async {
                  String name = tname.text;
                  String contact = tcontact.text;

                  if (name.isEmpty) {
                    namestatus = true;
                    setState(() {});
                  } else if (contact.length < 10) {
                    contactvalue = 'Enter valid number';
                    setState(() {});
                  } else {
                    String insertqry =
                        "insert into contct (name,contact) values('$name','$contact')";
                    int a = await dbhelper.database!.rawInsert(insertqry);
                    print(a);
                    if (a > 0) {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return viewpage();
                        },
                      ));
                    } else {
                      AlertDialog(
                        title: Text('try again'),
                      );
                    }
                  }
                },
                child: Text('Save'),
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                  Color(0xff1e847f),
                ))),
          ),
        ],
      ),
    );
  }
}
