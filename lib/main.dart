import 'package:flutter/material.dart';

import 'package:brawlhalla_stats/scoped_models/main.dart';
import 'package:brawlhalla_stats/screens/home.dart';
import 'package:scoped_model/scoped_model.dart';

// TODO: Hide api key

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MainModel _model = MainModel();
		_model.init(context);

    return ScopedModel<MainModel> (
      model: _model,
      child: MaterialApp(
        title: 'Brawlhalla Stats',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Brawlhalla Stats'),
      )
    );
  }
}
