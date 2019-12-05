import 'package:flutter/material.dart';
import 'package:brawlhalla_stats/scoped_models/main.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:brawlhalla_stats/helpers/center_horizontal.dart';
import 'package:brawlhalla_stats/helpers/capitalize.dart';

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
          body: SingleChildScrollView(
              child: Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              children: <Widget>[
                CenterHorizontal(Row(
                  children: <Widget>[
                    Text('${model.player.name}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 36)),
                  ],
                )),
                CenterHorizontal(Row(
                  children: <Widget>[
                    Text('${model.player.clan.name}',
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 24)),
                  ],
                )),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Column(
                    children: <Widget>[
                      CenterHorizontal(Row(
                        children: <Widget>[
                          Text('${model.player.level} level',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 28)),
                        ],
                      )),
                      CenterHorizontal(Row(
                        children: <Widget>[
                          new LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width - 50,
                            animation: true,
                            lineHeight: 20.0,
                            animationDuration: 1000,
                            percent: model.player.xp_percentage,
                            center: Text(
                                model.player.xp_percentage.toStringAsFixed(2) +
                                    "%",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400)),
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            progressColor: Colors.green,
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Column(
                    children: <Widget>[
                      CenterHorizontal(Row(
                        children: <Widget>[
                          Text('${model.player.games} games',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 28)),
                        ],
                      )),
                      CenterHorizontal(Row(
                        children: <Widget>[
                          new CircularPercentIndicator(
                            radius: 200,
                            lineWidth: 20.0,
                            animationDuration: 1000,
                            percent: model.player.wins / model.player.games,
                            center: new Text(
                              '${model.calculateWinrate()}% \n WINRATE',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 20,
                              ),
                            ),
                            progressColor: Colors.green,
                          )
                        ],
                      )),
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Column(children: <Widget>[
                      CenterHorizontal(Row(
                        children: <Widget>[
                          Text('Legends',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 28)),
                        ],
                      )),
                      SizedBox(
												height: 400,
												child: ListView.separated(
														separatorBuilder: (context, index) => Divider(
																color: Colors.grey
														),
														scrollDirection: Axis.vertical,
														shrinkWrap: true,
														itemCount: model.player.legends.length,
														itemBuilder: (BuildContext context, int index) {
															return ListTile(
																leading: CircleAvatar(
																	backgroundImage: AssetImage(
																			model.player.legends[index].picture),
																	backgroundColor: Colors.blue,
																),
																title: Text(
																	capitalize(model.player.legends[index].name),
																	style: TextStyle(
																		fontSize: 20,
																		fontWeight: FontWeight.normal,
																	),
																),
																subtitle: Text(
																	'${model.player.legends[index].level} level, ${model.player.legends[index].games} games',
																	style: TextStyle(
																		fontSize: 16,
																		fontWeight: FontWeight.w400,
																	),
																),
																trailing: Icon(Icons.keyboard_arrow_right),
																onTap: () {
																	print('${capitalize(model.player.legends[index].name)} was pressed');
																},
															);
														}),
											)
                    ]))
              ],
            ),
          )));
    });
  }
}
