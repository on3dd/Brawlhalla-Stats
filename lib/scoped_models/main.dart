import 'package:brawlhalla_stats/classes/legend.dart';
import 'package:brawlhalla_stats/classes/clan.dart';
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
  int _brawlhallaId;
  Player _player;

  void init(BuildContext context) async {
    String data =
        await DefaultAssetBundle.of(context).loadString("assets/config.json");
    var jsonResult = json.decode(data);
    this._apiKey = jsonResult['api_key'];
  }

  int get brawlhallaId => _brawlhallaId;

  Future<bool> getBrawlhallaID(String steamID) async {
    this._steamId = steamID;

    http.Response response = await http.get(
        Uri.encodeFull(
            "https://api.brawlhalla.com/search?steamid=$_steamId&api_key=$_apiKey"),
        headers: {"Accept": "application/json"});

    var data = jsonDecode(response.body);
    this._brawlhallaId = data['brawlhalla_id'];

    return true;
  }

  Player get player => _player;

  Future<bool> getPlayerStats() async {
    http.Response response = await http.get(
        Uri.encodeFull(
            "https://api.brawlhalla.com/player/$_brawlhallaId/stats?api_key=$_apiKey"),
        headers: {"Accept": "application/json"});

    var data = jsonDecode(response.body);

    List<Legend> legends = [];
    for (final legend in data['legends']) {
      legends.add(new Legend(
        legend['legend_id'],
        legend['legend_name_key'],
        legend['kos'],
        legend['falls'],
        legend['games'],
        legend['wins'],
        legend['level'],
				'assets/images/legends/${legend['legend_name_key']}.png'
      ));
    }

    legends.sort((a, b) => b.level.compareTo(a.level));

    Clan clan = new Clan(
      data['clan']['clan_name'],
      data['clan']['clan_id'],
      data['clan']['clan_xp'],
      data['clan']['personal_xp'],
    );

    this._player = new Player(
      data['brawlhalla_id'],
      data['name'],
      data['level'],
      data['xp_percentage'],
      data['games'],
      data['wins'],
      legends,
      clan,
    );

    return true;
  }

  double calculateWinrate() {
    return this._player.wins / this._player.games * 100;
  }

  Color getWinrateColor() {
    var wr = this._player.wins / this._player.games * 100;
    if (wr <= 25.0)
      return Colors.red;
    else if (wr >= 25.0 && wr <= 50.0)
      return Colors.orange;
    else if (wr >= 50.0 && wr <= 75.0)
      return Colors.lightGreen;
    else
      return Colors.green;
  }
}
