import 'package:brawlhalla_stats/helpers/timestamp_formatter.dart';
import 'package:flutter/material.dart';
import 'package:brawlhalla_stats/scoped_models/main.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:brawlhalla_stats/helpers/center_horizontal.dart';
import 'package:brawlhalla_stats/helpers/capitalize.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:brawlhalla_stats/classes/clan.dart';
import 'package:brawlhalla_stats/screens/profile.dart';

class ClanPage extends StatelessWidget {
  final int id;

  ClanPage({Key key, @required this.id}) : super(key: key);

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
          body: FutureBuilder(
            future: model.getClanInfo(this.id),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                case ConnectionState.active:
                  return Center(
                      child: SpinKitRing(color: Colors.blue, size: 100.0));
                case ConnectionState.done:
                  if (snapshot.hasError)
                    return Text("There was an error: ${snapshot.error}");
                  Clan clan = snapshot.data;
                  return SingleChildScrollView(
                      child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: Column(
                      children: <Widget>[
                        CenterHorizontal(Row(
                          children: <Widget>[
                            Text('${clan.name}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 36)),
                          ],
                        )),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Column(
                            children: <Widget>[
                              CenterHorizontal(Row(
                                children: <Widget>[
                                  Text('Created at',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 28)),
                                ],
                              )),
                              CenterHorizontal(Row(
                                children: <Widget>[
                                  Text(
                                      '${formatTimestamp(clan.createdAt)}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 24)),
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
                                  Text('Total xp',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 28)),
                                ],
                              )),
                              CenterHorizontal(Row(
                                children: <Widget>[
                                  Text('${clan.xp} xp',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 24)),
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
                                  Text('Members',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 28)),
                                ],
                              )),
                              SizedBox(
                                height: 400,
                                child: ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        Divider(color: Colors.grey),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: clan.members.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ListTile(
                                        leading: CircleAvatar(
                                          backgroundImage: AssetImage(clan.members[index].picture),
                                          backgroundColor: Colors.blue,
                                        ),
                                        title: Text(
                                          '${clan.members[index].name}',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        subtitle: Text(
                                          '${clan.members[index].rank}, ${clan.members[index].xp} xp',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        trailing:
                                            Icon(Icons.keyboard_arrow_right),
                                        onTap: () {
																					Navigator.push(
																							context,
																							MaterialPageRoute(
																									builder: (context) => ProfilePage(id: clan.members[index].id)));
                                        },
                                      );
                                    }),
                              )
                            ]))
                      ],
                    ),
                  ));
              }
							return SpinKitRing(color: Colors.blue, size: 100.0);
            },
          ));
    });
  }
}
