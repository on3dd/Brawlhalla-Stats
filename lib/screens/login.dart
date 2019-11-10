import 'package:flutter/material.dart';
import 'package:brawlhalla_stats/scoped_models/main.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:brawlhalla_stats/screens/home.dart';

class LoginPage extends StatelessWidget {
  final textFieldController = TextEditingController(text: "76561198160383400");

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textFieldController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'assets/images/brawlhalla_logo.png',
            fit: BoxFit.cover,
            height: 40,
          ),
          centerTitle: true,
        ),
        body: ScopedModelDescendant<MainModel>(
          builder: (BuildContext context, Widget child, MainModel model) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Get Brawlhalla ID",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Container(
                  width: 250,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: TextField(
                    controller: textFieldController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter your Steam ID",
                    ),
                  ),
                ),
                RaisedButton(
                  onPressed: () => model
                      .getBrawlhallaID(textFieldController.text)
                      .then((res) => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyHomePage()))
                          }),
                  child: Text(
                    "Submit",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  color: Colors.blue,
                ),
              ],
            ));
          },
        ));
  }
}
