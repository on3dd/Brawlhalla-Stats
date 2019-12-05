import 'package:brawlhalla_stats/helpers/timestamp_formatter.dart';
import 'package:flutter/material.dart';
import 'package:brawlhalla_stats/scoped_models/main.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:brawlhalla_stats/helpers/center_horizontal.dart';
import 'package:brawlhalla_stats/helpers/capitalize.dart';

class ClanPage extends StatelessWidget {
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
												Text('${model.clan.name}',
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
																			fontWeight: FontWeight.w600, fontSize: 28)),
														],
													)),
													CenterHorizontal(Row(
														children: <Widget>[
															Text('${formatTimestamp(model.clan.createdAt)}',
																	style: TextStyle(
																			fontWeight: FontWeight.w400, fontSize: 24)),
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
																			fontWeight: FontWeight.w600, fontSize: 28)),
														],
													)),
													CenterHorizontal(Row(
														children: <Widget>[
															Text('${model.clan.xp} xp',
																	style: TextStyle(
																			fontWeight: FontWeight.w400, fontSize: 24)),
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
																			fontWeight: FontWeight.w600, fontSize: 28)),
														],
													)),
													SizedBox(
														height: 400,
														child: ListView.separated(
																separatorBuilder: (context, index) =>
																		Divider(color: Colors.grey),
																scrollDirection: Axis.vertical,
																shrinkWrap: true,
																itemCount: model.clan.members.length,
																itemBuilder: (BuildContext context, int index) {
																	return ListTile(
																		leading: CircleAvatar(
																			backgroundImage: AssetImage(
																					model.clan.members[index].picture),
																			backgroundColor: Colors.blue,
																		),
																		title: Text(
																			'${model.clan.members[index].name}',
																			style: TextStyle(
																				fontSize: 20,
																				fontWeight: FontWeight.normal,
																			),
																		),
																		subtitle: Text(
																			'${model.clan.members[index].rank}, ${model.clan.members[index].xp} xp',
																			style: TextStyle(
																				fontSize: 16,
																				fontWeight: FontWeight.w400,
																			),
																		),
																		trailing: Icon(Icons.keyboard_arrow_right),
																		onTap: () {
																			print(
																					'${model.clan.members[index].name} was pressed');
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
