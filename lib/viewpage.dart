import 'package:flutter/material.dart';
import 'package:sqlflitedatabase/datasetter.dart';
import 'package:sqlflitedatabase/insertpage.dart';
import 'package:sqlflitedatabase/upadatedata.dart';

class viewpage extends StatefulWidget {
  const viewpage({Key? key}) : super(key: key);

  @override
  State<viewpage> createState() => _viewpageState();
}

class _viewpageState extends State<viewpage> {
  List<Map<String, Object?>> l = [];
  bool status = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    datasetter();
  }

  datasetter() async {
    String qur = ' select * from contct';

    List<Map<String, Object?>> l1 = await dbhelper.database!.rawQuery(qur);
    l.addAll(l1);
    print(l);
    status = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String? nameimg;

    return status
        ? Scaffold(
      appBar: AppBar(
        title: Text(
          'Contact',
          style: TextStyle(color: Color(0xffecc19c)),
        ),
        backgroundColor: Color(0xff1e847f),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xff1e847f),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return insertpage();
              },
            ));
          },
          child: Icon(
            Icons.add,
            color: Color(0xffecc19c),
          )),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) {
                  return updatedata();
                },));
              },
              leading: CircleAvatar(
                backgroundColor: Color(0xff1e847f),
                child: Text(
                  l[index]['name']
                      .toString()
                      .isEmpty
                      ? '*'
                      : '${l[index]['name'].toString()
                      .substring(0, 1)
                      .toUpperCase()}',
                  style: TextStyle(color: Color(0xffecc19c)),
                ),
              ),
              title: Text('${l![index]['name']}'),
              subtitle: Text('${l![index]['contact']}'),
              trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      deletdata(index);
                    });
                  },
                  icon: Icon(Icons.delete)),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(height: 10, color: Color(0xffecc19c));
          },
          itemCount: l!.length),
    )
        : CircularProgressIndicator();
  }

  deletdata(int index) async {
    String a = l[index]['id'].toString();

    await dbhelper.database!
        .rawDelete('DELETE FROM contct WHERE  id= ?', ['$a']);
    setState(() {
      l.removeAt(index);
    });
  }
}
