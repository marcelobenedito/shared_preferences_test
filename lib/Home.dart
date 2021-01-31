import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _savedText = "Nothing was saved!";
  TextEditingController _controllerTextField = TextEditingController();

  _save() async {
    String typedValue = _controllerTextField.text;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("name", typedValue);
    print("operation (save): $typedValue");
  }

  _read() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedText = prefs.getString("name") ?? "No value";
    });
    print("operation (read): $_savedText");
  }

  _remove() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("name");
    print("operation (remove)");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Manipulation"),
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: [
            Text(
              _savedText,
              style: TextStyle(
                fontSize: 20
              ),
            ),
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Type something"
              ),
              controller: _controllerTextField,
            ),
            Row(
              children: [
                RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Save",
                    style: TextStyle(
                      fontSize: 20
                    ),
                  ),
                  onPressed: _save,
                ),
                RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Read",
                    style: TextStyle(
                        fontSize: 20
                    ),
                  ),
                  onPressed: _read,
                ),
                RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Remove",
                    style: TextStyle(
                        fontSize: 20
                    ),
                  ),
                  onPressed: _remove,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
