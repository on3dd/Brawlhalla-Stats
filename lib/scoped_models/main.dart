import 'package:brawlhalla_stats/classes/clan.dart';
import 'package:brawlhalla_stats/classes/clan_member.dart';
import 'package:brawlhalla_stats/classes/legend.dart';
import 'package:brawlhalla_stats/classes/legend_ranked.dart';
import 'package:brawlhalla_stats/classes/player_clan.dart';
import 'package:brawlhalla_stats/classes/ranked.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:brawlhalla_stats/classes/player.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class MainModel extends Model {
  String _apiKey;
  String _steamId;

  void init(BuildContext context) async {
    String data =
        await DefaultAssetBundle.of(context).loadString("assets/config.json");
    var jsonResult = json.decode(data);
    this._apiKey = jsonResult['api_key'];
  }

  Future<int> getBrawlhallaID(String steamID) async {
    this._steamId = steamID;

    http.Response response = await http.get(
        Uri.encodeFull(
            "https://api.brawlhalla.com/search?steamid=$_steamId&api_key=$_apiKey"),
        headers: {"Accept": "application/json"});

    var data = jsonDecode(response.body);
    return data['brawlhalla_id'];
  }

  Future<Player> getPlayerStats(int id) async {
    http.Response firstResponse = await http.get(
        Uri.encodeFull(
            "https://api.brawlhalla.com/player/$id/stats?api_key=$_apiKey"),
        headers: {"Accept": "application/json"});

    var totalData = jsonDecode(firstResponse.body);

    List<Legend> totalLegends = [];
    for (final legend in totalData['legends']) {
      totalLegends.add(new Legend(
        legend['legend_id'],
        legend['legend_name_key'],
        legend['kos'],
        legend['falls'],
        legend['games'],
        legend['wins'],
        legend['level'],
        'assets/images/legends/${legend['legend_name_key']}.png',
      ));
    }
    totalLegends.sort((a, b) => b.level.compareTo(a.level));

    PlayerClan clan = new PlayerClan(
      totalData['clan']['clan_name'],
      totalData['clan']['clan_id'],
      totalData['clan']['clan_xp'],
      totalData['clan']['personal_xp'],
    );

    http.Response secondResponse = await http.get(
        Uri.encodeFull(
            "https://api.brawlhalla.com/player/$id/ranked?api_key=$_apiKey"),
        headers: {"Accept": "application/json"});

    var rankedData = jsonDecode(secondResponse.body);

    List<LegendRanked> rankedLegends = [];
    for (final legend in rankedData['legends']) {
      rankedLegends.add(new LegendRanked(
        legend['legend_id'],
        legend['legend_name_key'],
        'assets/images/legends/${legend['legend_name_key']}.png',
        legend['rating'],
        legend['peak_rating'],
        legend['tier'],
        legend['wins'],
        legend['games'],
      ));
    };
		rankedLegends.sort((a, b) => b.games.compareTo(a.games));

    Ranked ranked = new Ranked(
      rankedData['rating'],
      rankedData['peak_rating'],
      rankedData['tier'],
      'assets/images/ranked_ranks/${rankedData['tier'].split(' ')[0]}.png',
      rankedData['games'],
      rankedData['wins'],
      rankedData['region'],
      rankedData['global_rank'],
      rankedData['region_rank'],
      rankedLegends,
    );

    Player p = new Player(
      totalData['brawlhalla_id'],
      totalData['name'],
			totalData['xp'],
      totalData['level'],
      totalData['xp_percentage'],
      totalData['games'],
      totalData['wins'],
      totalLegends,
      clan,
      ranked,
    );

    return p;
  }

  Future<Clan> getClanInfo(int id) async {
    http.Response response = await http.get(
        Uri.encodeFull(
            "https://api.brawlhalla.com/clan/${id}/?api_key=$_apiKey"),
        headers: {"Accept": "application/json"});

    var data = jsonDecode(response.body);

    List<ClanMember> members = [];
    for (final member in data['clan']) {
      members.add(new ClanMember(
        member['brawlhalla_id'],
        member['name'],
        member['rank'],
        'assets/images/clan_ranks/${member['rank']}.png',
        member['join_date'],
        member['xp'],
      ));
    }
    members.sort((a, b) => a.joinDate.compareTo(b.joinDate));

    Clan c = new Clan(
      data['clan_id'],
      data['clan_name'],
      data['clan_create_date'],
      data['clan_xp'],
      members,
    );

    return c;
  }

  double calculateWinrate(int wins, games) {
    return wins / games * 100;
  }

//  Color getWinrateColor() {
//    var wr = this._player.wins / this._player.games * 100;
//    if (wr <= 25.0)
//      return Colors.red;
//    else if (wr >= 25.0 && wr <= 50.0)
//      return Colors.orange;
//    else if (wr >= 50.0 && wr <= 75.0)
//      return Colors.lightGreen;
//    else
//      return Colors.green;
//  }
}
