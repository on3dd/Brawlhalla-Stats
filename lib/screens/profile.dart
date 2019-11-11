import 'package:flutter/material.dart';
import 'package:brawlhalla_stats/scoped_models/main.dart';
import 'package:scoped_model/scoped_model.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Scaffold(
          appBar: AppBar(
            title: Image.asset(
              'assets/images/brawlhalla_logo.png',
              fit: BoxFit.cover,
              height: 40,
            ),
            centerTitle: true,
          ),
          body: Container(
						margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
							children: <Widget>[
								Row(
									children: <Widget>[
										Text('${model.player.name}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36)),
									],
								),
								Row(
									children: <Widget>[
										Text('${model.player.clan.name}', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24)),
									],
								),
//								Text('${model.player.name}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36)),
//								Text('${model.player.clan.name}', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24)),
							],
						),
          ));
    });
  }
}
